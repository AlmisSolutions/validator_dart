import 'package:validator_dart/src/util/assert_string.dart';
import 'package:validator_dart/src/validators/is_byte_length.dart';
import 'package:validator_dart/src/validators/is_fqdn.dart';
import 'package:validator_dart/src/validators/is_ip.dart';

class EmailOptions {
  bool allowDisplayName;
  bool requireDisplayName;
  bool allowUtf8LocalPart;
  bool requireTld;
  String blacklistedChars;
  bool ignoreMaxLength;
  List<String> hostBlacklist;
  List<String> hostWhitelist;
  bool domainSpecificValidation;
  bool allowIpDomain;

  EmailOptions({
    this.allowDisplayName = false,
    this.requireDisplayName = false,
    this.allowUtf8LocalPart = true,
    this.requireTld = true,
    this.blacklistedChars = '',
    this.ignoreMaxLength = false,
    this.hostBlacklist = const [],
    this.hostWhitelist = const [],
    this.domainSpecificValidation = false,
    this.allowIpDomain = false,
  });
}

final RegExp splitNameAddress =
    RegExp(r'^([^\x00-\x1F\x7F-\x9F\cX]+)', caseSensitive: false);
final RegExp emailUserPart =
    RegExp(r'''^[a-z\d!#\$%&\'*+\-\/=\?\^_`{\|}~]+$''', caseSensitive: false);
final RegExp gmailUserPart = RegExp(r'^[a-z\d]+$');
final RegExp quotedEmailUser = RegExp(
    r'^([\s\x01-\x08\x0b\x0c\x0e-\x1f\x7f\x21\x23-\x5b\x5d-\x7e]|(\\[\x01-\x09\x0b\x0c\x0d-\x7f]))*$',
    caseSensitive: false);
final RegExp emailUserUtf8Part = RegExp(
    r'''^[a-z\d!#\$%&\'*+\-\/=\?\^_`{\|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+$''',
    caseSensitive: false);
final RegExp quotedEmailUserUtf8 = RegExp(
    r'^([\s\x01-\x08\x0b\x0c\x0e-\x1f\x7f\x21\x23-\x5b\x5d-\x7e\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|(\\[\x01-\x09\x0b\x0c\x0d-\x7f\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))*$',
    caseSensitive: false);
const int defaultMaxEmailLength = 254;

/*
 * Validate display name according to the RFC2822: https://tools.ietf.org/html/rfc2822#appendix-A.1.2
 * @param {String} display_name
 */
bool validateDisplayName(String displayName) {
  final displayNameWithoutQuotes = displayName.replaceAllMapped(
      RegExp(r'^"(.+)"$'), (match) => match.group(1)!);

  // display name with only spaces is not valid
  if (displayNameWithoutQuotes.trim().isEmpty) {
    return false;
  }

  // check whether display name contains illegal character
  final containsIllegal =
      RegExp(r'[\.";<>]').hasMatch(displayNameWithoutQuotes);
  if (containsIllegal) {
    // if contains illegal characters,
    // must to be enclosed in double-quotes, otherwise it's not a valid display name
    if (displayNameWithoutQuotes == displayName) {
      return false;
    }

    // the quotes in display name must start with character symbol \
    final allStartWithBackSlash = displayNameWithoutQuotes.split('"').length ==
        displayNameWithoutQuotes.split('\\"').length;
    if (!allStartWithBackSlash) {
      return false;
    }
  }

  return true;
}

bool $isEmail(String str, {EmailOptions? options}) {
  assertString(str);
  options ??= EmailOptions();

  if (options.requireDisplayName || options.allowDisplayName) {
    final displayEmail =
        RegExp(r'^([^\x00-\x1F\x7F-\x9F\cX]+)<').firstMatch(str);
    if (displayEmail != null) {
      String displayName = displayEmail[1]!;

      // Remove display name and angle brackets to get email address
      // Can be done in the regex but will introduce a ReDOS (See  #1597 for more info)
      str = str.replaceAll(displayName, '').replaceAll(RegExp(r'(^<|>$)'), '');

      // sometimes need to trim the last space to get the display name
      // because there may be a space between display name and email address
      // eg. myname <address@gmail.com>
      // the display name is `myname` instead of `myname `, so need to trim the last space
      if (displayName.endsWith(' ')) {
        displayName = displayName.substring(0, displayName.length - 1);
      }

      if (!validateDisplayName(displayName)) {
        return false;
      }
    } else if (options.requireDisplayName) {
      return false;
    }
  }
  if (options.ignoreMaxLength != true && str.length > defaultMaxEmailLength) {
    return false;
  }

  final parts = str.split('@');
  final domain = parts.removeLast();
  final lowerDomain = domain.toLowerCase();

  if (options.hostBlacklist.contains(lowerDomain)) {
    return false;
  }

  if (options.hostWhitelist.isNotEmpty &&
      !options.hostWhitelist.contains(lowerDomain)) {
    return false;
  }

  var user = parts.join('@');

  if (options.domainSpecificValidation &&
      (lowerDomain == 'gmail.com' || lowerDomain == 'googlemail.com')) {
    /*
      Previously we removed dots for gmail addresses before validating.
      This was removed because it allows `multiple..dots@gmail.com`
      to be reported as valid, but it is not.
      Gmail only normalizes single dots, removing them from here is pointless,
      should be done in normalizeEmail
    */
    user = user.toLowerCase();

    // Removing sub-address from username before gmail validation
    var username = user.split('+')[0];

    if (!$isByteLength(username.replaceAll(RegExp(r'\.'), ''),
        options: ByteLengthOptions(min: 6, max: 30))) {
      return false;
    }
    var userParts = username.split('.');
    for (var i = 0; i < userParts.length; i++) {
      if (!gmailUserPart.hasMatch(userParts[i])) {
        return false;
      }
    }
  }

  if (!options.ignoreMaxLength &&
      (!$isByteLength(user, options: ByteLengthOptions(max: 64)) ||
          !$isByteLength(domain, options: ByteLengthOptions(max: 254)))) {
    return false;
  }

  if (!$isFQDN(domain, options: FqdnOptions(requireTld: options.requireTld))) {
    if (!options.allowIpDomain) {
      return false;
    }

    if (!$isIP(domain)) {
      if (!domain.startsWith('[') || !domain.endsWith(']')) {
        return false;
      }

      var noBracketdomain = domain.substring(1, domain.length - 1);

      if (noBracketdomain.isEmpty || !$isIP(noBracketdomain)) {
        return false;
      }
    }
  }

  if (user.isNotEmpty && user[0] == '"') {
    user = user.substring(1, user.length - 1);
    return options.allowUtf8LocalPart
        ? quotedEmailUserUtf8.hasMatch(user)
        : quotedEmailUser.hasMatch(user);
  }

  final pattern =
      options.allowUtf8LocalPart ? emailUserUtf8Part : emailUserPart;

  final userParts = user.split('.');
  for (final userPart in userParts) {
    if (!pattern.hasMatch(userPart)) {
      return false;
    }
  }
  if (options.blacklistedChars.isNotEmpty) {
    if (user.contains(RegExp('[${options.blacklistedChars}]+'))) {
      return false;
    }
  }

  return true;
}
