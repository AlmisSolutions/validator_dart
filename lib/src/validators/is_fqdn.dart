import 'package:validator_dart/src/util/assert_string.dart';

class FqdnOptions {
  bool requireTld;
  bool allowUnderscores;
  bool allowTrailingDot;
  bool allowNumericTld;
  bool allowWildcard;

  FqdnOptions({
    this.requireTld = true,
    this.allowUnderscores = false,
    this.allowTrailingDot = false,
    this.allowNumericTld = false,
    this.allowWildcard = false,
  });
}

bool $isFQDN(dynamic str, {FqdnOptions? options}) {
  assertString(str);
  options ??= FqdnOptions();

  /* Remove the optional trailing dot before checking validity */
  if (options.allowTrailingDot && str[str.length - 1] == '.') {
    str = str.substring(0, str.length - 1);
  }

  /* Remove the optional wildcard before checking validity */
  if (options.allowWildcard == true && str.indexOf('*.') == 0) {
    str = str.substring(2);
  }

  final parts = str.split('.');
  final tld = parts[parts.length - 1];

  if (options.requireTld) {
    // disallow fqdns without tld
    if (parts.length < 2) {
      return false;
    }

    if (!options.allowNumericTld &&
        !RegExp(r'^([a-z\u00A1-\u00A8\u00AA-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]{2,}|xn[a-z0-9-]{2,})$',
                caseSensitive: false)
            .hasMatch(tld)) {
      return false;
    }

    // disallow spaces
    if (RegExp(r'\s').hasMatch(tld)) {
      return false;
    }
  }

  // reject numeric TLDs
  if (!options.allowNumericTld && RegExp(r'^\d+$').hasMatch(tld)) {
    return false;
  }

  return parts.every((part) {
    if (part.length > 63) {
      return false;
    }

    if (!RegExp(r'^[a-z_\u00a1-\uffff0-9-]+$', caseSensitive: false)
        .hasMatch(part)) {
      return false;
    }

    // disallow full-width chars
    if (RegExp(r'[\uff01-\uff5e]').hasMatch(part)) {
      return false;
    }

    // disallow parts starting or ending with hyphen
    if (RegExp(r'^-|-$').hasMatch(part)) {
      return false;
    }

    if (!options!.allowUnderscores && RegExp(r'_').hasMatch(part)) {
      return false;
    }

    return true;
  });
}
