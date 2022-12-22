import 'package:validator_dart/extensions/list_extensions.dart';
import 'package:validator_dart/src/validators/is_byte_length.dart';
import 'package:validator_dart/src/validators/is_email.dart';
import 'package:validator_dart/src/validators/is_fqdn.dart';
import 'package:validator_dart/src/validators/is_mac_address.dart';
import 'package:validator_dart/src/validators/is_url.dart';
import 'package:validator_dart/validator_dart.dart';
import 'package:test/test.dart';

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
  } else if (option == 'isByteLength') {
    return Validator.isByteLength(args.get(0), options: args.get(1));
  } else if (option == 'isUppercase') {
    return Validator.isUppercase(args.get(0));
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

  test('should validate strings by byte length (deprecated api)', () {
    validatorTest({
      'validator': 'isByteLength',
      'args': [ByteLengthOptions(min: 2)],
      'valid': ['abc', 'de', 'abcd', 'ｇｍａｉｌ'],
      'invalid': ['', 'a'],
    });
    validatorTest({
      'validator': 'isByteLength',
      'args': [ByteLengthOptions(min: 2, max: 3)],
      'valid': ['abc', 'de', 'ｇ'],
      'invalid': ['', 'a', 'abcd', 'ｇｍ'],
    });
    validatorTest({
      'validator': 'isByteLength',
      'args': [ByteLengthOptions(min: 0, max: 0)],
      'valid': [''],
      'invalid': ['ｇ', 'a'],
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
}
