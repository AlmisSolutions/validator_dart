import 'dart:convert';
import 'dart:math';

import 'package:validator_dart/extensions/list_extensions.dart';
import 'package:validator_dart/src/validators/contains.dart';
import 'package:validator_dart/src/validators/is_alpha.dart';
import 'package:validator_dart/src/validators/is_alphanumeric.dart';
import 'package:validator_dart/src/validators/is_base64.dart';
import 'package:validator_dart/src/validators/is_byte_length.dart';
import 'package:validator_dart/src/validators/is_decimal.dart';
import 'package:validator_dart/src/validators/is_email.dart';
import 'package:validator_dart/src/validators/is_empty.dart';
import 'package:validator_dart/src/validators/is_float.dart';
import 'package:validator_dart/src/validators/is_fqdn.dart';
import 'package:validator_dart/src/validators/is_imei.dart';
import 'package:validator_dart/src/validators/is_int.dart';
import 'package:validator_dart/src/validators/is_length.dart';
import 'package:validator_dart/src/validators/is_mac_address.dart';
import 'package:validator_dart/src/validators/is_numeric.dart';
import 'package:validator_dart/src/validators/is_url.dart';
import 'package:validator_dart/validator_dart.dart';
import 'package:test/test.dart';

import 'sanitizers_test.dart';

void validatorTest(Map<String, dynamic> options) {
  List<dynamic> args = (options['args'] as List? ?? []).map((e) => e).toList();

  args.insert(0, null);

  if (options['error'] != null) {
    options['error'].forEach((error) {
      args[0] = error;
      try {
        callMethod(options['validator'], args);
        String warning =
            'validator.${options['validator']}(${args.join(', ')}) passed but should error';
        throw Exception(warning);
      } on Exception catch (err) {
        if (err.toString().contains('passed but should error')) {
          rethrow;
        }
      }
    });
  }

  if (options['valid'] != null) {
    options['valid'].forEach((valid) {
      args[0] = valid;
      if (callMethod(options['validator'], args) != true) {
        String warning =
            'validator.${options['validator']}(${args.join(', ')}) failed but should have passed';
        throw Exception(warning);
      }
    });
  }

  if (options['invalid'] != null) {
    options['invalid'].forEach((invalid) {
      args[0] = invalid;
      if (callMethod(options['validator'], args) != false) {
        String warning =
            'validator.${options['validator']}(${args.join(', ')}) passed but should have failed';
        throw Exception(warning);
      }
    });
  }
}

dynamic callMethod(option, List args) {
  if (option == 'isEmail') {
    return Validator.isEmail(args.get(0), options: args.get(1));
  } else if (option == 'isURL') {
    return Validator.isURL(args.get(0), options: args.get(1));
  } else if (option == 'isMACAddress') {
    return Validator.isMACAddress(args.get(0), options: args.get(1));
  } else if (option == 'isIP') {
    return Validator.isIP(args.get(0), version: args.get(1));
  } else if (option == 'isIPRange') {
    return Validator.isIPRange(args.get(0), version: args.get(1));
  } else if (option == 'isFQDN') {
    return Validator.isFQDN(args.get(0), options: args.get(1));
  } else if (option == 'isAlpha') {
    return Validator.isAlpha(args.get(0),
        locale: args.get(1), options: args.get(2));
  } else if (option == 'isAlphanumeric') {
    return Validator.isAlphanumeric(args.get(0),
        locale: args.get(1), options: args.get(2));
  } else if (option == 'isNumeric') {
    return Validator.isNumeric(args.get(0), options: args.get(1));
  } else if (option == 'isPort') {
    return Validator.isPort(args.get(0));
  } else if (option == 'isDecimal') {
    return Validator.isDecimal(args.get(0), options: args.get(1));
  } else if (option == 'isPassportNumber') {
    return Validator.isPassportNumber(args.get(0), args.get(1));
  } else if (option == 'isLowercase') {
    return Validator.isLowercase(args.get(0));
  } else if (option == 'isIMEI') {
    return Validator.isIMEI(args.get(0), options: args.get(1));
  } else if (option == 'isUppercase') {
    return Validator.isUppercase(args.get(0));
  } else if (option == 'isInt') {
    return Validator.isInt(args.get(0), options: args.get(1));
  } else if (option == 'isFloat') {
    return Validator.isFloat(args.get(0), options: args.get(1));
  } else if (option == 'isHexadecimal') {
    return Validator.isHexadecimal(args.get(0));
  } else if (option == 'isOctal') {
    return Validator.isOctal(args.get(0));
  } else if (option == 'isHexColor') {
    return Validator.isHexColor(args.get(0));
  } else if (option == 'isHSL') {
    return Validator.isHSL(args.get(0));
  } else if (option == 'isRgbColor') {
    if (args.get(1) != null) {
      return Validator.isRgbColor(args.get(0),
          includePercentValues: args.get(1));
    } else {
      return Validator.isRgbColor(args.get(0));
    }
  } else if (option == 'isISRC') {
    return Validator.isISRC(args.get(0));
  } else if (option == 'isMD5') {
    return Validator.isMD5(args.get(0));
  } else if (option == 'isHash') {
    return Validator.isHash(args.get(0), args.get(1));
  } else if (option == 'isJWT') {
    return Validator.isJWT(args.get(0));
  } else if (option == 'isMongoId') {
    return Validator.isMongoId(args.get(0));
  } else if (option == 'isMongoId') {
    return Validator.isMongoId(args.get(0));
  } else if (option == 'isEmpty') {
    return Validator.isEmpty(args.get(0), options: args.get(1));
  } else if (option == 'equals') {
    return Validator.equals(args.get(0), args.get(1));
  } else if (option == 'contains') {
    return Validator.contains(args.get(0), args.get(1), options: args.get(2));
  } else if (option == 'matches') {
    return Validator.matches(args.get(0), args.get(1));
  } else if (option == 'isLength') {
    return Validator.isLength(args.get(0), options: args.get(1));
  } else if (option == 'isLocale') {
    return Validator.isLocale(args.get(0));
  } else if (option == 'isByteLength') {
    return Validator.isByteLength(args.get(0), options: args.get(1));
  } else if (option == 'isUUID') {
    return Validator.isUUID(args.get(0), version: args.get(1));
  } else if (option == 'isIn') {
    return Validator.isIn(args.get(0), args.get(1));
  } else if (option == 'isAfter') {
    return Validator.isAfter(args.get(0), args.get(1));
  } else if (option == 'isBefore') {
    return Validator.isBefore(args.get(0), args.get(1));
  } else if (option == 'isIBAN') {
    return Validator.isIBAN(args.get(0));
  } else if (option == 'isBIC') {
    return Validator.isBIC(args.get(0));
  } else if (option == 'isDivisibleBy') {
    return Validator.isDivisibleBy(args.get(0), args.get(1));
  } else if (option == 'isLuhnValid') {
    return Validator.isLuhnValid(args.get(0));
  } else if (option == 'isISO31661Alpha2') {
    return Validator.isISO31661Alpha2(args.get(0));
  } else if (option == 'isBase64') {
    return Validator.isBase64(args.get(0), options: args.get(1));
  }

  return null;
}

String repeat(String str, int count) {
  String result = '';
  for (; count > 0; count--) {
    result += str;
  }
  return result;
}

