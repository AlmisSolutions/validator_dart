import 'package:validator_dart/extensions/list_extensions.dart';
import 'package:validator_dart/src/validators/is_byte_length.dart';
import 'package:validator_dart/src/validators/is_fqdn.dart';
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
  if (option == 'isIP') {
    return Validator.isIP(args.get(0), version: args.get(1));
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