void main() {
  test('should validate email addresses', () {
    validatorTest({
      'validator': 'isEmail',
      'valid': [
        'foo@bar.com',
        'x@x.au',
        'foo@bar.com.au',
        'foo+bar@bar.com',
        'hans.m端ller@test.com',
        'hans@m端ller.com',
        'test|123@m端ller.com',
        'test123+ext@gmail.com',
        'some.name.midd.leNa.me.and.locality+extension@GoogleMail.com',
        '"foobar"@example.com',
        '"  foo  m端ller "@example.com',
        '"foo\\@bar"@example.com',
        '${repeat('a', 64)}@${repeat('a', 63)}.com',
        '${repeat('a', 64)}@${repeat('a', 63)}.com',
        '${repeat('a', 31)}@gmail.com',
        'test@gmail.com',
        'test.1@gmail.com',
        'test@1337.com',
      ],
      'invalid': [
        'invalidemail@',
        'invalid.com',
        '@invalid.com',
        'foo@bar.com.',
        'somename@ｇｍａｉｌ.com',
        'foo@bar.co.uk.',
        'z@co.c',
        'ｇｍａｉｌｇｍａｉｌｇｍａｉｌｇｍａｉｌｇｍａｉｌ@gmail.com',
        '${repeat('a', 64)}@${repeat('a', 251)}.com',
        '${repeat('a', 65)}@${repeat('a', 250)}.com',
        '${repeat('a', 64)}@${repeat('a', 64)}.com',
        '${repeat('a', 64)}@${repeat('a', 63)}.${repeat('a', 63)}.${repeat('a', 63)}.${repeat('a', 58)}.com',
        'test1@invalid.co m',
        'test2@invalid.co m',
        'test3@invalid.co m',
        'test4@invalid.co m',
        'test5@invalid.co m',
        'test6@invalid.co m',
        'test7@invalid.co m',
        'test8@invalid.co m',
        'test9@invalid.co m',
        'test10@invalid.co m',
        'test11@invalid.co m',
        'test12@invalid.co　m',
        'test13@invalid.co　m',
        'multiple..dots@stillinvalid.com',
        'test123+invalid! sub_address@gmail.com',
        'gmail...ignores...dots...@gmail.com',
        'ends.with.dot.@gmail.com',
        'multiple..dots@gmail.com',
        'wrong()[]",:;<>@@gmail.com',
        '"wrong()[]",:;<>@@gmail.com',
        'username@domain.com�',
        'username@domain.com©',
      ],
    });
  });

  test('should validate email addresses with domain specific validation', () {
    validatorTest({
      'validator': 'isEmail',
      'args': [
        EmailOptions(
          domainSpecificValidation: true,
        )
      ],
      'valid': [
        'foobar@gmail.com',
        'foo.bar@gmail.com',
        'foo.bar@googlemail.com',
        '${repeat('a', 30)}@gmail.com',
      ],
      'invalid': [
        '${repeat('a', 31)}@gmail.com',
        'test@gmail.com',
        'test.1@gmail.com',
        '.foobar@gmail.com',
      ],
    });
  });

  test('should validate email addresses without UTF8 characters in local part',
      () {
    validatorTest({
      'validator': 'isEmail',
      'args': [
        EmailOptions(
          allowUtf8LocalPart: false,
        )
      ],
      'valid': [
        'foo@bar.com',
        'x@x.au',
        'foo@bar.com.au',
        'foo+bar@bar.com',
        'hans@m端ller.com',
        'test|123@m端ller.com',
        'test123+ext@gmail.com',
        'some.name.midd.leNa.me+extension@GoogleMail.com',
        '"foobar"@example.com',
        '"foo\\@bar"@example.com',
        '"  foo  bar  "@example.com',
      ],
      'invalid': [
        'invalidemail@',
        'invalid.com',
        '@invalid.com',
        'foo@bar.com.',
        'foo@bar.co.uk.',
        'somename@ｇｍａｉｌ.com',
        'hans.m端ller@test.com',
        'z@co.c',
        'tüst@invalid.com',
      ],
    });
  });

  test('should validate email addresses with display names', () {
    validatorTest({
      'validator': 'isEmail',
      'args': [
        EmailOptions(
          allowDisplayName: true,
        )
      ],
      'valid': [
        'foo@bar.com',
        'x@x.au',
        'foo@bar.com.au',
        'foo+bar@bar.com',
        'hans.m端ller@test.com',
        'hans@m端ller.com',
        'test|123@m端ller.com',
        'test123+ext@gmail.com',
        'some.name.midd.leNa.me+extension@GoogleMail.com',
        'Some Name <foo@bar.com>',
        'Some Name <x@x.au>',
        'Some Name <foo@bar.com.au>',
        'Some Name <foo+bar@bar.com>',
        'Some Name <hans.m端ller@test.com>',
        'Some Name <hans@m端ller.com>',
        'Some Name <test|123@m端ller.com>',
        'Some Name <test123+ext@gmail.com>',
        '\'Foo Bar, Esq\'<foo@bar.com>',
        'Some Name <some.name.midd.leNa.me+extension@GoogleMail.com>',
        'Some Middle Name <some.name.midd.leNa.me+extension@GoogleMail.com>',
        'Name <some.name.midd.leNa.me+extension@GoogleMail.com>',
        'Name<some.name.midd.leNa.me+extension@GoogleMail.com>',
        'Some Name <foo@gmail.com>',
        'Name🍓With🍑Emoji🚴‍♀️🏆<test@aftership.com>',
        '🍇🍗🍑<only_emoji@aftership.com>',
        '"<displayNameInBrackets>"<jh@gmail.com>',
        '"\\"quotes\\""<jh@gmail.com>',
        '"name;"<jh@gmail.com>',
        '"name;" <jh@gmail.com>',
      ],
      'invalid': [
        'invalidemail@',
        'invalid.com',
        '@invalid.com',
        'foo@bar.com.',
        'foo@bar.co.uk.',
        'Some Name <invalidemail@>',
        'Some Name <invalid.com>',
        'Some Name <@invalid.com>',
        'Some Name <foo@bar.com.>',
        'Some Name <foo@bar.co.uk.>',
        'Some Name foo@bar.co.uk.>',
        'Some Name <foo@bar.co.uk.',
        'Some Name < foo@bar.co.uk >',
        'Name foo@bar.co.uk',
        'Some Name <some..name@gmail.com>',
        'Some Name<emoji_in_address🍈@aftership.com>',
        'invisibleCharacter\u001F<jh@gmail.com>',
        '<displayNameInBrackets><jh@gmail.com>',
        '\\"quotes\\"<jh@gmail.com>',
        '""quotes""<jh@gmail.com>',
        'name;<jh@gmail.com>',
        '    <jh@gmail.com>',
        '"    "<jh@gmail.com>',
      ],
    });
  });

  test('should validate email addresses with required display names', () {
    validatorTest({
      'validator': 'isEmail',
      'args': [
        EmailOptions(
          requireDisplayName: true,
        )
      ],
      'valid': [
        'Some Name <foo@bar.com>',
        'Some Name <x@x.au>',
        'Some Name <foo@bar.com.au>',
        'Some Name <foo+bar@bar.com>',
        'Some Name <hans.m端ller@test.com>',
        'Some Name <hans@m端ller.com>',
        'Some Name <test|123@m端ller.com>',
        'Some Name <test123+ext@gmail.com>',
        'Some Name <some.name.midd.leNa.me+extension@GoogleMail.com>',
        'Some Middle Name <some.name.midd.leNa.me+extension@GoogleMail.com>',
        'Name <some.name.midd.leNa.me+extension@GoogleMail.com>',
        'Name<some.name.midd.leNa.me+extension@GoogleMail.com>',
      ],
      'invalid': [
        'some.name.midd.leNa.me+extension@GoogleMail.com',
        'foo@bar.com',
        'x@x.au',
        'foo@bar.com.au',
        'foo+bar@bar.com',
        'hans.m端ller@test.com',
        'hans@m端ller.com',
        'test|123@m端ller.com',
        'test123+ext@gmail.com',
        'invalidemail@',
        'invalid.com',
        '@invalid.com',
        'foo@bar.com.',
        'foo@bar.co.uk.',
        'Some Name <invalidemail@>',
        'Some Name <invalid.com>',
        'Some Name <@invalid.com>',
        'Some Name <foo@bar.com.>',
        'Some Name <foo@bar.co.uk.>',
        'Some Name foo@bar.co.uk.>',
        'Some Name <foo@bar.co.uk.',
        'Some Name < foo@bar.co.uk >',
        'Name foo@bar.co.uk',
      ],
    });
  });

  test('should validate email addresses with allowed IPs', () {
    validatorTest({
      'validator': 'isEmail',
      'args': [
        EmailOptions(
          allowIpDomain: true,
        )
      ],
      'valid': [
        'email@[123.123.123.123]',
        'email@255.255.255.255',
      ],
      'invalid': [
        'email@0.0.0.256',
        'email@26.0.0.256',
        'email@[266.266.266.266]',
      ],
    });
  });

  test('should not validate email addresses with blacklisted chars in the name',
      () {
    validatorTest({
      'validator': 'isEmail',
      'args': [
        EmailOptions(
          blacklistedChars: 'abc',
        )
      ],
      'valid': [
        'emil@gmail.com',
      ],
      'invalid': [
        'email@gmail.com',
      ],
    });
  });

  test('should validate really long emails if ignore_max_length is set', () {
    validatorTest({
      'validator': 'isEmail',
      'args': [
        EmailOptions(
          ignoreMaxLength: false,
        )
      ],
      'valid': [],
      'invalid': [
        'Deleted-user-id-19430-Team-5051deleted-user-id-19430-team-5051XXXXXX@example.com',
      ],
    });

    validatorTest({
      'validator': 'isEmail',
      'args': [
        EmailOptions(
          ignoreMaxLength: true,
        )
      ],
      'valid': [
        'Deleted-user-id-19430-Team-5051deleted-user-id-19430-team-5051XXXXXX@example.com',
      ],
      'invalid': [],
    });
  });

  test('should not validate email addresses with denylisted domains', () {
    validatorTest({
      'validator': 'isEmail',
      'args': [
        EmailOptions(
          hostBlacklist: ['gmail.com', 'foo.bar.com'],
        )
      ],
      'valid': [
        'email@foo.gmail.com',
      ],
      'invalid': [
        'foo+bar@gmail.com',
        'email@foo.bar.com',
      ],
    });
  });

  test('should validate only email addresses with whitelisted domains', () {
    validatorTest({
      'validator': 'isEmail',
      'args': [
        EmailOptions(
          hostWhitelist: ['gmail.com', 'foo.bar.com'],
        )
      ],
      'valid': [
        'email@gmail.com',
        'test@foo.bar.com',
      ],
      'invalid': [
        'foo+bar@test.com',
        'email@foo.com',
        'email@bar.com',
      ],
    });
  });

  test('should validate URLs', () {
    validatorTest({
      'validator': 'isURL',
      'valid': [
        'foobar.com',
        'www.foobar.com',
        'foobar.com/',
        'valid.au',
        'http://www.foobar.com/',
        'HTTP://WWW.FOOBAR.COM/',
        'https://www.foobar.com/',
        'HTTPS://WWW.FOOBAR.COM/',
        'http://www.foobar.com:23/',
        'http://www.foobar.com:65535/',
        'http://www.foobar.com:5/',
        'https://www.foobar.com/',
        'ftp://www.foobar.com/',
        'http://www.foobar.com/~foobar',
        'http://user:pass@www.foobar.com/',
        'http://user:@www.foobar.com/',
        'http://:pass@www.foobar.com/',
        'http://user@www.foobar.com',
        'http://127.0.0.1/',
        'http://10.0.0.0/',
        'http://189.123.14.13/',
        'http://duckduckgo.com/?q=%2F',
        'http://foobar.com/t\$-_.+!*\'(),',
        'http://foobar.com/?foo=bar#baz=qux',
        'http://foobar.com?foo=bar',
        'http://foobar.com#baz=qux',
        'http://www.xn--froschgrn-x9a.net/',
        'http://xn--froschgrn-x9a.com/',
        'http://foo--bar.com',
        'http://høyfjellet.no',
        'http://xn--j1aac5a4g.xn--j1amh',
        'http://xn------eddceddeftq7bvv7c4ke4c.xn--p1ai',
        'http://кулік.укр',
        'test.com?ref=http://test2.com',
        'http://[FEDC:BA98:7654:3210:FEDC:BA98:7654:3210]:80/index.html',
        'http://[1080:0:0:0:8:800:200C:417A]/index.html',
        'http://[3ffe:2a00:100:7031::1]',
        'http://[1080::8:800:200C:417A]/foo',
        'http://[::192.9.5.5]/ipng',
        'http://[::FFFF:129.144.52.38]:80/index.html',
        'http://[2010:836B:4179::836B:4179]',
        'http://example.com/example.json#/foo/bar',
        'http://1337.com',
      ],
      'invalid': [
        'http://localhost:3000/',
        '//foobar.com',
        'xyz://foobar.com',
        'invalid/',
        'invalid.x',
        'invalid.',
        '.com',
        'http://com/',
        'http://300.0.0.1/',
        'mailto:foo@bar.com',
        'rtmp://foobar.com',
        'http://www.xn--.com/',
        'http://xn--.com/',
        'http://www.foobar.com:0/',
        'http://www.foobar.com:70000/',
        'http://www.foobar.com:99999/',
        'http://www.-foobar.com/',
        'http://www.foobar-.com/',
        'http://foobar/# lol',
        'http://foobar/? lol',
        'http://foobar/ lol/',
        'http://lol @foobar.com/',
        'http://lol:lol @foobar.com/',
        'http://lol:lol:lol@foobar.com/',
        'http://lol: @foobar.com/',
        'http://www.foo_bar.com/',
        'http://www.foobar.com/\t',
        'http://@foobar.com',
        'http://:@foobar.com',
        'http://\n@www.foobar.com/',
        '',
        'http://foobar.com/${List.filled(2083, 'f').join()}',
        'http://*.foo.com',
        '*.foo.com',
        '!.foo.com',
        'http://example.com.',
        'http://localhost:61500this is an invalid url!!!!',
        '////foobar.com',
        'http:////foobar.com',
        'https://example.com/foo/<script>alert(\'XSS\')</script>/',
      ],
    });
  });

  test('should validate URLs with custom protocols', () {
    validatorTest({
      'validator': 'isURL',
      'args': [
        UrlOptions(
          protocols: ['rtmp'],
        )
      ],
      'valid': [
        'rtmp://foobar.com',
      ],
      'invalid': [
        'http://foobar.com',
      ],
    });
  });

  test('should validate file URLs without a host', () {
    validatorTest({
      'validator': 'isURL',
      'args': [
        UrlOptions(
          protocols: ['file'],
          requireHost: false,
          requireTld: false,
        )
      ],
      'valid': [
        'file://localhost/foo.txt',
        'file:///foo.txt',
        'file:///',
      ],
      'invalid': [
        'http://foobar.com',
        'file://',
      ],
    });
  });

  test('should validate postgres URLs without a host', () {
    validatorTest({
      'validator': 'isURL',
      'args': [
        UrlOptions(
          protocols: ['postgres'],
          requireHost: false,
        )
      ],
      'valid': [
        'postgres://user:pw@/test',
      ],
      'invalid': [
        'http://foobar.com',
        'postgres://',
      ],
    });
  });

  test('should validate URLs with any protocol', () {
    validatorTest({
      'validator': 'isURL',
      'args': [
        UrlOptions(
          requireValidProtocol: false,
        )
      ],
      'valid': [
        'rtmp://foobar.com',
        'http://foobar.com',
        'test://foobar.com',
      ],
      'invalid': [
        'mailto:test@example.com',
      ],
    });
  });

  test('should validate URLs with underscores', () {
    validatorTest({
      'validator': 'isURL',
      'args': [
        UrlOptions(
          allowUnderscores: true,
        )
      ],
      'valid': [
        'http://foo_bar.com',
        'http://pr.example_com.294.example.com/',
        'http://foo__bar.com',
        'http://_.example.com',
      ],
      'invalid': [],
    });
  });

  test('should validate URLs that do not have a TLD', () {
    validatorTest({
      'validator': 'isURL',
      'args': [
        UrlOptions(
          requireTld: false,
        )
      ],
      'valid': [
        'http://foobar.com/',
        'http://foobar/',
        'http://localhost/',
        'foobar/',
        'foobar',
      ],
      'invalid': [],
    });
  });

  test('should validate URLs with a trailing dot option', () {
    validatorTest({
      'validator': 'isURL',
      'args': [
        UrlOptions(
          allowTrailingDot: true,
          requireTld: false,
        )
      ],
      'valid': [
        'http://example.com.',
        'foobar.',
      ],
    });
  });

  test('should validate URLs with column and no port', () {
    validatorTest({
      'validator': 'isURL',
      'valid': [
        'http://example.com:',
        'ftp://example.com:',
      ],
      'invalid': [
        'https://example.com:abc',
      ],
    });
  });

  test('should validate sftp protocol URL containing column and no port', () {
    validatorTest({
      'validator': 'isURL',
      'args': [
        UrlOptions(protocols: ['sftp'])
      ],
      'valid': [
        'sftp://user:pass@terminal.aws.test.nl:/incoming/things.csv',
      ],
    });
  });

  test('should validate protocol relative URLs', () {
    validatorTest({
      'validator': 'isURL',
      'args': [
        UrlOptions(
          allowProtocolRelativeUrls: true,
        )
      ],
      'valid': [
        '//foobar.com',
        'http://foobar.com',
        'foobar.com',
      ],
      'invalid': [
        '://foobar.com',
        '/foobar.com',
        '////foobar.com',
        'http:////foobar.com',
      ],
    });
  });

  test('should not validate URLs with fragments when allow fragments is false',
      () {
    validatorTest({
      'validator': 'isURL',
      'args': [
        UrlOptions(
          allowFragments: false,
        )
      ],
      'valid': [
        'http://foobar.com',
        'foobar.com',
      ],
      'invalid': [
        'http://foobar.com#part',
        'foobar.com#part',
      ],
    });
  });

  test(
      'should not validate URLs with query components when allow query components is false',
      () {
    validatorTest({
      'validator': 'isURL',
      'args': [
        UrlOptions(
          allowQueryComponents: false,
        )
      ],
      'valid': [
        'http://foobar.com',
        'foobar.com',
      ],
      'invalid': [
        'http://foobar.com?foo=bar',
        'http://foobar.com?foo=bar&bar=foo',
        'foobar.com?foo=bar',
        'foobar.com?foo=bar&bar=foo',
      ],
    });
  });

  test(
      'should not validate protocol relative URLs when require protocol is true',
      () {
    validatorTest({
      'validator': 'isURL',
      'args': [
        UrlOptions(
          allowProtocolRelativeUrls: true,
          requireProtocol: true,
        )
      ],
      'valid': [
        'http://foobar.com',
      ],
      'invalid': [
        '//foobar.com',
        '://foobar.com',
        '/foobar.com',
        'foobar.com',
      ],
    });
  });

  test('should let users specify whether URLs require a protocol', () {
    validatorTest({
      'validator': 'isURL',
      'args': [
        UrlOptions(
          requireProtocol: true,
        )
      ],
      'valid': [
        'http://foobar.com/',
      ],
      'invalid': [
        'http://localhost/',
        'foobar.com',
        'foobar',
      ],
    });
  });

  test('should let users specify a host whitelist', () {
    validatorTest({
      'validator': 'isURL',
      'args': [
        UrlOptions(
          hostWhitelist: ['foo.com', 'bar.com'],
        )
      ],
      'valid': [
        'http://bar.com/',
        'http://foo.com/',
      ],
      'invalid': [
        'http://foobar.com',
        'http://foo.bar.com/',
        'http://qux.com',
      ],
    });
  });

  test('should allow regular expressions in the host whitelist', () {
    validatorTest({
      'validator': 'isURL',
      'args': [
        UrlOptions(
          hostWhitelist: ['bar.com', 'foo.com', RegExp(r'\.foo\.com$')],
        )
      ],
      'valid': [
        'http://bar.com/',
        'http://foo.com/',
        'http://images.foo.com/',
        'http://cdn.foo.com/',
        'http://a.b.c.foo.com/',
      ],
      'invalid': [
        'http://foobar.com',
        'http://foo.bar.com/',
        'http://qux.com',
      ],
    });
  });

  test('should let users specify a host blacklist', () {
    validatorTest({
      'validator': 'isURL',
      'args': [
        UrlOptions(
          hostBlacklist: ['foo.com', 'bar.com'],
        )
      ],
      'valid': [
        'http://foobar.com',
        'http://foo.bar.com/',
        'http://qux.com',
      ],
      'invalid': [
        'http://bar.com/',
        'http://foo.com/',
      ],
    });
  });

  test('should allow regular expressions in the host blacklist', () {
    validatorTest({
      'validator': 'isURL',
      'args': [
        UrlOptions(
          hostBlacklist: ['foo.com', 'bar.com', RegExp(r'\.foo\.com$')],
        )
      ],
      'valid': [
        'http://foobar.com',
        'http://foo.bar.com/',
        'http://qux.com',
      ],
      'invalid': [
        'http://bar.com/',
        'http://foo.com/',
        'http://images.foo.com/',
        'http://cdn.foo.com/',
        'http://a.b.c.foo.com/',
      ],
    });
  });

  test('should allow rejecting urls containing authentication information', () {
    validatorTest({
      'validator': 'isURL',
      'args': [
        UrlOptions(
          disallowAuth: true,
        )
      ],
      'valid': [
        'doe.com',
      ],
      'invalid': [
        'john@doe.com',
        'john:john@doe.com',
      ],
    });
  });

  test('should accept urls containing authentication information', () {
    validatorTest({
      'validator': 'isURL',
      'args': [
        UrlOptions(
          disallowAuth: false,
        )
      ],
      'valid': [
        'user@example.com',
        'user:@example.com',
        'user:password@example.com',
      ],
      'invalid': [
        'user:user:password@example.com',
        '@example.com',
        ':@example.com',
        ':example.com',
      ],
    });
  });

  test('should allow user to skip URL length validation', () {
    validatorTest({
      'validator': 'isURL',
      'args': [
        UrlOptions(
          validateLength: false,
        )
      ],
      'valid': [
        'http://foobar.com/f',
        'http://foobar.com/${List.filled(2083, 'f').join()}',
      ],
      'invalid': [],
    });
  });

  test('should validate URLs with port present', () {
    validatorTest({
      'validator': 'isURL',
      'args': [
        UrlOptions(
          requirePort: true,
        )
      ],
      'valid': [
        'http://user:pass@www.foobar.com:1',
        'http://user:@www.foobar.com:65535',
        'http://127.0.0.1:23',
        'http://10.0.0.0:256',
        'http://189.123.14.13:256',
        'http://duckduckgo.com:65535?q=%2F',
      ],
      'invalid': [
        'http://user:pass@www.foobar.com/',
        'http://user:@www.foobar.com/',
        'http://127.0.0.1/',
        'http://10.0.0.0/',
        'http://189.123.14.13/',
        'http://duckduckgo.com/?q=%2F',
      ],
    });
  });

  test('should validate MAC addresses', () {
    validatorTest({
      'validator': 'isMACAddress',
      'valid': [
        'ab:ab:ab:ab:ab:ab',
        'FF:FF:FF:FF:FF:FF',
        '01:02:03:04:05:ab',
        '01:AB:03:04:05:06',
        'A9 C5 D4 9F EB D3',
        '01 02 03 04 05 ab',
        '01-02-03-04-05-ab',
        '0102.0304.05ab',
        'ab:ab:ab:ab:ab:ab:ab:ab',
        'FF:FF:FF:FF:FF:FF:FF:FF',
        '01:02:03:04:05:06:07:ab',
        '01:AB:03:04:05:06:07:08',
        'A9 C5 D4 9F EB D3 B6 65',
        '01 02 03 04 05 06 07 ab',
        '01-02-03-04-05-06-07-ab',
        '0102.0304.0506.07ab',
      ],
      'invalid': [
        'abc',
        '01:02:03:04:05',
        '01:02:03:04:05:z0',
        '01:02:03:04::ab',
        '1:2:3:4:5:6',
        'AB:CD:EF:GH:01:02',
        'A9C5 D4 9F EB D3',
        '01-02 03:04 05 ab',
        '0102.03:04.05ab',
        '900f/dffs/sdea',
        '01:02:03:04:05:06:07',
        '01:02:03:04:05:06:07:z0',
        '01:02:03:04:05:06::ab',
        '1:2:3:4:5:6:7:8',
        'AB:CD:EF:GH:01:02:03:04',
        'A9C5 D4 9F EB D3 B6 65',
        '01-02 03:04 05 06 07 ab',
        '0102.03:04.0506.07ab',
        '900f/dffs/sdea/54gh',
      ],
    });

    validatorTest({
      'validator': 'isMACAddress',
      'args': [
        MACAddressOptions(
          eui: '48',
        )
      ],
      'valid': [
        'ab:ab:ab:ab:ab:ab',
        'FF:FF:FF:FF:FF:FF',
        '01:02:03:04:05:ab',
        '01:AB:03:04:05:06',
        'A9 C5 D4 9F EB D3',
        '01 02 03 04 05 ab',
        '01-02-03-04-05-ab',
        '0102.0304.05ab',
      ],
      'invalid': [
        'ab:ab:ab:ab:ab:ab:ab:ab',
        'FF:FF:FF:FF:FF:FF:FF:FF',
        '01:02:03:04:05:06:07:ab',
        '01:AB:03:04:05:06:07:08',
        'A9 C5 D4 9F EB D3 B6 65',
        '01 02 03 04 05 06 07 ab',
        '01-02-03-04-05-06-07-ab',
        '0102.0304.0506.07ab',
      ],
    });
    validatorTest({
      'validator': 'isMACAddress',
      'args': [MACAddressOptions(eui: '64')],
      'valid': [
        'ab:ab:ab:ab:ab:ab:ab:ab',
        'FF:FF:FF:FF:FF:FF:FF:FF',
        '01:02:03:04:05:06:07:ab',
        '01:AB:03:04:05:06:07:08',
        'A9 C5 D4 9F EB D3 B6 65',
        '01 02 03 04 05 06 07 ab',
        '01-02-03-04-05-06-07-ab',
        '0102.0304.0506.07ab',
      ],
      'invalid': [
        'ab:ab:ab:ab:ab:ab',
        'FF:FF:FF:FF:FF:FF',
        '01:02:03:04:05:ab',
        '01:AB:03:04:05:06',
        'A9 C5 D4 9F EB D3',
        '01 02 03 04 05 ab',
        '01-02-03-04-05-ab',
        '0102.0304.05ab',
      ],
    });
  });

  test('should validate MAC addresses without separator', () {
    validatorTest({
      'validator': 'isMACAddress',
      'args': [
        MACAddressOptions(
          noSeparators: true,
        )
      ],
      'valid': [
        'abababababab',
        'FFFFFFFFFFFF',
        '0102030405ab',
        '01AB03040506',
        'abababababababab',
        'FFFFFFFFFFFFFFFF',
        '01020304050607ab',
        '01AB030405060708',
      ],
      'invalid': [
        'abc',
        '01:02:03:04:05',
        '01:02:03:04::ab',
        '1:2:3:4:5:6',
        'AB:CD:EF:GH:01:02',
        'ab:ab:ab:ab:ab:ab',
        'FF:FF:FF:FF:FF:FF',
        '01:02:03:04:05:ab',
        '01:AB:03:04:05:06',
        '0102030405',
        '01020304ab',
        '123456',
        'ABCDEFGH0102',
        '01:02:03:04:05:06:07',
        '01:02:03:04:05:06::ab',
        '1:2:3:4:5:6:7:8',
        'AB:CD:EF:GH:01:02:03:04',
        'ab:ab:ab:ab:ab:ab:ab:ab',
        'FF:FF:FF:FF:FF:FF:FF:FF',
        '01:02:03:04:05:06:07:ab',
        '01:AB:03:04:05:06:07:08',
        '01020304050607',
        '010203040506ab',
        '12345678',
        'ABCDEFGH01020304',
      ],
    });

    validatorTest({
      'validator': 'isMACAddress',
      'args': [
        MACAddressOptions(
          noSeparators: true,
          eui: '48',
        )
      ],
      'valid': [
        'abababababab',
        'FFFFFFFFFFFF',
        '0102030405ab',
        '01AB03040506',
      ],
      'invalid': [
        'abababababababab',
        'FFFFFFFFFFFFFFFF',
        '01020304050607ab',
        '01AB030405060708',
      ],
    });

    validatorTest({
      'validator': 'isMACAddress',
      'args': [
        MACAddressOptions(
          noSeparators: true,
          eui: '64',
        )
      ],
      'valid': [
        'abababababababab',
        'FFFFFFFFFFFFFFFF',
        '01020304050607ab',
        '01AB030405060708',
      ],
      'invalid': [
        'abababababab',
        'FFFFFFFFFFFF',
        '0102030405ab',
        '01AB03040506',
      ],
    });
  });

  test('should validate IP addresses', () {
    validatorTest({
      'validator': 'isIP',
      'valid': [
        '127.0.0.1',
        '0.0.0.0',
        '255.255.255.255',
        '1.2.3.4',
        '::1',
        '2001:db8:0000:1:1:1:1:1',
        '2001:db8:3:4::192.0.2.33',
        '2001:41d0:2:a141::1',
        '::ffff:127.0.0.1',
        '::0000',
        '0000::',
        '1::',
        '1111:1:1:1:1:1:1:1',
        'fe80::a6db:30ff:fe98:e946',
        '::',
        '::8',
        '::ffff:127.0.0.1',
        '::ffff:255.255.255.255',
        '::ffff:0:255.255.255.255',
        '::2:3:4:5:6:7:8',
        '::255.255.255.255',
        '0:0:0:0:0:ffff:127.0.0.1',
        '1:2:3:4:5:6:7::',
        '1:2:3:4:5:6::8',
        '1::7:8',
        '1:2:3:4:5::7:8',
        '1:2:3:4:5::8',
        '1::6:7:8',
        '1:2:3:4::6:7:8',
        '1:2:3:4::8',
        '1::5:6:7:8',
        '1:2:3::5:6:7:8',
        '1:2:3::8',
        '1::4:5:6:7:8',
        '1:2::4:5:6:7:8',
        '1:2::8',
        '1::3:4:5:6:7:8',
        '1::8',
        'fe80::7:8%eth0',
        'fe80::7:8%1',
        '64:ff9b::192.0.2.33',
        '0:0:0:0:0:0:10.0.0.1',
      ],
      'invalid': [
        'abc',
        '256.0.0.0',
        '0.0.0.256',
        '26.0.0.256',
        '0200.200.200.200',
        '200.0200.200.200',
        '200.200.0200.200',
        '200.200.200.0200',
        '::banana',
        'banana::',
        '::1banana',
        '::1::',
        '1:',
        ':1',
        ':1:1:1::2',
        '1:1:1:1:1:1:1:1:1:1:1:1:1:1:1:1',
        '::11111',
        '11111:1:1:1:1:1:1:1',
        '2001:db8:0000:1:1:1:1::1',
        '0:0:0:0:0:0:ffff:127.0.0.1',
        '0:0:0:0:ffff:127.0.0.1',
      ],
    });

    validatorTest({
      'validator': 'isIP',
      'args': [4],
      'valid': [
        '127.0.0.1',
        '0.0.0.0',
        '255.255.255.255',
        '1.2.3.4',
        '255.0.0.1',
        '0.0.1.1',
      ],
      'invalid': [
        '::1',
        '2001:db8:0000:1:1:1:1:1',
        '::ffff:127.0.0.1',
        '137.132.10.01',
        '0.256.0.256',
        '255.256.255.256',
      ],
    });

    validatorTest({
      'validator': 'isIP',
      'args': [6],
      'valid': [
        '::1',
        '2001:db8:0000:1:1:1:1:1',
        '::ffff:127.0.0.1',
        'fe80::1234%1',
        'ff08::9abc%10',
        'ff08::9abc%interface10',
        'ff02::5678%pvc1.3',
      ],
      'invalid': [
        '127.0.0.1',
        '0.0.0.0',
        '255.255.255.255',
        '1.2.3.4',
        '::ffff:287.0.0.1',
        '%',
        'fe80::1234%',
        'fe80::1234%1%3%4',
        'fe80%fe80%',
      ],
    });

    validatorTest({
      'validator': 'isIP',
      'args': [10],
      'valid': [],
      'invalid': [
        '127.0.0.1',
        '0.0.0.0',
        '255.255.255.255',
        '1.2.3.4',
        '::1',
        '2001:db8:0000:1:1:1:1:1',
      ],
    });
  });

  test('should validate isIPRange', () {
    validatorTest({
      'validator': 'isIPRange',
      'valid': [
        '127.0.0.1/24',
        '0.0.0.0/0',
        '255.255.255.0/32',
        '::/0',
        '::/128',
        '2001::/128',
        '2001:800::/128',
        '::ffff:127.0.0.1/128',
      ],
      'invalid': [
        'abc',
        '127.200.230.1/35',
        '127.200.230.1/-1',
        '1.1.1.1/011',
        '1.1.1/24.1',
        '1.1.1.1/01',
        '1.1.1.1/1.1',
        '1.1.1.1/1.',
        '1.1.1.1/1/1',
        '1.1.1.1',
        '::1',
        '::1/164',
        '2001::/240',
        '2001::/-1',
        '2001::/001',
        '2001::/24.1',
        '2001:db8:0000:1:1:1:1:1',
        '::ffff:127.0.0.1',
      ],
    });

    validatorTest({
      'validator': 'isIPRange',
      'args': [4],
      'valid': [
        '127.0.0.1/1',
        '0.0.0.0/1',
        '255.255.255.255/1',
        '1.2.3.4/1',
        '255.0.0.1/1',
        '0.0.1.1/1',
      ],
      'invalid': [
        'abc',
        '::1',
        '2001:db8:0000:1:1:1:1:1',
        '::ffff:127.0.0.1',
        '137.132.10.01',
        '0.256.0.256',
        '255.256.255.256',
      ],
    });
    validatorTest({
      'validator': 'isIPRange',
      'args': [6],
      'valid': [
        '::1/1',
        '2001:db8:0000:1:1:1:1:1/1',
        '::ffff:127.0.0.1/1',
      ],
      'invalid': [
        'abc',
        '127.0.0.1',
        '0.0.0.0',
        '255.255.255.255',
        '1.2.3.4',
        '::ffff:287.0.0.1',
        '::ffff:287.0.0.1/254',
        '%',
        'fe80::1234%',
        'fe80::1234%1%3%4',
        'fe80%fe80%',
      ],
    });

    validatorTest({
      'validator': 'isIPRange',
      'args': [10],
      'valid': [],
      'invalid': [
        'abc',
        '127.0.0.1/1',
        '0.0.0.0/1',
        '255.255.255.255/1',
        '1.2.3.4/1',
        '::1/1',
        '2001:db8:0000:1:1:1:1:1/1',
      ],
    });
  });

  test('should validate FQDN', () {
    validatorTest({
      'validator': 'isFQDN',
      'valid': [
        'domain.com',
        'dom.plato',
        'a.domain.co',
        'foo--bar.com',
        'xn--froschgrn-x9a.com',
        'rebecca.blackfriday',
        '1337.com',
      ],
      'invalid': [
        'abc',
        '256.0.0.0',
        '_.com',
        '*.some.com',
        's!ome.com',
        'domain.com/',
        '/more.com',
        'domain.com�',
        'domain.co\u00A0m',
        'domain.co\u1680m',
        'domain.co\u2006m',
        'domain.co\u2028m',
        'domain.co\u2029m',
        'domain.co\u202Fm',
        'domain.co\u205Fm',
        'domain.co\u3000m',
        'domain.com\uDC00',
        'domain.co\uEFFFm',
        'domain.co\uFDDAm',
        'domain.co\uFFF4m',
        'domain.com©',
        'example.0',
        '192.168.0.9999',
        '192.168.0',
      ],
    });
  });

  test('should validate FQDN with trailing dot option', () {
    validatorTest({
      'validator': 'isFQDN',
      'args': [
        FqdnOptions(
          allowTrailingDot: true,
        )
      ],
      'valid': [
        'example.com.',
      ],
    });
  });

  test('should invalidate FQDN when not require_tld', () {
    validatorTest({
      'validator': 'isFQDN',
      'args': [
        FqdnOptions(
          requireTld: true,
        )
      ],
      'invalid': [
        'example.0',
        '192.168.0',
        '192.168.0.9999',
      ],
    });
  });

  test('should validate FQDN when not require_tld but allow_numeric_tld', () {
    validatorTest({
      'validator': 'isFQDN',
      'args': [
        FqdnOptions(
          allowNumericTld: true,
          requireTld: false,
        )
      ],
      'valid': [
        'example.0',
        '192.168.0',
        '192.168.0.9999',
      ],
    });
  });

  test('should validate FQDN with wildcard option', () {
    validatorTest({
      'validator': 'isFQDN',
      'args': [
        FqdnOptions(
          allowWildcard: true,
        )
      ],
      'valid': [
        '*.example.com',
        '*.shop.example.com',
      ],
    });
  });

  test(
      'should validate FQDN with required allow_trailing_dot, allow_underscores and allow_numeric_tld options',
      () {
    validatorTest({
      'validator': 'isFQDN',
      'args': [
        FqdnOptions(
          allowTrailingDot: true,
          allowUnderscores: true,
          allowNumericTld: true,
        ),
      ],
      'valid': [
        'abc.efg.g1h.',
        'as1s.sad3s.ssa2d.',
      ],
    });
  });

  test('should validate alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'valid': [
        'abc',
        'ABC',
        'FoObar',
      ],
      'invalid': [
        'abc1',
        '  foo  ',
        '',
        'ÄBC',
        'FÜübar',
        'Jön',
        'Heiß',
      ],
    });
  });

  test('should validate alpha string with ignored characters', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['en-US', AlphaOptions(ignore: '- /')], // ignore [space-/]
      'valid': [
        'en-US',
        'this is a valid alpha string',
        'us/usa',
      ],
      'invalid': [
        '1. this is not a valid alpha string',
        'this\$is also not a valid.alpha string',
        'this is also not a valid alpha string.',
      ],
    });

    validatorTest({
      'validator': 'isAlpha',
      'args': [
        'en-US',
        AlphaOptions(ignore: RegExp(r'[\s/-]'))
      ], // ignore [space -]
      'valid': [
        'en-US',
        'this is a valid alpha string',
      ],
      'invalid': [
        '1. this is not a valid alpha string',
        'this\$is also not a valid.alpha string',
        'this is also not a valid alpha string.',
      ],
    });

    validatorTest({
      'validator': 'isAlpha',
      'args': ['en-US', AlphaOptions(ignore: 1234)], // invalid ignore matcher
      'error': [
        'alpha',
      ],
    });
  });

  test('should validate Azerbaijani alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['az-AZ'],
      'valid': [
        'Azərbaycan',
        'Bakı',
        'üöğıəçş',
        'sizAzərbaycanlaşdırılmışlardansınızmı',
        'dahaBirDüzgünString',
        'abcçdeəfgğhxıijkqlmnoöprsştuüvyz',
      ],
      'invalid': [
        'rəqəm1',
        '  foo  ',
        '',
        'ab(cd)',
        'simvol@',
        'wəkil',
      ],
    });
  });

  test('should validate bulgarian alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['bg-BG'],
      'valid': [
        'абв',
        'АБВ',
        'жаба',
        'яГоДа',
      ],
      'invalid': [
        'abc1',
        '  foo  ',
        '',
        'ЁЧПС',
        '_аз_обичам_обувки_',
        'ехо!',
      ],
    });
  });

  test('should validate Bengali alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['bn-BD'],
      'valid': [
        'অয়াওর',
        'ফগফদ্রত',
        'ফদ্ম্যতভ',
        'বেরেওভচনভন',
        'আমারবাসগা',
      ],
      'invalid': [
        'দাস২৩৪',
        '  দ্গফহ্নভ  ',
        '',
        '(গফদ)',
      ],
    });
  });

  test('should validate czech alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['cs-CZ'],
      'valid': [
        'žluťoučký',
        'KŮŇ',
        'Pěl',
        'Ďábelské',
        'ódy',
      ],
      'invalid': [
        'ábc1',
        '  fůj  ',
        '',
      ],
    });
  });

  test('should validate slovak alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['sk-SK'],
      'valid': [
        'môj',
        'ľúbím',
        'mäkčeň',
        'stĹp',
        'vŕba',
        'ňorimberk',
        'ťava',
        'žanéta',
        'Ďábelské',
        'ódy',
      ],
      'invalid': [
        '1moj',
        '你好世界',
        '  Привет мир  ',
        'مرحبا العا ',
      ],
    });
  });

  test('should validate danish alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['da-DK'],
      'valid': [
        'aøå',
        'Ære',
        'Øre',
        'Åre',
      ],
      'invalid': [
        'äbc123',
        'ÄBC11',
        '',
      ],
    });
  });

  test('should validate dutch alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['nl-NL'],
      'valid': [
        'Kán',
        'één',
        'vóór',
        'nú',
        'héél',
      ],
      'invalid': [
        'äca ',
        'abcß',
        'Øre',
      ],
    });
  });

  test('should validate german alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['de-DE'],
      'valid': [
        'äbc',
        'ÄBC',
        'FöÖbär',
        'Heiß',
      ],
      'invalid': [
        'äbc1',
        '  föö  ',
        '',
      ],
    });
  });

  test('should validate hungarian alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['hu-HU'],
      'valid': [
        'árvíztűrőtükörfúrógép',
        'ÁRVÍZTŰRŐTÜKÖRFÚRÓGÉP',
      ],
      'invalid': [
        'äbc1',
        '  fäö  ',
        'Heiß',
        '',
      ],
    });
  });

  test('should validate portuguese alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['pt-PT'],
      'valid': [
        'palíndromo',
        'órgão',
        'qwértyúão',
        'àäãcëüïÄÏÜ',
      ],
      'invalid': [
        '12abc',
        'Heiß',
        'Øre',
        'æøå',
        '',
      ],
    });
  });

  test('should validate italian alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['it-IT'],
      'valid': [
        'àéèìîóòù',
        'correnti',
        'DEFINIZIONE',
        'compilazione',
        'metró',
        'pèsca',
        'PÉSCA',
        'genî',
      ],
      'invalid': [
        'äbc123',
        'ÄBC11',
        'æøå',
        '',
      ],
    });
  });

  test('should validate Japanese alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['ja-JP'],
      'valid': [
        'あいうえお',
        'がぎぐげご',
        'ぁぃぅぇぉ',
        'アイウエオ',
        'ァィゥェ',
        'ｱｲｳｴｵ',
        '吾輩は猫である',
        '臥薪嘗胆',
        '新世紀エヴァンゲリオン',
        '天国と地獄',
        '七人の侍',
        'シン・ウルトラマン',
      ],
      'invalid': [
        'あいう123',
        'abcあいう',
        '１９８４',
      ],
    });
  });

  test('should validate Vietnamese alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['vi-VN'],
      'valid': [
        'thiến',
        'nghiêng',
        'xin',
        'chào',
        'thế',
        'giới',
      ],
      'invalid': [
        'thầy3',
        'Ba gà',
        '',
      ],
    });
  });

  test('should validate arabic alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['ar'],
      'valid': [
        'أبت',
        'اَبِتَثّجً',
      ],
      'invalid': [
        '١٢٣أبت',
        '١٢٣',
        'abc1',
        '  foo  ',
        '',
        'ÄBC',
        'FÜübar',
        'Jön',
        'Heiß',
      ],
    });
  });

  test('should validate farsi alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['fa-IR'],
      'valid': [
        'پدر',
        'مادر',
        'برادر',
        'خواهر',
      ],
      'invalid': [
        'فارسی۱۲۳',
        '۱۶۴',
        'abc1',
        '  foo  ',
        '',
        'ÄBC',
        'FÜübar',
        'Jön',
        'Heiß',
      ],
    });
  });

  test('should validate finnish alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['fi-FI'],
      'valid': [
        'äiti',
        'Öljy',
        'Åke',
        'testÖ',
      ],
      'invalid': [
        'AİıÖöÇçŞşĞğÜüZ',
        'äöå123',
        '',
      ],
    });
  });

  test('should validate kurdish alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['ku-IQ'],
      'valid': [
        'ئؤڤگێ',
        'کوردستان',
      ],
      'invalid': [
        'ئؤڤگێ١٢٣',
        '١٢٣',
        'abc1',
        '  foo  ',
        '',
        'ÄBC',
        'FÜübar',
        'Jön',
        'Heiß',
      ],
    });
  });

  test('should validate norwegian alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['nb-NO'],
      'valid': [
        'aøå',
        'Ære',
        'Øre',
        'Åre',
      ],
      'invalid': [
        'äbc123',
        'ÄBC11',
        '',
      ],
    });
  });

  test('should validate polish alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['pl-PL'],
      'valid': [
        'kreską',
        'zamknięte',
        'zwykłe',
        'kropką',
        'przyjęły',
        'święty',
        'Pozwól',
      ],
      'invalid': [
        '12řiď ',
        'blé!!',
        'föö!2!',
      ],
    });
  });

  test('should validate serbian cyrillic alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['sr-RS'],
      'valid': [
        'ШћжЂљЕ',
        'ЧПСТЋЏ',
      ],
      'invalid': [
        'řiď ',
        'blé33!!',
        'föö!!',
      ],
    });
  });

  test('should validate serbian latin alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['sr-RS@latin'],
      'valid': [
        'ŠAabčšđćž',
        'ŠATROĆčđš',
      ],
      'invalid': [
        '12řiď ',
        'blé!!',
        'föö!2!',
      ],
    });
  });

  test('should validate spanish alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['es-ES'],
      'valid': [
        'ábcó',
        'ÁBCÓ',
        'dormís',
        'volvés',
        'español',
      ],
      'invalid': [
        'äca ',
        'abcß',
        'föö!!',
      ],
    });
  });

  test('should validate swedish alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['sv-SE'],
      'valid': [
        'religiös',
        'stjäla',
        'västgöte',
        'Åre',
      ],
      'invalid': [
        'AİıÖöÇçŞşĞğÜüZ',
        'religiös23',
        '',
      ],
    });
  });

  test('should validate defined arabic locales alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['ar-SY'],
      'valid': [
        'أبت',
        'اَبِتَثّجً',
      ],
      'invalid': [
        '١٢٣أبت',
        '١٢٣',
        'abc1',
        '  foo  ',
        '',
        'ÄBC',
        'FÜübar',
        'Jön',
        'Heiß',
      ],
    });
  });

  test('should validate turkish alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['tr-TR'],
      'valid': [
        'AİıÖöÇçŞşĞğÜüZ',
      ],
      'invalid': [
        '0AİıÖöÇçŞşĞğÜüZ1',
        '  AİıÖöÇçŞşĞğÜüZ  ',
        'abc1',
        '  foo  ',
        '',
        'ÄBC',
        'Heiß',
      ],
    });
  });

  test('should validate urkrainian alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['uk-UA'],
      'valid': [
        'АБВГҐДЕЄЖЗИIЇЙКЛМНОПРСТУФХЦШЩЬЮЯ',
      ],
      'invalid': [
        '0AİıÖöÇçŞşĞğÜüZ1',
        '  AİıÖöÇçŞşĞğÜüZ  ',
        'abc1',
        '  foo  ',
        '',
        'ÄBC',
        'Heiß',
        'ЫыЪъЭэ',
      ],
    });
  });

  test('should validate greek alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['el-GR'],
      'valid': [
        'αβγδεζηθικλμνξοπρςστυφχψω',
        'ΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩ',
        'άέήίΰϊϋόύώ',
        'ΆΈΉΊΪΫΎΏ',
      ],
      'invalid': [
        '0AİıÖöÇçŞşĞğÜüZ1',
        '  AİıÖöÇçŞşĞğÜüZ  ',
        'ÄBC',
        'Heiß',
        'ЫыЪъЭэ',
        '120',
        'jαckγ',
      ],
    });
  });

  test('should validate Hebrew alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['he'],
      'valid': [
        'בדיקה',
        'שלום',
      ],
      'invalid': [
        'בדיקה123',
        '  foo  ',
        'abc1',
        '',
      ],
    });
  });

  test('should validate Hindi alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['hi-IN'],
      'valid': [
        'अतअपनाअपनीअपनेअभीअंदरआदिआपइत्यादिइनइनकाइन्हींइन्हेंइन्होंइसइसकाइसकीइसकेइसमेंइसीइसेउनउनकाउनकीउनकेउनकोउन्हींउन्हेंउन्होंउसउसकेउसीउसेएकएवंएसऐसेऔरकईकरकरताकरतेकरनाकरनेकरेंकहतेकहाकाकाफ़ीकिकितनाकिन्हेंकिन्होंकियाकिरकिसकिसीकिसेकीकुछकुलकेकोकोईकौनकौनसागयाघरजबजहाँजाजितनाजिनजिन्हेंजिन्होंजिसजिसेजीधरजैसाजैसेजोतकतबतरहतिनतिन्हेंतिन्होंतिसतिसेतोथाथीथेदबारादियादुसरादूसरेदोद्वाराननकेनहींनानिहायतनीचेनेपरपहलेपूरापेफिरबनीबहीबहुतबादबालाबिलकुलभीभीतरमगरमानोमेमेंयदियहयहाँयहीयायिहयेरखेंरहारहेऱ्वासालिएलियेलेकिनववग़ैरहवर्गवहवहाँवहींवालेवुहवेवोसकतासकतेसबसेसभीसाथसाबुतसाभसारासेसोसंगहीहुआहुईहुएहैहैंहोहोताहोतीहोतेहोनाहोने',
        'इन्हें',
      ],
      'invalid': [
        'अत०२३४५६७८९',
        'अत 12',
        ' अत ',
        'abc1',
        'abc',
        '',
      ],
    });
  });

  test('should validate persian alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['fa-IR'],
      'valid': [
        'تست',
        'عزیزم',
        'ح',
      ],
      'invalid': [
        'تست 1',
        '  عزیزم  ',
        '',
      ],
    });
  });

  test('should validate Thai alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['th-TH'],
      'valid': [
        'สวัสดี',
        'ยินดีต้อนรับ เทสเคส',
      ],
      'invalid': [
        'สวัสดีHi',
        '123 ยินดีต้อนรับ',
        'ยินดีต้อนรับ-๑๒๓',
      ],
    });
  });

  test('should validate Korea alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['ko-KR'],
      'valid': [
        'ㄱ',
        'ㅑ',
        'ㄱㄴㄷㅏㅕ',
        '세종대왕',
        '나랏말싸미듕귁에달아문자와로서르사맛디아니할쎄',
      ],
      'invalid': [
        'abc',
        '123',
        '흥선대원군 문호개방',
        '1592년임진왜란',
        '대한민국!',
      ],
    });
  });

  test('should validate Sinhala alpha strings', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['si-LK'],
      'valid': [
        'චතුර',
        'කචටදබ',
        'ඎඏදාෛපසුගො',
      ],
      'invalid': [
        'ஆஐअतක',
        'කචට 12',
        ' ඎ ',
        'abc1',
        'abc',
        '',
      ],
    });
  });

  test('should error on invalid locale', () {
    validatorTest({
      'validator': 'isAlpha',
      'args': ['is-NOT'],
      'error': [
        'abc',
        'ABC',
      ],
    });
  });

  test('should validate alphanumeric string with ignored characters', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': [
        'en-US',
        AlphanumericOptions(ignore: '@_- ')
      ], // ignore [@ space _ -]
      'valid': [
        'Hello@123',
        'this is a valid alphaNumeric string',
        'En-US @ alpha_numeric',
      ],
      'invalid': [
        'In*Valid',
        'hello\$123',
        '{invalid}',
      ],
    });

    validatorTest({
      'validator': 'isAlphanumeric',
      'args': [
        'en-US',
        AlphanumericOptions(ignore: RegExp(r'[\s/-]'))
      ], // ignore [space -]
      'valid': [
        'en-US',
        'this is a valid alphaNumeric string',
      ],
      'invalid': [
        'INVALID\$ AlphaNum Str',
        'hello@123',
        'abc*123',
      ],
    });

    validatorTest({
      'validator': 'isAlphanumeric',
      'args': [
        'en-US',
        AlphanumericOptions(ignore: 1234)
      ], // invalid ignore matcher (ignore should be instance of a String or RegExp)
      'error': [
        'alpha',
      ],
    });
  });

  test('should validate defined english aliases', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['en-GB'],
      'valid': [
        'abc123',
        'ABC11',
      ],
      'invalid': [
        'abc ',
        'foo!!',
        'ÄBC',
        'FÜübar',
        'Jön',
      ],
    });
  });

  test('should validate Azerbaijani alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['az-AZ'],
      'valid': [
        'Azərbaycan',
        'Bakı',
        'abc1',
        'abcç2',
        '3kərə4kərə',
      ],
      'invalid': [
        '  foo1  ',
        '',
        'ab(cd)',
        'simvol@',
        'wəkil',
      ],
    });
  });

  test('should validate bulgarian alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['bg-BG'],
      'valid': [
        'абв1',
        '4АБ5В6',
        'жаба',
        'яГоДа2',
        'йЮя',
        '123',
      ],
      'invalid': [
        ' ',
        '789  ',
        'hello000',
      ],
    });
  });

  test('should validate Bengali alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['bn-BD'],
      'valid': [
        'দ্গজ্ঞহ্রত্য১২৩',
        'দ্গগফ৮৯০',
        'চব৩৬৫ভবচ',
        '১২৩৪',
        '৩৪২৩৪দফজ্ঞদফ',
      ],
      'invalid': [
        ' ',
        '১২৩  ',
        'hel৩২0',
      ],
    });
  });

  test('should validate czech alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['cs-CZ'],
      'valid': [
        'řiť123',
        'KŮŇ11',
      ],
      'invalid': [
        'řiď ',
        'blé!!',
      ],
    });
  });

  test('should validate slovak alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['sk-SK'],
      'valid': [
        '1môj',
        '2ľúbím',
        '3mäkčeň',
        '4stĹp',
        '5vŕba',
        '6ňorimberk',
        '7ťava',
        '8žanéta',
        '9Ďábelské',
        '10ódy',
      ],
      'invalid': [
        '1moj!',
        '你好世界',
        '  Привет мир  ',
      ],
    });
  });

  test('should validate danish alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['da-DK'],
      'valid': [
        'ÆØÅ123',
        'Ære321',
        '321Øre',
        '123Åre',
      ],
      'invalid': [
        'äbc123',
        'ÄBC11',
        '',
      ],
    });
  });

  test('should validate dutch alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['nl-NL'],
      'valid': [
        'Kán123',
        'één354',
        'v4óór',
        'nú234',
        'hé54él',
      ],
      'invalid': [
        '1äca ',
        'ab3cß',
        'Øre',
      ],
    });
  });

  test('should validate finnish alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['fi-FI'],
      'valid': [
        'äiti124',
        'ÖLJY1234',
        '123Åke',
        '451åå23',
      ],
      'invalid': [
        'AİıÖöÇçŞşĞğÜüZ',
        'foo!!',
        '',
      ],
    });
  });

  test('should validate german alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['de-DE'],
      'valid': [
        'äbc123',
        'ÄBC11',
      ],
      'invalid': [
        'äca ',
        'föö!!',
      ],
    });
  });

  test('should validate hungarian alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['hu-HU'],
      'valid': [
        '0árvíztűrőtükörfúrógép123',
        '0ÁRVÍZTŰRŐTÜKÖRFÚRÓGÉP123',
      ],
      'invalid': [
        '1időúr!',
        'äbc1',
        '  fäö  ',
        'Heiß!',
        '',
      ],
    });
  });

  test('should validate portuguese alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['pt-PT'],
      'valid': [
        'palíndromo',
        '2órgão',
        'qwértyúão9',
        'àäãcë4üïÄÏÜ',
      ],
      'invalid': [
        '!abc',
        'Heiß',
        'Øre',
        'æøå',
        '',
      ],
    });
  });

  test('should validate italian alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['it-IT'],
      'valid': [
        '123àéèìîóòù',
        '123correnti',
        'DEFINIZIONE321',
        'compil123azione',
        'met23ró',
        'pès56ca',
        'PÉS45CA',
        'gen45î',
      ],
      'invalid': [
        'äbc123',
        'ÄBC11',
        'æøå',
        '',
      ],
    });
  });

  test('should validate spanish alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['es-ES'],
      'valid': [
        'ábcó123',
        'ÁBCÓ11',
      ],
      'invalid': [
        'äca ',
        'abcß',
        'föö!!',
      ],
    });
  });

  test('should validate Vietnamese alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['vi-VN'],
      'valid': [
        'Thầy3',
        '3Gà',
      ],
      'invalid': [
        'toang!',
        'Cậu Vàng',
      ],
    });
  });

  test('should validate arabic alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['ar'],
      'valid': [
        'أبت123',
        'أبتَُِ١٢٣',
      ],
      'invalid': [
        'äca ',
        'abcß',
        'föö!!',
      ],
    });
  });

  test('should validate Hindi alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['hi-IN'],
      'valid': [
        'अतअपनाअपनीअपनेअभीअंदरआदिआपइत्यादिइनइनकाइन्हींइन्हेंइन्होंइसइसकाइसकीइसकेइसमेंइसीइसेउनउनकाउनकीउनकेउनकोउन्हींउन्हेंउन्होंउसउसकेउसीउसेएकएवंएसऐसेऔरकईकरकरताकरतेकरनाकरनेकरेंकहतेकहाकाकाफ़ीकिकितनाकिन्हेंकिन्होंकियाकिरकिसकिसीकिसेकीकुछकुलकेकोकोईकौनकौनसागयाघरजबजहाँजाजितनाजिनजिन्हेंजिन्होंजिसजिसेजीधरजैसाजैसेजोतकतबतरहतिनतिन्हेंतिन्होंतिसतिसेतोथाथीथेदबारादियादुसरादूसरेदोद्वाराननकेनहींनानिहायतनीचेनेपरपहलेपूरापेफिरबनीबहीबहुतबादबालाबिलकुलभीभीतरमगरमानोमेमेंयदियहयहाँयहीयायिहयेरखेंरहारहेऱ्वासालिएलियेलेकिनववग़ैरहवर्गवहवहाँवहींवालेवुहवेवोसकतासकतेसबसेसभीसाथसाबुतसाभसारासेसोसंगहीहुआहुईहुएहैहैंहोहोताहोतीहोतेहोनाहोने०२३४५६७८९',
        'इन्हें४५६७८९',
      ],
      'invalid': [
        'अत ०२३४५६७८९',
        ' ३४५६७८९',
        '12 ',
        ' अत ',
        'abc1',
        'abc',
        '',
      ],
    });
  });

  test('should validate farsi alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['fa-IR'],
      'valid': [
        'پارسی۱۲۳',
        '۱۴۵۶',
        'مژگان9',
      ],
      'invalid': [
        'äca ',
        'abcßة',
        'föö!!',
        '٤٥٦',
      ],
    });
  });

  test('should validate Japanese alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['ja-JP'],
      'valid': [
        'あいうえお123',
        '123がぎぐげご',
        'ぁぃぅぇぉ',
        'アイウエオ',
        'ァィゥェ',
        'ｱｲｳｴｵ',
        '２０世紀少年',
        '華氏４５１度',
      ],
      'invalid': [
        ' あいう123 ',
        'abcあいう',
        '生きろ!!',
      ],
    });
  });

  test('should validate kurdish alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['ku-IQ'],
      'valid': [
        'ئؤڤگێ١٢٣',
      ],
      'invalid': [
        'äca ',
        'abcß',
        'föö!!',
      ],
    });
  });

  test('should validate defined arabic aliases', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['ar-SY'],
      'valid': [
        'أبت123',
        'أبتَُِ١٢٣',
      ],
      'invalid': [
        'abc ',
        'foo!!',
        'ÄBC',
        'FÜübar',
        'Jön',
      ],
    });
  });

  test('should validate norwegian alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['nb-NO'],
      'valid': [
        'ÆØÅ123',
        'Ære321',
        '321Øre',
        '123Åre',
      ],
      'invalid': [
        'äbc123',
        'ÄBC11',
        '',
      ],
    });
  });

  test('should validate polish alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['pl-PL'],
      'valid': [
        'kre123ską',
        'zam21knięte',
        'zw23ykłe',
        '123',
        'prz23yjęły',
        'świ23ęty',
        'Poz1322wól',
      ],
      'invalid': [
        '12řiď ',
        'blé!!',
        'föö!2!',
      ],
    });
  });

  test('should validate serbian cyrillic alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['sr-RS'],
      'valid': [
        'ШћжЂљЕ123',
        'ЧПСТ132ЋЏ',
      ],
      'invalid': [
        'řiď ',
        'blé!!',
        'föö!!',
      ],
    });
  });

  test('should validate serbian latin alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['sr-RS@latin'],
      'valid': [
        'ŠAabčšđćž123',
        'ŠATRO11Ćčđš',
      ],
      'invalid': [
        'řiď ',
        'blé!!',
        'föö!!',
      ],
    });
  });

  test('should validate swedish alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['sv-SE'],
      'valid': [
        'religiös13',
        'st23jäla',
        'västgöte123',
        '123Åre',
      ],
      'invalid': [
        'AİıÖöÇçŞşĞğÜüZ',
        'foo!!',
        '',
      ],
    });
  });

  test('should validate turkish alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['tr-TR'],
      'valid': [
        'AİıÖöÇçŞşĞğÜüZ123',
      ],
      'invalid': [
        'AİıÖöÇçŞşĞğÜüZ ',
        'foo!!',
        'ÄBC',
      ],
    });
  });

  test('should validate urkrainian alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['uk-UA'],
      'valid': [
        'АБВГҐДЕЄЖЗИIЇЙКЛМНОПРСТУФХЦШЩЬЮЯ123',
      ],
      'invalid': [
        'éeoc ',
        'foo!!',
        'ÄBC',
        'ЫыЪъЭэ',
      ],
    });
  });

  test('should validate greek alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['el-GR'],
      'valid': [
        'αβγδεζηθικλμνξοπρςστυφχψω',
        'ΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩ',
        '20θ',
        '1234568960',
      ],
      'invalid': [
        '0AİıÖöÇçŞşĞğÜüZ1',
        '  AİıÖöÇçŞşĞğÜüZ  ',
        'ÄBC',
        'Heiß',
        'ЫыЪъЭэ',
        'jαckγ',
      ],
    });
  });

  test('should validate Hebrew alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['he'],
      'valid': [
        'אבג123',
        'שלום11',
      ],
      'invalid': [
        'אבג ',
        'לא!!',
        'abc',
        '  foo  ',
      ],
    });
  });

  test('should validate Thai alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['th-TH'],
      'valid': [
        'สวัสดี ๑๒๓',
        'ยินดีต้อนรับทั้ง ๒ คน',
      ],
      'invalid': [
        '1.สวัสดี',
        'ยินดีต้อนรับทั้ง 2 คน',
      ],
    });
  });

  test('should validate Korea alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['ko-KR'],
      'valid': [
        '2002',
        '훈민정음',
        '1446년훈민정음반포',
      ],
      'invalid': [
        '2022!',
        '2019 코로나시작',
        '1.로렘입숨',
      ],
    });
  });

  test('should validate Sinhala alphanumeric strings', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['si-LK'],
      'valid': [
        'චතුර',
        'කචට12',
        'ඎඏදාෛපසුගො2',
        '1234',
      ],
      'invalid': [
        'ஆஐअतක',
        'කචට 12',
        ' ඎ ',
        'a1234',
        'abc',
        '',
      ],
    });
  });

  test('should error on invalid locale', () {
    validatorTest({
      'validator': 'isAlphanumeric',
      'args': ['is-NOT'],
      'error': [
        '1234568960',
        'abc123',
      ],
    });
  });

  test('should validate numeric strings', () {
    validatorTest({
      'validator': 'isNumeric',
      'valid': [
        '123',
        '00123',
        '-00123',
        '0',
        '-0',
        '+123',
        '123.123',
        '+000000',
      ],
      'invalid': [
        ' ',
        '',
        '.',
      ],
    });
  });

  test('should validate numeric strings without symbols', () {
    validatorTest({
      'validator': 'isNumeric',
      'args': [
        NumericOptions(
          noSymbols: true,
        )
      ],
      'valid': [
        '123',
        '00123',
        '0',
      ],
      'invalid': [
        '-0',
        '+000000',
        '',
        '+123',
        '123.123',
        '-00123',
        ' ',
        '.',
      ],
    });
  });

  test('should validate numeric strings with locale', () {
    validatorTest({
      'validator': 'isNumeric',
      'args': [
        NumericOptions(
          locale: 'fr-FR',
        )
      ],
      'valid': [
        '123',
        '00123',
        '-00123',
        '0',
        '-0',
        '+123',
        '123,123',
        '+000000',
      ],
      'invalid': [
        ' ',
        '',
        ',',
      ],
    });
  });

  test('should validate numeric strings with locale', () {
    validatorTest({
      'validator': 'isNumeric',
      'args': [
        NumericOptions(
          locale: 'fr-CA',
        )
      ],
      'valid': [
        '123',
        '00123',
        '-00123',
        '0',
        '-0',
        '+123',
        '123,123',
        '+000000',
      ],
      'invalid': [
        ' ',
        '',
        '.',
      ],
    });
  });

  test('should validate ports', () {
    validatorTest({
      'validator': 'isPort',
      'valid': [
        '0',
        '22',
        '80',
        '443',
        '3000',
        '8080',
        '65535',
      ],
      'invalid': [
        '',
        '-1',
        '65536',
      ],
    });
  });

  test('should validate passport number', () {
    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['AM'],
      'valid': [
        'AF0549358',
      ],
      'invalid': [
        'A1054935',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['ID'],
      'valid': [
        'C1253473',
        'B5948378',
        'A4859472',
      ],
      'invalid': [
        'D39481728',
        'A-3847362',
        '324132132',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['AR'],
      'valid': [
        'AAC811035',
      ],
      'invalid': [
        'A11811035',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['AT'],
      'valid': [
        'P 1630837',
        'P 4366918',
      ],
      'invalid': [
        '0 1630837',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['AU'],
      'valid': [
        'N0995852',
        'L4819236',
      ],
      'invalid': [
        '1A012345',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['BE'],
      'valid': [
        'EM000000',
        'LA080402',
      ],
      'invalid': [
        '00123456',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['BG'],
      'valid': [
        '346395366',
        '039903356',
      ],
      'invalid': [
        'ABC123456',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['BR'],
      'valid': [
        'FZ973689',
        'GH231233',
      ],
      'invalid': [
        'ABX29332',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['BY'],
      'valid': [
        'MP3899901',
      ],
      'invalid': [
        '345333454',
        'FG53334542',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['CA'],
      'valid': [
        'GA302922',
        'ZE000509',
      ],
      'invalid': [
        'AB0123456',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['CH'],
      'valid': [
        'S1100409',
        'S5200073',
        'X4028791',
      ],
      'invalid': [
        'AB123456',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['CN'],
      'valid': [
        'G25352389',
        'E00160027',
        'EA1234567',
      ],
      'invalid': [
        'K0123456',
        'E-1234567',
        'G.1234567',
        'GA1234567',
        'EI1234567',
        'GO1234567',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['CY'],
      'valid': [
        'K00000413',
      ],
      'invalid': [
        'K10100',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['CZ'],
      'valid': [
        '99003853',
        '42747260',
      ],
      'invalid': [
        '012345678',
        'AB123456',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['DE'],
      'valid': [
        'C01X00T47',
        'C26VMVVC3',
      ],
      'invalid': [
        'AS0123456',
        'A012345678',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['DK'],
      'valid': [
        '900010172',
      ],
      'invalid': [
        '01234567',
        'K01234567',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['DZ'],
      'valid': [
        '855609385',
        '154472412',
        '197025599',
      ],
      'invalid': [
        'AS0123456',
        'A012345678',
        '0123456789',
        '12345678',
        '98KK54321',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['EE'],
      'valid': [
        'K4218285',
        'K3295867',
        'KB0167630',
        'VD0023777',
      ],
      'invalid': [
        'K01234567',
        'KB00112233',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['ES'],
      'valid': [
        'AF238143',
        'ZAB000254',
      ],
      'invalid': [
        'AF01234567',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['FI'],
      'valid': [
        'XP8271602',
        'XD8500003',
      ],
      'invalid': [
        'A01234567',
        'ABC012345',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['FR'],
      'valid': [
        '10CV28144',
        '60RF19342',
        '05RP34083',
      ],
      'invalid': [
        '012345678',
        'AB0123456',
        '01C234567',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['GB'],
      'valid': [
        '925076473',
        '107182890',
        '104121156',
      ],
      'invalid': [
        'A012345678',
        'K000000000',
        '0123456789',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['GR'],
      'valid': [
        'AE0000005',
        'AK0219304',
      ],
      'invalid': [
        'A01234567',
        '012345678',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['HR'],
      'valid': [
        '007007007',
        '138463188',
      ],
      'invalid': [
        'A01234567',
        '00112233',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['HU'],
      'valid': [
        'ZA084505',
        'BA0006902',
      ],
      'invalid': [
        'A01234567',
        '012345678',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['IE'],
      'valid': [
        'D23145890',
        'X65097105',
        'XN0019390',
      ],
      'invalid': [
        'XND012345',
        '0123456789',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['IN'],
      'valid': [
        'A-1234567',
        'A1234567',
        'X0019390',
      ],
      'invalid': [
        'AB-1234567',
        '0123456789',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['IR'],
      'valid': [
        'J97634522',
        'A01234567',
        'Z11977831',
      ],
      'invalid': [
        'A0123456',
        'A0123456Z',
        '012345678',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['IS'],
      'valid': [
        'A2040611',
        'A1197783',
      ],
      'invalid': [
        'K0000000',
        '01234567',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['IT'],
      'valid': [
        'YA8335453',
        'KK0000000',
      ],
      'invalid': [
        '01234567',
        'KAK001122',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['JP'],
      'valid': [
        'NH1106002',
        'TE3180251',
        'XS1234567',
      ],
      'invalid': [
        'X12345678',
        '012345678',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['KR'],
      'valid': [
        'M35772699',
        'M70689098',
      ],
      'invalid': [
        'X12345678',
        '012345678',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['LT'],
      'valid': [
        '20200997',
        'LB311756',
      ],
      'invalid': [
        'LB01234567',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['LU'],
      'valid': [
        'JCU9J4T2',
        'JC4E7L2H',
      ],
      'invalid': [
        'JCU9J4T',
        'JC4E7L2H0',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['LV'],
      'valid': [
        'LV9000339',
        'LV4017173',
      ],
      'invalid': [
        'LV01234567',
        '4017173LV',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['LY'],
      'valid': [
        'P79JF34X',
        'RJ45H4V2',
      ],
      'invalid': [
        'P79JF34',
        'RJ45H4V2C',
        'RJ4-H4V2',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['MT'],
      'valid': [
        '1026564',
      ],
      'invalid': [
        '01234567',
        'MT01234',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['MZ'],
      'valid': [
        'AB0808212',
        '08AB12123',
      ],
      'invalid': [
        '1AB011241',
        '1AB01121',
        'ABAB01121',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['MY'],
      'valid': [
        'A00000000',
        'H12345678',
        'K43143233',
      ],
      'invalid': [
        'A1234567',
        'C01234567',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['MX'],
      'valid': [
        '43986369222',
        '01234567890',
      ],
      'invalid': [
        'ABC34567890',
        '34567890',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['NL'],
      'valid': [
        'XTR110131',
        'XR1001R58',
      ],
      'invalid': [
        'XTR11013R',
        'XR1001R58A',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['PL'],
      'valid': [
        'ZS 0000177',
        'AN 3000011',
      ],
      'invalid': [
        'A1 0000177',
        '012345678',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['PT'],
      'valid': [
        'I700044',
        'K453286',
      ],
      'invalid': [
        '0700044',
        'K4532861',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['RO'],
      'valid': [
        '05485968',
        '040005646',
      ],
      'invalid': [
        'R05485968',
        '0511060461',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['RU'],
      'valid': [
        '2 32 636829',
        '012 345321',
        '439863692',
      ],
      'invalid': [
        'A 2R YU46J0',
        '01A 3D5321',
        'SF233D53T',
        '12345678',
        '1234567890',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['SE'],
      'valid': [
        '59000001',
        '56702928',
      ],
      'invalid': [
        'SE012345',
        '012345678',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['SL'],
      'valid': [
        'PB0036440',
        'PB1390281',
      ],
      'invalid': [
        'SL0123456',
        'P01234567',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['SK'],
      'valid': [
        'P0000000',
      ],
      'invalid': [
        'SK012345',
        '012345678',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['TH'],
      'valid': [
        'A123456',
        'B1234567',
        'CD123456',
        'EF1234567',
      ],
      'invalid': [
        '123456',
        '1234567',
        '010485371AA',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['TR'],
      'valid': [
        'U 06764100',
        'U 01048537',
      ],
      'invalid': [
        '06764100U',
        '010485371',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['UA'],
      'valid': [
        'EH345655',
        'EK000001',
        'AP841503',
      ],
      'invalid': [
        '01234567',
        '012345EH',
        'A012345P',
      ],
    });

    validatorTest({
      'validator': 'isPassportNumber',
      'args': ['US'],
      'valid': [
        '790369937',
        '340007237',
      ],
      'invalid': [
        'US0123456',
        '0123456US',
        '7903699371',
      ],
    });
  });

  test('should validate decimal numbers', () {
    validatorTest({
      'validator': 'isDecimal',
      'valid': [
        '123',
        '00123',
        '-00123',
        '0',
        '-0',
        '+123',
        '0.01',
        '.1',
        '1.0',
        '-.25',
        '-0',
        '0.0000000000001',
      ],
      'invalid': [
        '0,01',
        ',1',
        '1,0',
        '-,25',
        '0,0000000000001',
        '0٫01',
        '٫1',
        '1٫0',
        '-٫25',
        '0٫0000000000001',
        '....',
        ' ',
        '',
        '-',
        '+',
        '.',
        '0.1a',
        'a',
        '\n',
      ],
    });

    validatorTest({
      'validator': 'isDecimal',
      'args': [DecimalOptions(locale: 'en-AU')],
      'valid': [
        '123',
        '00123',
        '-00123',
        '0',
        '-0',
        '+123',
        '0.01',
        '.1',
        '1.0',
        '-.25',
        '-0',
        '0.0000000000001',
      ],
      'invalid': [
        '0,01',
        ',1',
        '1,0',
        '-,25',
        '0,0000000000001',
        '0٫01',
        '٫1',
        '1٫0',
        '-٫25',
        '0٫0000000000001',
        '....',
        ' ',
        '',
        '-',
        '+',
        '.',
        '0.1a',
        'a',
        '\n',
      ],
    });

    validatorTest({
      'validator': 'isDecimal',
      'args': [DecimalOptions(locale: 'bg-BG')],
      'valid': [
        '123',
        '00123',
        '-00123',
        '0',
        '-0',
        '+123',
        '0,01',
        ',1',
        '1,0',
        '-,25',
        '-0',
        '0,0000000000001',
      ],
      'invalid': [
        '0.0000000000001',
        '0.01',
        '.1',
        '1.0',
        '-.25',
        '0٫01',
        '٫1',
        '1٫0',
        '-٫25',
        '0٫0000000000001',
        '....',
        ' ',
        '',
        '-',
        '+',
        '.',
        '0.1a',
        'a',
        '\n',
      ],
    });

    validatorTest({
      'validator': 'isDecimal',
      'args': [DecimalOptions(locale: 'cs-CZ')],
      'valid': [
        '123',
        '00123',
        '-00123',
        '0',
        '-0',
        '+123',
        '0,01',
        ',1',
        '1,0',
        '-,25',
        '-0',
        '0,0000000000001',
      ],
      'invalid': [
        '0.0000000000001',
        '0.01',
        '.1',
        '1.0',
        '-.25',
        '0٫01',
        '٫1',
        '1٫0',
        '-٫25',
        '0٫0000000000001',
        '....',
        ' ',
        '',
        '-',
        '+',
        '.',
        '0.1a',
        'a',
        '\n',
      ],
    });

    validatorTest({
      'validator': 'isDecimal',
      'args': [DecimalOptions(locale: 'ar-JO')],
      'valid': [
        '123',
        '00123',
        '-00123',
        '0',
        '-0',
        '+123',
        '0٫01',
        '٫1',
        '1٫0',
        '-٫25',
        '-0',
        '0٫0000000000001',
      ],
      'invalid': [
        '0,0000000000001',
        '0,01',
        ',1',
        '1,0',
        '-,25',
        '0.0000000000001',
        '0.01',
        '.1',
        '1.0',
        '-.25',
        '....',
        ' ',
        '',
        '-',
        '+',
        '.',
        '0.1a',
        'a',
        '\n',
      ],
    });

    validatorTest({
      'validator': 'isDecimal',
      'args': [DecimalOptions(locale: 'ar-EG')],
      'valid': [
        '0.01',
      ],
      'invalid': [
        '0,01',
      ],
    });

    validatorTest({
      'validator': 'isDecimal',
      'args': [DecimalOptions(locale: 'en-ZM')],
      'valid': [
        '0,01',
      ],
      'invalid': [
        '0.01',
      ],
    });

    validatorTest({
      'validator': 'isDecimal',
      'args': [DecimalOptions(forceDecimals: true)],
      'valid': [
        '0.01',
        '.1',
        '1.0',
        '-.25',
        '0.0000000000001',
      ],
      'invalid': [
        '-0',
        '123',
        '00123',
        '-00123',
        '0',
        '-0',
        '+123',
        '0,0000000000001',
        '0,01',
        ',1',
        '1,0',
        '-,25',
        '....',
        ' ',
        '',
        '-',
        '+',
        '.',
        '0.1a',
        'a',
        '\n',
      ],
    });

    validatorTest({
      'validator': 'isDecimal',
      'args': [DecimalOptions(decimalDigits: '2,3')],
      'valid': [
        '123',
        '00123',
        '-00123',
        '0',
        '-0',
        '+123',
        '0.01',
        '1.043',
        '.15',
        '-.255',
        '-0',
      ],
      'invalid': [
        '0.0000000000001',
        '0.0',
        '.1',
        '1.0',
        '-.2564',
        '0.0',
        '٫1',
        '1٫0',
        '-٫25',
        '0٫0000000000001',
        '....',
        ' ',
        '',
        '-',
        '+',
        '.',
        '0.1a',
        'a',
        '\n',
      ],
    });
  });

  test('should error on invalid locale', () {
    validatorTest({
      'validator': 'isDecimal',
      'args': [DecimalOptions(locale: 'is-NOT')],
      'error': [
        '123',
        '0.01',
        '0,01',
      ],
    });
  });

  test('should validate lowercase strings', () {
    validatorTest({
      'validator': 'isLowercase',
      'valid': [
        'abc',
        'abc123',
        'this is lowercase.',
        'tr竪s 端ber',
      ],
      'invalid': [
        'fooBar',
        '123A',
      ],
    });
  });

  test('should validate imei strings', () {
    validatorTest({
      'validator': 'isIMEI',
      'valid': [
        '352099001761481',
        '868932036356090',
        '490154203237518',
        '546918475942169',
        '998227667144730',
        '532729766805999',
      ],
      'invalid': [
        '490154203237517',
        '3568680000414120',
        '3520990017614823',
      ],
    });
  });

  test('should validate imei strings with hyphens', () {
    validatorTest({
      'validator': 'isIMEI',
      'args': [
        IMEIOptions(
          allowHyphens: true,
        )
      ],
      'valid': [
        '35-209900-176148-1',
        '86-893203-635609-0',
        '49-015420-323751-8',
        '54-691847-594216-9',
        '99-822766-714473-0',
        '53-272976-680599-9',
      ],
      'invalid': [
        '49-015420-323751-7',
        '35-686800-0041412-0',
        '35-209900-1761482-3',
      ],
    });
  });

  test('should validate uppercase strings', () {
    validatorTest({
      'validator': 'isUppercase',
      'valid': [
        'ABC',
        'ABC123',
        'ALL CAPS IS FUN.',
        '   .',
      ],
      'invalid': [
        'fooBar',
        '123abc',
      ],
    });
  });

  test('should validate integers', () {
    validatorTest({
      'validator': 'isInt',
      'valid': [
        '13',
        '123',
        '0',
        '123',
        '-0',
        '+1',
        '01',
        '-01',
        '000',
      ],
      'invalid': [
        '100e10',
        '123.123',
        '   ',
        '',
      ],
    });

    validatorTest({
      'validator': 'isInt',
      'args': [IntOptions(allowLeadingZeroes: false)],
      'valid': [
        '13',
        '123',
        '0',
        '123',
        '-0',
        '+1',
      ],
      'invalid': [
        '01',
        '-01',
        '000',
        '100e10',
        '123.123',
        '   ',
        '',
      ],
    });

    validatorTest({
      'validator': 'isInt',
      'args': [IntOptions(allowLeadingZeroes: true)],
      'valid': [
        '13',
        '123',
        '0',
        '123',
        '-0',
        '+1',
        '01',
        '-01',
        '000',
        '-000',
        '+000',
      ],
      'invalid': [
        '100e10',
        '123.123',
        '   ',
        '',
      ],
    });

    validatorTest({
      'validator': 'isInt',
      'args': [
        IntOptions(
          min: 10,
        )
      ],
      'valid': [
        '15',
        '80',
        '99',
      ],
      'invalid': [
        '9',
        '6',
        '3.2',
        'a',
      ],
    });

    validatorTest({
      'validator': 'isInt',
      'args': [
        IntOptions(
          min: 10,
          max: 15,
        )
      ],
      'valid': [
        '15',
        '11',
        '13',
      ],
      'invalid': [
        '9',
        '2',
        '17',
        '3.2',
        '33',
        'a',
      ],
    });

    validatorTest({
      'validator': 'isInt',
      'args': [
        IntOptions(
          gt: 10,
          lt: 15,
        )
      ],
      'valid': [
        '14',
        '11',
        '13',
      ],
      'invalid': [
        '10',
        '15',
        '17',
        '3.2',
        '33',
        'a',
      ],
    });
  });

  test('should validate floats', () {
    validatorTest({
      'validator': 'isFloat',
      'valid': [
        '123',
        '123.',
        '123.123',
        '-123.123',
        '-0.123',
        '+0.123',
        '0.123',
        '.0',
        '-.123',
        '+.123',
        '01.123',
        '-0.22250738585072011e-307',
      ],
      'invalid': [
        '+',
        '-',
        '  ',
        '',
        '.',
        'foo',
        '20.foo',
        '2020-01-06T14:31:00.135Z',
      ],
    });

    validatorTest({
      'validator': 'isFloat',
      'args': [
        FloatOptions(
          locale: 'en-AU',
        )
      ],
      'valid': [
        '123',
        '123.',
        '123.123',
        '-123.123',
        '-0.123',
        '+0.123',
        '0.123',
        '.0',
        '-.123',
        '+.123',
        '01.123',
        '-0.22250738585072011e-307',
      ],
      'invalid': [
        '123٫123',
        '123,123',
        '  ',
        '',
        '.',
        'foo',
      ],
    });

    validatorTest({
      'validator': 'isFloat',
      'args': [
        FloatOptions(
          locale: 'de-DE',
        )
      ],
      'valid': [
        '123',
        '123,',
        '123,123',
        '-123,123',
        '-0,123',
        '+0,123',
        '0,123',
        ',0',
        '-,123',
        '+,123',
        '01,123',
        '-0,22250738585072011e-307',
      ],
      'invalid': [
        '123.123',
        '123٫123',
        '  ',
        '',
        '.',
        'foo',
      ],
    });

    validatorTest({
      'validator': 'isFloat',
      'args': [FloatOptions(locale: 'ar-JO')],
      'valid': [
        '123',
        '123٫',
        '123٫123',
        '-123٫123',
        '-0٫123',
        '+0٫123',
        '0٫123',
        '٫0',
        '-٫123',
        '+٫123',
        '01٫123',
        '-0٫22250738585072011e-307',
      ],
      'invalid': [
        '123,123',
        '123.123',
        '  ',
        '',
        '.',
        'foo',
      ],
    });

    validatorTest({
      'validator': 'isFloat',
      'args': [
        FloatOptions(
          min: 3.7,
        )
      ],
      'valid': [
        '3.888',
        '3.92',
        '4.5',
        '50',
        '3.7',
        '3.71',
      ],
      'invalid': [
        '3.6',
        '3.69',
        '3',
        '1.5',
        'a',
      ],
    });
    validatorTest({
      'validator': 'isFloat',
      'args': [
        FloatOptions(
          min: 0.1,
          max: 1.0,
        )
      ],
      'valid': [
        '0.1',
        '1.0',
        '0.15',
        '0.33',
        '0.57',
        '0.7',
      ],
      'invalid': [
        '0',
        '0.0',
        'a',
        '1.3',
        '0.05',
        '5',
      ],
    });
    validatorTest({
      'validator': 'isFloat',
      'args': [
        FloatOptions(
          gt: -5.5,
          lt: 10,
        )
      ],
      'valid': [
        '9.9',
        '1.0',
        '0',
        '-1',
        '7',
        '-5.4',
      ],
      'invalid': [
        '10',
        '-5.5',
        'a',
        '-20.3',
        '20e3',
        '10.00001',
      ],
    });
    validatorTest({
      'validator': 'isFloat',
      'args': [
        FloatOptions(
          min: -5.5,
          max: 10,
          gt: -5.5,
          lt: 10,
        )
      ],
      'valid': [
        '9.99999',
        '-5.499999',
      ],
      'invalid': [
        '10',
        '-5.5',
      ],
    });
    validatorTest({
      'validator': 'isFloat',
      'args': [
        FloatOptions(
          locale: 'de-DE',
          min: 3.1,
        )
      ],
      'valid': [
        '123',
        '123,',
        '123,123',
        '3,1',
        '3,100001',
      ],
      'invalid': [
        '3,09',
        '-,123',
        '+,123',
        '01,123',
        '-0,22250738585072011e-307',
        '-123,123',
        '-0,123',
        '+0,123',
        '0,123',
        ',0',
        '123.123',
        '123٫123',
        '  ',
        '',
        '.',
        'foo',
      ],
    });
  });

  test('should validate hexadecimal strings', () {
    validatorTest({
      'validator': 'isHexadecimal',
      'valid': [
        'deadBEEF',
        'ff0044',
        '0xff0044',
        '0XfF0044',
        '0x0123456789abcDEF',
        '0X0123456789abcDEF',
        '0hfedCBA9876543210',
        '0HfedCBA9876543210',
        '0123456789abcDEF',
      ],
      'invalid': [
        'abcdefg',
        '',
        '..',
        '0xa2h',
        '0xa20x',
        '0x0123456789abcDEFq',
        '0hfedCBA9876543210q',
        '01234q56789abcDEF',
      ],
    });
  });

  test('should validate octal strings', () {
    validatorTest({
      'validator': 'isOctal',
      'valid': [
        '076543210',
        '0o01234567',
      ],
      'invalid': [
        'abcdefg',
        '012345678',
        '012345670c',
        '00c12345670c',
        '',
        '..',
      ],
    });
  });

  test('should validate hexadecimal color strings', () {
    validatorTest({
      'validator': 'isHexColor',
      'valid': [
        '#ff0000ff',
        '#ff0034',
        '#CCCCCC',
        '0f38',
        'fff',
        '#f00',
      ],
      'invalid': [
        '#ff',
        'fff0a',
        '#ff12FG',
      ],
    });
  });

  test('should validate HSL color strings', () {
    validatorTest({
      'validator': 'isHSL',
      'valid': [
        'hsl(360,0000000000100%,000000100%)',
        'hsl(000010, 00000000001%, 00000040%)',
        'HSL(00000,0000000000100%,000000100%)',
        'hsL(0, 0%, 0%)',
        'hSl(  360  , 100%  , 100%   )',
        'Hsl(  00150  , 000099%  , 01%   )',
        'hsl(01080, 03%, 4%)',
        'hsl(-540, 03%, 4%)',
        'hsla(+540, 03%, 4%)',
        'hsla(+540, 03%, 4%, 500)',
        'hsl(+540deg, 03%, 4%, 500)',
        'hsl(+540gRaD, 03%, 4%, 500)',
        'hsl(+540.01e-98rad, 03%, 4%, 500)',
        'hsl(-540.5turn, 03%, 4%, 500)',
        'hsl(+540, 03%, 4%, 500e-01)',
        'hsl(+540, 03%, 4%, 500e+80)',
        'hsl(4.71239rad, 60%, 70%)',
        'hsl(270deg, 60%, 70%)',
        'hsl(200, +.1%, 62%, 1)',
        'hsl(270 60% 70%)',
        'hsl(200, +.1e-9%, 62e10%, 1)',
        'hsl(.75turn, 60%, 70%)',
        // 'hsl(200grad+.1%62%/1)', //supposed to pass, but need to handle delimiters
        'hsl(200grad +.1% 62% / 1)',
        'hsl(270, 60%, 50%, .15)',
        'hsl(270, 60%, 50%, 15%)',
        'hsl(270 60% 50% / .15)',
        'hsl(270 60% 50% / 15%)',
      ],
      'invalid': [
        'hsl (360,0000000000100%,000000100%)',
        'hsl(0260, 100 %, 100%)',
        'hsl(0160, 100%, 100%, 100 %)',
        'hsl(-0160, 100%, 100a)',
        'hsl(-0160, 100%, 100)',
        'hsl(-0160 100%, 100%, )',
        'hsl(270 deg, 60%, 70%)',
        'hsl( deg, 60%, 70%)',
        'hsl(, 60%, 70%)',
        'hsl(3000deg, 70%)',
      ],
    });
  });

  test('should validate rgb color strings', () {
    validatorTest({
      'validator': 'isRgbColor',
      'valid': [
        'rgb(0,0,0)',
        'rgb(255,255,255)',
        'rgba(0,0,0,0)',
        'rgba(255,255,255,1)',
        'rgba(255,255,255,.1)',
        'rgba(255,255,255,0.1)',
        'rgb(5%,5%,5%)',
        'rgba(5%,5%,5%,.3)',
      ],
      'invalid': [
        'rgb(0,0,0,)',
        'rgb(0,0,)',
        'rgb(0,0,256)',
        'rgb()',
        'rgba(0,0,0)',
        'rgba(255,255,255,2)',
        'rgba(255,255,255,.12)',
        'rgba(255,255,256,0.1)',
        'rgb(4,4,5%)',
        'rgba(5%,5%,5%)',
        'rgba(3,3,3%,.3)',
        'rgb(101%,101%,101%)',
        'rgba(3%,3%,101%,0.3)',
      ],
    });

    // test where includePercentValues is given as false
    validatorTest({
      'validator': 'isRgbColor',
      'args': [false],
      'valid': [
        'rgb(5,5,5)',
        'rgba(5,5,5,.3)',
      ],
      'invalid': [
        'rgb(4,4,5%)',
        'rgba(5%,5%,5%)',
      ],
    });
  });

  test('should validate ISRC code strings', () {
    validatorTest({
      'validator': 'isISRC',
      'valid': [
        'USAT29900609',
        'GBAYE6800011',
        'USRC15705223',
        'USCA29500702',
      ],
      'invalid': [
        'USAT2990060',
        'SRC15705223',
        'US-CA29500702',
        'USARC15705223',
      ],
    });
  });

  test('should validate md5 strings', () {
    validatorTest({
      'validator': 'isMD5',
      'valid': [
        'd94f3f016ae679c3008de268209132f2',
        '751adbc511ccbe8edf23d486fa4581cd',
        '88dae00e614d8f24cfd5a8b3f8002e93',
        '0bf1c35032a71a14c2f719e5a14c1e96',
      ],
      'invalid': [
        'KYT0bf1c35032a71a14c2f719e5a14c1',
        'q94375dj93458w34',
        '39485729348',
        '%&FHKJFvk',
      ],
    });
  });

  test('should validate hash strings', () {
    for (var algorithm in ['md5', 'md4', 'ripemd128', 'tiger128']) {
      validatorTest({
        'validator': 'isHash',
        'args': [algorithm],
        'valid': [
          'd94f3f016ae679c3008de268209132f2',
          '751adbc511ccbe8edf23d486fa4581cd',
          '88dae00e614d8f24cfd5a8b3f8002e93',
          '0bf1c35032a71a14c2f719e5a14c1e96',
          'd94f3F016Ae679C3008de268209132F2',
          '88DAE00e614d8f24cfd5a8b3f8002E93',
        ],
        'invalid': [
          'q94375dj93458w34',
          '39485729348',
          '%&FHKJFvk',
          'KYT0bf1c35032a71a14c2f719e5a1',
        ],
      });
    }

    for (var algorithm in ['crc32', 'crc32b']) {
      validatorTest({
        'validator': 'isHash',
        'args': [algorithm],
        'valid': [
          'd94f3f01',
          '751adbc5',
          '88dae00e',
          '0bf1c350',
          '88DAE00e',
          '751aDBc5',
        ],
        'invalid': [
          'KYT0bf1c35032a71a14c2f719e5a14c1',
          'q94375dj93458w34',
          'q943',
          '39485729348',
          '%&FHKJFvk',
        ],
      });
    }

    for (var algorithm in ['sha1', 'tiger160', 'ripemd160']) {
      validatorTest({
        'validator': 'isHash',
        'args': [algorithm],
        'valid': [
          '3ca25ae354e192b26879f651a51d92aa8a34d8d3',
          'aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d',
          'beb8c3f30da46be179b8df5f5ecb5e4b10508230',
          'efd5d3b190e893ed317f38da2420d63b7ae0d5ed',
          'AAF4c61ddCC5e8a2dabede0f3b482cd9AEA9434D',
          '3ca25AE354e192b26879f651A51d92aa8a34d8D3',
        ],
        'invalid': [
          'KYT0bf1c35032a71a14c2f719e5a14c1',
          'KYT0bf1c35032a71a14c2f719e5a14c1dsjkjkjkjkkjk',
          'q94375dj93458w34',
          '39485729348',
          '%&FHKJFvk',
        ],
      });
    }

    validatorTest({
      'validator': 'isHash',
      'args': ['sha256'],
      'valid': [
        '2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824',
        '1d996e033d612d9af2b44b70061ee0e868bfd14c2dd90b129e1edeb7953e7985',
        '80f70bfeaed5886e33536bcfa8c05c60afef5a0e48f699a7912d5e399cdcc441',
        '579282cfb65ca1f109b78536effaf621b853c9f7079664a3fbe2b519f435898c',
        '2CF24dba5FB0a30e26E83b2AC5b9E29E1b161e5C1fa7425E73043362938b9824',
        '80F70bFEAed5886e33536bcfa8c05c60aFEF5a0e48f699a7912d5e399cdCC441',
      ],
      'invalid': [
        'KYT0bf1c35032a71a14c2f719e5a14c1',
        'KYT0bf1c35032a71a14c2f719e5a14c1dsjkjkjkjkkjk',
        'q94375dj93458w34',
        '39485729348',
        '%&FHKJFvk',
      ],
    });

    validatorTest({
      'validator': 'isHash',
      'args': ['sha384'],
      'valid': [
        '3fed1f814d28dc5d63e313f8a601ecc4836d1662a19365cbdcf6870f6b56388850b58043f7ebf2418abb8f39c3a42e31',
        'b330f4e575db6e73500bd3b805db1a84b5a034e5d21f0041d91eec85af1dfcb13e40bb1c4d36a72487e048ac6af74b58',
        'bf547c3fc5841a377eb1519c2890344dbab15c40ae4150b4b34443d2212e5b04aa9d58865bf03d8ae27840fef430b891',
        'fc09a3d11368386530f985dacddd026ae1e44e0e297c805c3429d50744e6237eb4417c20ffca8807b071823af13a3f65',
        '3fed1f814d28dc5d63e313f8A601ecc4836d1662a19365CBDCf6870f6b56388850b58043f7ebf2418abb8f39c3a42e31',
        'b330f4E575db6e73500bd3b805db1a84b5a034e5d21f0041d91EEC85af1dfcb13e40bb1c4d36a72487e048ac6af74b58',
      ],
      'invalid': [
        'KYT0bf1c35032a71a14c2f719e5a14c1',
        'KYT0bf1c35032a71a14c2f719e5a14c1dsjkjkjkjkkjk',
        'q94375dj93458w34',
        '39485729348',
        '%&FHKJFvk',
      ],
    });

    validatorTest({
      'validator': 'isHash',
      'args': ['sha512'],
      'valid': [
        '9b71d224bd62f3785d96d46ad3ea3d73319bfbc2890caadae2dff72519673ca72323c3d99ba5c11d7c7acc6e14b8c5da0c4663475c2e5c3adef46f73bcdec043',
        '83c586381bf5ba94c8d9ba8b6b92beb0997d76c257708742a6c26d1b7cbb9269af92d527419d5b8475f2bb6686d2f92a6649b7f174c1d8306eb335e585ab5049',
        '45bc5fa8cb45ee408c04b6269e9f1e1c17090c5ce26ffeeda2af097735b29953ce547e40ff3ad0d120e5361cc5f9cee35ea91ecd4077f3f589b4d439168f91b9',
        '432ac3d29e4f18c7f604f7c3c96369a6c5c61fc09bf77880548239baffd61636d42ed374f41c261e424d20d98e320e812a6d52865be059745fdb2cb20acff0ab',
        '9B71D224bd62f3785D96d46ad3ea3d73319bFBC2890CAAdae2dff72519673CA72323C3d99ba5c11d7c7ACC6e14b8c5DA0c4663475c2E5c3adef46f73bcDEC043',
        '432AC3d29E4f18c7F604f7c3c96369A6C5c61fC09Bf77880548239baffd61636d42ed374f41c261e424d20d98e320e812a6d52865be059745fdb2cb20acff0ab',
      ],
      'invalid': [
        'KYT0bf1c35032a71a14c2f719e5a14c1',
        'KYT0bf1c35032a71a14c2f719e5a14c1dsjkjkjkjkkjk',
        'q94375dj93458w34',
        '39485729348',
        '%&FHKJFvk',
      ],
    });

    validatorTest({
      'validator': 'isHash',
      'args': ['tiger192'],
      'valid': [
        '6281a1f098c5e7290927ed09150d43ff3990a0fe1a48267c',
        '56268f7bc269cf1bc83d3ce42e07a85632394737918f4760',
        '46fc0125a148788a3ac1d649566fc04eb84a746f1a6e4fa7',
        '7731ea1621ae99ea3197b94583d034fdbaa4dce31a67404a',
        '6281A1f098c5e7290927ed09150d43ff3990a0fe1a48267C',
        '46FC0125a148788a3AC1d649566fc04eb84A746f1a6E4fa7',
      ],
      'invalid': [
        'KYT0bf1c35032a71a14c2f719e5a14c1',
        'KYT0bf1c35032a71a14c2f719e5a14c1dsjkjkjkjkkjk',
        'q94375dj93458w34',
        '39485729348',
        '%&FHKJFvk',
      ],
    });
  });

  test('should validate JWT tokens', () {
    validatorTest({
      'validator': 'isJWT',
      'valid': [
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsb2dnZWRJbkFzIjoiYWRtaW4iLCJpYXQiOjE0MjI3Nzk2Mzh9.gzSraSYS8EXBxLN_oWnFSRgCzcmJmMjLiuyu5CSpyHI',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsb3JlbSI6Imlwc3VtIn0.ymiJSsMJXR6tMSr8G9usjQ15_8hKPDv_CArLhxw28MI',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkb2xvciI6InNpdCIsImFtZXQiOlsibG9yZW0iLCJpcHN1bSJdfQ.rRpe04zbWbbJjwM43VnHzAboDzszJtGrNsUxaqQ-GQ8',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqb2huIjp7ImFnZSI6MjUsImhlaWdodCI6MTg1fSwiamFrZSI6eyJhZ2UiOjMwLCJoZWlnaHQiOjI3MH19.YRLPARDmhGMC3BBk_OhtwwK21PIkVCqQe8ncIRPKo-E',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ', // No signature
      ],
      'invalid': [
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9',
        '\$Zs.ewu.su84',
        'ks64\$S/9.dy\$§kz.3sd73b',
      ],
      // 'error': [
      //   [],
      //   {},
      //   null,
      //   undefined,
      // ],
    });
  });

  test('should validate hex-encoded MongoDB ObjectId', () {
    validatorTest({
      'validator': 'isMongoId',
      'valid': [
        '507f1f77bcf86cd799439011',
      ],
      'invalid': [
        '507f1f77bcf86cd7994390',
        '507f1f77bcf86cd79943901z',
        '',
        '507f1f77bcf86cd799439011 ',
      ],
    });
  });

  test('should validate null strings', () {
    validatorTest({
      'validator': 'isEmpty',
      'valid': [
        '',
      ],
      'invalid': [
        ' ',
        'foo',
        '3',
      ],
    });

    validatorTest({
      'validator': 'isEmpty',
      'args': [
        EmptyOptions(
          ignoreWhitespace: false,
        )
      ],
      'valid': [
        '',
      ],
      'invalid': [
        ' ',
        'foo',
        '3',
      ],
    });

    validatorTest({
      'validator': 'isEmpty',
      'args': [
        EmptyOptions(
          ignoreWhitespace: true,
        )
      ],
      'valid': [
        '',
        ' ',
      ],
      'invalid': [
        'foo',
        '3',
      ],
    });
  });

  test('should validate strings against an expected value', () {
    validatorTest({
      'validator': 'equals',
      'args': ['abc'],
      'valid': ['abc'],
      'invalid': ['Abc', '123'],
    });
  });

  test('should validate strings contain another string', () {
    validatorTest({
      'validator': 'contains',
      'args': ['foo'],
      'valid': ['foo', 'foobar', 'bazfoo'],
      'invalid': ['bar', 'fobar'],
    });

    validatorTest({
      'validator': 'contains',
      'args': [
        'foo',
        ContainsOptions(
          ignoreCase: true,
        )
      ],
      'valid': ['Foo', 'FOObar', 'BAZfoo'],
      'invalid': ['bar', 'fobar', 'baxoof'],
    });

    validatorTest({
      'validator': 'contains',
      'args': [
        'foo',
        ContainsOptions(
          minOccurrences: 2,
        )
      ],
      'valid': ['foofoofoo', '12foo124foo', 'fofooofoooofoooo', 'foo1foo'],
      'invalid': ['foo', 'foobar', 'Fooofoo', 'foofo'],
    });
  });

  test('should validate strings against a pattern', () {
    validatorTest({
      'validator': 'matches',
      'args': [RegExp('abc')],
      'valid': ['abc', 'abcdef', '123abc'],
      'invalid': ['acb', 'Abc'],
    });

    // validatorTest({
    //   'validator': 'matches',
    //   'args': ['abc'],
    //   'valid': ['abc', 'abcdef', '123abc'],
    //   'invalid': ['acb', 'Abc'],
    // });

    validatorTest({
      'validator': 'matches',
      'args': [RegExp('abc', caseSensitive: false)],
      'valid': ['abc', 'abcdef', '123abc', 'AbC'],
      'invalid': ['acb'],
    });
  });

  test('should validate strings by length', () {
    validatorTest({
      'validator': 'isLength',
      'args': [
        LengthOptions(
          min: 2,
        )
      ],
      'valid': ['abc', 'de', 'abcd'],
      'invalid': ['', 'a'],
    });

    validatorTest({
      'validator': 'isLength',
      'args': [LengthOptions(min: 2, max: 3)],
      'valid': ['abc', 'de'],
      'invalid': ['', 'a', 'abcd'],
    });

    validatorTest({
      'validator': 'isLength',
      'args': [
        LengthOptions(
          min: 2,
          max: 3,
        )
      ],
      'valid': ['干𩸽', '𠮷野家'],
      'invalid': ['', '𠀋', '千竈通り'],
    });

    validatorTest({
      'validator': 'isLength',
      'args': [
        LengthOptions(
          max: 3,
        )
      ],
      'valid': ['abc', 'de', 'a', ''],
      'invalid': ['abcd'],
    });

    validatorTest({
      'validator': 'isLength',
      'args': [
        LengthOptions(
          max: 0,
        )
      ],
      'valid': [''],
      'invalid': ['a', 'ab'],
    });

    validatorTest({
      'validator': 'isLength',
      'valid': ['a', '', 'asds'],
    });

    validatorTest({
      'validator': 'isLength',
      'args': [
        LengthOptions(
          max: 8,
        )
      ],
      'valid': ['👩🦰👩👩👦👦🏳️🌈', '⏩︎⏩︎⏪︎⏪︎⏭︎⏭︎⏮︎⏮︎'],
    });
  });

  test('should validate isLocale codes', () {
    validatorTest({
      'validator': 'isLocale',
      'valid': [
        'uz_Latn_UZ',
        'en',
        'gsw',
        'es_ES',
        'sw_KE',
        'am_ET',
        'ca_ES_VALENCIA',
        'en_US_POSIX',
      ],
      'invalid': [
        'lo_POP',
        '12',
        '12_DD',
      ],
    });
  });

  test('should validate strings by byte length', () {
    validatorTest({
      'validator': 'isByteLength',
      'args': [
        ByteLengthOptions(
          min: 2,
        )
      ],
      'valid': ['abc', 'de', 'abcd', 'ｇｍａｉｌ'],
      'invalid': ['', 'a'],
    });

    validatorTest({
      'validator': 'isByteLength',
      'args': [
        ByteLengthOptions(
          min: 2,
          max: 3,
        )
      ],
      'valid': ['abc', 'de', 'ｇ'],
      'invalid': ['', 'a', 'abcd', 'ｇｍ'],
    });

    validatorTest({
      'validator': 'isByteLength',
      'args': [
        ByteLengthOptions(
          max: 3,
        )
      ],
      'valid': ['abc', 'de', 'ｇ', 'a', ''],
      'invalid': ['abcd', 'ｇｍ'],
    });

    validatorTest({
      'validator': 'isByteLength',
      'args': [
        ByteLengthOptions(
          max: 0,
        )
      ],
      'valid': [''],
      'invalid': ['ｇ', 'a'],
    });
  });

  test('should validate UUIDs', () {
    validatorTest({
      'validator': 'isUUID',
      'valid': [
        'A987FBC9-4BED-3078-CF07-9141BA07C9F3',
        'A987FBC9-4BED-4078-8F07-9141BA07C9F3',
        'A987FBC9-4BED-5078-AF07-9141BA07C9F3',
      ],
      'invalid': [
        '',
        'xxxA987FBC9-4BED-3078-CF07-9141BA07C9F3',
        'A987FBC9-4BED-3078-CF07-9141BA07C9F3xxx',
        'A987FBC94BED3078CF079141BA07C9F3',
        '934859',
        '987FBC9-4BED-3078-CF07A-9141BA07C9F3',
        'AAAAAAAA-1111-1111-AAAG-111111111111',
      ],
    });

    validatorTest({
      'validator': 'isUUID',
      'args': [null],
      'valid': [
        'A117FBC9-4BED-3078-CF07-9141BA07C9F3',
        'A117FBC9-4BED-5078-AF07-9141BA07C9F3',
      ],
      'invalid': [
        '',
        'xxxA987FBC9-4BED-3078-CF07-9141BA07C9F3',
        'A987FBC94BED3078CF079141BA07C9F3',
        'A11AAAAA-1111-1111-AAAG-111111111111',
      ],
    });

    validatorTest({
      'validator': 'isUUID',
      'args': [null],
      'valid': [
        'A127FBC9-4BED-3078-CF07-9141BA07C9F3',
      ],
      'invalid': [
        '',
        'xxxA987FBC9-4BED-3078-CF07-9141BA07C9F3',
        'A127FBC9-4BED-3078-CF07-9141BA07C9F3xxx',
        '912859',
        'A12AAAAA-1111-1111-AAAG-111111111111',
      ],
    });

    validatorTest({
      'validator': 'isUUID',
      'args': [1],
      'valid': [
        'E034B584-7D89-11E9-9669-1AECF481A97B',
      ],
      'invalid': [
        'xxxA987FBC9-4BED-3078-CF07-9141BA07C9F3',
        'AAAAAAAA-1111-2222-AAAG',
        'AAAAAAAA-1111-2222-AAAG-111111111111',
        'A987FBC9-4BED-4078-8F07-9141BA07C9F3',
        'A987FBC9-4BED-5078-AF07-9141BA07C9F3',
      ],
    });

    validatorTest({
      'validator': 'isUUID',
      'args': [2],
      'valid': [
        'A987FBC9-4BED-2078-CF07-9141BA07C9F3',
      ],
      'invalid': [
        '',
        'xxxA987FBC9-4BED-3078-CF07-9141BA07C9F3',
        '11111',
        'AAAAAAAA-1111-1111-AAAG-111111111111',
        'A987FBC9-4BED-4078-8F07-9141BA07C9F3',
        'A987FBC9-4BED-5078-AF07-9141BA07C9F3',
      ],
    });

    validatorTest({
      'validator': 'isUUID',
      'args': [3],
      'valid': [
        'A987FBC9-4BED-3078-CF07-9141BA07C9F3',
      ],
      'invalid': [
        '',
        'xxxA987FBC9-4BED-3078-CF07-9141BA07C9F3',
        '934859',
        'AAAAAAAA-1111-1111-AAAG-111111111111',
        'A987FBC9-4BED-4078-8F07-9141BA07C9F3',
        'A987FBC9-4BED-5078-AF07-9141BA07C9F3',
      ],
    });

    validatorTest({
      'validator': 'isUUID',
      'args': [4],
      'valid': [
        '713ae7e3-cb32-45f9-adcb-7c4fa86b90c1',
        '625e63f3-58f5-40b7-83a1-a72ad31acffb',
        '57b73598-8764-4ad0-a76a-679bb6640eb1',
        '9c858901-8a57-4791-81fe-4c455b099bc9',
      ],
      'invalid': [
        '',
        'xxxA987FBC9-4BED-3078-CF07-9141BA07C9F3',
        '934859',
        'AAAAAAAA-1111-1111-AAAG-111111111111',
        'A987FBC9-4BED-5078-AF07-9141BA07C9F3',
        'A987FBC9-4BED-3078-CF07-9141BA07C9F3',
      ],
    });

    validatorTest({
      'validator': 'isUUID',
      'args': [5],
      'valid': [
        '987FBC97-4BED-5078-AF07-9141BA07C9F3',
        '987FBC97-4BED-5078-BF07-9141BA07C9F3',
        '987FBC97-4BED-5078-8F07-9141BA07C9F3',
        '987FBC97-4BED-5078-9F07-9141BA07C9F3',
      ],
      'invalid': [
        '',
        'xxxA987FBC9-4BED-3078-CF07-9141BA07C9F3',
        '934859',
        'AAAAAAAA-1111-1111-AAAG-111111111111',
        '9c858901-8a57-4791-81fe-4c455b099bc9',
        'A987FBC9-4BED-3078-CF07-9141BA07C9F3',
      ],
    });

    validatorTest({
      'validator': 'isUUID',
      'args': [6],
      'valid': [],
      'invalid': [
        '987FBC97-4BED-1078-AF07-9141BA07C9F3',
        '987FBC97-4BED-2078-AF07-9141BA07C9F3',
        '987FBC97-4BED-3078-AF07-9141BA07C9F3',
        '987FBC97-4BED-4078-AF07-9141BA07C9F3',
        '987FBC97-4BED-5078-AF07-9141BA07C9F3',
      ],
    });
  });

  test('should validate a string that is in another string or array', () {
    validatorTest({
      'validator': 'isIn',
      'args': ['foobar'],
      'valid': ['foo', 'bar', 'foobar', ''],
      'invalid': ['foobarbaz', 'barfoo'],
    });

    validatorTest({
      'validator': 'isIn',
      'args': [
        ['foo', 'bar']
      ],
      'valid': ['foo', 'bar'],
      'invalid': ['foobar', 'barfoo', ''],
    });

    validatorTest({
      'validator': 'isIn',
      'args': [
        ['1', '2', '3']
      ],
      'valid': ['1', '2', '3'],
      'invalid': ['4', ''],
    });

    validatorTest({
      'validator': 'isIn',
      'args': [
        [
          '1',
          '2',
          '3',
          {'foo': 'bar'},
          () => 5,
          {'toString': 'test'}
        ]
      ],
      'valid': ['1', '2', '3', ''],
      'invalid': ['4'],
    });

    validatorTest({
      'validator': 'isIn',
      'invalid': ['foo', '']
    });
  });

  test('should validate a string that is in another object', () {
    validatorTest({
      'validator': 'isIn',
      'args': [
        {'foo': 1, 'bar': 2, 'foobar': 3}
      ],
      'valid': ['foo', 'bar', 'foobar'],
      'invalid': ['foobarbaz', 'barfoo', ''],
    });

    validatorTest({
      'validator': 'isIn',
      'args': [
        {'1': 3, '2': 0, '3': 1}
      ],
      'valid': ['1', '2', '3'],
      'invalid': ['4', ''],
    });
  });

  test('should validate dates against a start date', () {
    validatorTest({
      'validator': 'isAfter',
      'args': ['2011-08-03'],
      'valid': ['2011-08-04', DateTime(2011, 8, 10).toString()],
      'invalid': ['2010-07-02', '2011-08-03', DateTime(0).toString(), 'foo'],
    });

    validatorTest({
      'validator': 'isAfter',
      'valid': [
        '2100-08-04',
        DateTime.fromMicrosecondsSinceEpoch(DateTime.now()
                .add(Duration(microseconds: 86400000))
                .microsecondsSinceEpoch)
            .toString()
      ],
      'invalid': ['2010-07-02', DateTime(0).toString()],
    });

    validatorTest({
      'validator': 'isAfter',
      'args': ['2011-08-03'],
      'valid': ['2015-09-17'],
      'invalid': ['invalid date'],
    });

    validatorTest({
      'validator': 'isAfter',
      'args': ['invalid date'],
      'invalid': ['invalid date', '2015-09-17'],
    });
  });

  test('should validate dates against an end date', () {
    validatorTest({
      'validator': 'isBefore',
      'args': ['2011-08-04'],
      'valid': ['2010-07-02', '2010-08-04', DateTime(0).toString()],
      // 08/04/2011 format is not supported
      'invalid': ['2011-08-04', DateTime(2011, 9, 10).toString()],
    });

    validatorTest({
      'validator': 'isBefore',
      'args': [DateTime(2011, 7, 4).toString()],
      'valid': ['2010-07-02', '2010-08-04', DateTime(0).toString()],
      // 08/04/2011 format is not supported
      'invalid': ['2011-08-04', DateTime(2011, 9, 10).toString()],
    });

    validatorTest({
      'validator': 'isBefore',
      'valid': [
        '2000-08-04',
        DateTime(0).toString(),
        DateTime.fromMicrosecondsSinceEpoch(DateTime.now()
                .subtract(Duration(microseconds: 86400000))
                .microsecondsSinceEpoch)
            .toString(),
      ],
      'invalid': ['2100-07-02', DateTime(2217, 10, 10).toString()],
    });

    validatorTest({
      'validator': 'isBefore',
      'args': ['2011-08-03'],
      'valid': ['1999-12-31'],
      'invalid': ['invalid date'],
    });

    validatorTest({
      'validator': 'isBefore',
      'args': ['invalid date'],
      'invalid': ['invalid date', '1999-12-31'],
    });
  });

  test('should validate IBAN', () {
    validatorTest({
      'validator': 'isIBAN',
      'valid': [
        'SC52BAHL01031234567890123456USD',
        'LC14BOSL123456789012345678901234',
        'MT31MALT01100000000000000000123',
        'SV43ACAT00000000000000123123',
        'EG800002000156789012345180002',
        'BE71 0961 2345 6769',
        'FR76 3000 6000 0112 3456 7890 189',
        'DE91 1000 0000 0123 4567 89',
        'GR96 0810 0010 0000 0123 4567 890',
        'RO09 BCYP 0000 0012 3456 7890',
        'SA44 2000 0001 2345 6789 1234',
        'ES79 2100 0813 6101 2345 6789',
        'CH56 0483 5012 3456 7800 9',
        'GB98 MIDL 0700 9312 3456 78',
        'IL170108000000012612345',
        'IT60X0542811101000000123456',
        'JO71CBJO0000000000001234567890',
        'TR320010009999901234567890',
        'BR1500000000000010932840814P2',
        'LB92000700000000123123456123',
        'IR200170000000339545727003',
        'MZ97123412341234123412341',
      ],
      'invalid': [
        'XX22YYY1234567890123',
        'FR14 2004 1010 0505 0001 3',
        'FR7630006000011234567890189@',
        'FR7630006000011234567890189😅',
        'FR763000600001123456!!🤨7890189@',
      ],
    });
  });

  test('should validate BIC codes', () {
    validatorTest({
      'validator': 'isBIC',
      'valid': [
        'SBICKEN1345',
        'SBICKEN1',
        'SBICKENY',
        'SBICKEN1YYP',
      ],
      'invalid': [
        'SBIC23NXXX',
        'S23CKENXXXX',
        'SBICKENXX',
        'SBICKENXX9',
        'SBICKEN13458',
        'SBICKEN',
      ],
    });
  });

  test('should validate that integer strings are divisible by a number', () {
    validatorTest({
      'validator': 'isDivisibleBy',
      'args': [2],
      'valid': ['2', '4', '100', '1000'],
      'invalid': [
        '1',
        '2.5',
        '101',
        'foo',
        '',
        '2020-01-06T14:31:00.135Z',
      ],
    });
  });

  test('should validate luhn numbers', () {
    validatorTest({
      'validator': 'isLuhnValid',
      'valid': [
        '0',
        '5421',
        '01234567897',
        '0123456789012345678906',
        '0123456789012345678901234567891',
        '123456789012345678906',
        '375556917985515',
        '36050234196908',
        '4716461583322103',
        '4716-2210-5188-5662',
        '4929 7226 5379 7141',
      ],
      'invalid': [
        '',
        '1',
        '5422',
        'foo',
        'prefix6234917882863855',
        '623491788middle2863855',
        '6234917882863855suffix',
      ],
    });
  });

  test('should validate ISO 3166-1 alpha 2 country codes', () {
    // from https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
    validatorTest({
      'validator': 'isISO31661Alpha2',
      'valid': [
        'FR',
        'fR',
        'GB',
        'PT',
        'CM',
        'JP',
        'PM',
        'ZW',
        'MM',
        'cc',
        'GG',
      ],
      'invalid': [
        '',
        'FRA',
        'AA',
        'PI',
        'RP',
        'WV',
        'WL',
        'UK',
        'ZZ',
      ],
    });
  });

  test('should validate base64 strings', () {
    validatorTest({
      'validator': 'isBase64',
      'valid': [
        '',
        'Zg==',
        'Zm8=',
        'Zm9v',
        'Zm9vYg==',
        'Zm9vYmE=',
        'Zm9vYmFy',
        'TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2NpbmcgZWxpdC4=',
        'Vml2YW11cyBmZXJtZW50dW0gc2VtcGVyIHBvcnRhLg==',
        'U3VzcGVuZGlzc2UgbGVjdHVzIGxlbw==',
        // ignore: prefer_interpolation_to_compose_strings
        'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuMPNS1Ufof9EW/M98FNw' +
            'UAKrwflsqVxaxQjBQnHQmiI7Vac40t8x7pIb8gLGV6wL7sBTJiPovJ0V7y7oc0Ye' +
            'rhKh0Rm4skP2z/jHwwZICgGzBvA0rH8xlhUiTvcwDCJ0kc+fh35hNt8srZQM4619' +
            'FTgB66Xmp4EtVyhpQV+t02g6NzK72oZI0vnAvqhpkxLeLiMCyrI416wHm5Tkukhx' +
            'QmcL2a6hNOyu0ixX/x2kSFXApEnVrJ+/IxGyfyw8kf4N2IZpW5nEP847lpfj0SZZ' +
            'Fwrd1mnfnDbYohX2zRptLy2ZUn06Qo9pkG5ntvFEPo9bfZeULtjYzIl6K8gJ2uGZ' +
            'HQIDAQAB',
      ],
      'invalid': [
        '12345',
        'Vml2YW11cyBmZXJtZtesting123',
        'Zg=',
        'Z===',
        'Zm=8',
        '=m9vYg==',
        'Zm9vYmFy====',
      ],
    });

    validatorTest({
      'validator': 'isBase64',
      'args': [
        Base64Options(
          urlSafe: true,
        )
      ],
      'valid': [
        '',
        'bGFkaWVzIGFuZCBnZW50bGVtZW4sIHdlIGFyZSBmbG9hdGluZyBpbiBzcGFjZQ',
        '1234',
        'bXVtLW5ldmVyLXByb3Vk',
        'PDw_Pz8-Pg',
        'VGhpcyBpcyBhbiBlbmNvZGVkIHN0cmluZw',
      ],
      'invalid': [
        ' AA',
        '\tAA',
        '\rAA',
        '\nAA',
        'This+isa/bad+base64Url==',
        '0K3RgtC+INC30LDQutC+0LTQuNGA0L7QstCw0L3QvdCw0Y8g0YHRgtGA0L7QutCw',
      ],
      // error: [
      //   null,
      //   undefined,
      //   {},
      //   [],
      //   42,
      // ],
    });

    for (int i = 0; i < 1000; i++) {
      String str = '';
      for (int j = 0; j < 26; j++) {
        str += String.fromCharCode(Random().nextInt(26) + 97);
      }
      final String encoded = base64Encode(utf8.encode(str));
      if (!Validator.isBase64(encoded)) {
        throw Exception('validator.isBase64() failed with "$encoded"');
      }
    }
  });
}
