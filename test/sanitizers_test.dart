import 'package:validator_dart/extensions/list_extensions.dart';
import 'package:validator_dart/src/validators/is_strong_password.dart';
import 'package:validator_dart/src/validators/normalize_email.dart';
import 'package:validator_dart/validator_dart.dart';
import 'package:test/test.dart';

void validatorTest(options) {
  List<dynamic> args = (options['args'] as List? ?? []).map((e) => e).toList();

  args.insert(0, null);

  options['expect'].keys.forEach((dynamic input) {
    args[0] = input.toString();
    dynamic result = callMethod(options['sanitizer'], args);
    dynamic expected = options['expect'][input];

    // identical is used for double.nan values
    if (result != expected && !identical(result, expected)) {
      String warning =
          'validator.${options['sanitizer']}(${args.join(', ')}) returned "$result" but should have returned "$expected"';
      throw Exception(warning);
    }
  });
}

dynamic callMethod(option, List args) {
  if (option == 'toBoolean') {
    return Validator.toBoolean(args.get(0), args.get(1));
  } else if (option == 'ltrim') {
    return Validator.ltrim(args.get(0), args.get(1));
  } else if (option == 'rtrim') {
    return Validator.rtrim(args.get(0), args.get(1));
  } else if (option == 'trim') {
    return Validator.trim(args.get(0), args.get(1));
  } else if (option == 'toInt') {
    return Validator.toInt(args.get(0), radix: args.get(1));
  } else if (option == 'toFloat') {
    return Validator.toFloat(args.get(0));
  } else if (option == 'escape') {
    return Validator.escape(args.get(0));
  } else if (option == 'unescape') {
    return Validator.unescape(args.get(0));
  } else if (option == 'stripLow') {
    return Validator.stripLow(args.get(0), keepNewLines: args.get(1));
  } else if (option == 'whitelist') {
    return Validator.whitelist(args.get(0), args.get(1));
  } else if (option == 'blacklist') {
    return Validator.blacklist(args.get(0), args.get(1));
  } else if (option == 'isStrongPassword') {
    return Validator.isStrongPassword(args.get(0), options: args.get(1));
  } else if (option == 'normalizeEmail') {
    return Validator.normalizeEmail(args.get(0), options: args.get(1));
  }

  return null;
}

void main() {
  group('Sanitizers', () {
    test('should sanitize boolean strings', () {
      validatorTest({
        'sanitizer': 'toBoolean',
        'expect': {
          0: false,
          '': false,
          1: true,
          true: true,
          'True': true,
          'TRUE': true,
          'foobar': true,
          '   ': true,
          false: false,
          'False': false,
          'FALSE': false,
        },
      });
      validatorTest({
        'sanitizer': 'toBoolean',
        'args': [true], // strict
        'expect': {
          0: false,
          '': false,
          1: true,
          true: true,
          'True': true,
          'TRUE': true,
          'foobar': false,
          '   ': false,
          false: false,
          'False': false,
          'FALSE': false,
        },
      });
    });

    test('should trim whitespace', () {
      validatorTest({
        'sanitizer': 'trim',
        'expect': {
          '  \r\n\tfoo  \r\n\t   ': 'foo',
          '      \r': '',
        },
      });

      validatorTest({
        'sanitizer': 'ltrim',
        'expect': {
          '  \r\n\tfoo  \r\n\t   ': 'foo  \r\n\t   ',
          '   \t  \n': '',
        },
      });

      validatorTest({
        'sanitizer': 'rtrim',
        'expect': {
          '  \r\n\tfoo  \r\n\t   ': '  \r\n\tfoo',
          ' \r\n  \t': '',
        },
      });
    });

    test('should trim custom characters', () {
      validatorTest({
        'sanitizer': 'trim',
        'args': ['01'],
        'expect': {'010100201000': '2'},
      });

      validatorTest({
        'sanitizer': 'ltrim',
        'args': ['01'],
        'expect': {'010100201000': '201000'},
      });

      validatorTest({
        'sanitizer': 'ltrim',
        'args': ['\\S'],
        'expect': {'\\S01010020100001': '01010020100001'},
      });

      validatorTest({
        'sanitizer': 'rtrim',
        'args': ['01'],
        'expect': {'010100201000': '0101002'},
      });

      validatorTest({
        'sanitizer': 'rtrim',
        'args': ['\\S'],
        'expect': {'01010020100001\\S': '01010020100001'},
      });
    });

    test('should convert strings to integers', () {
      validatorTest({
        'sanitizer': 'toInt',
        'expect': {
          3: 3,
          ' 3 ': 3,
          2.4: 2,
          // cannot return NaN like in JS version because NaN is double
          'foo': null,
        },
      });

      validatorTest({
        'sanitizer': 'toInt',
        'args': [16],
        'expect': {'ff': 255},
      });
    });

    test('should convert strings to floats', () {
      validatorTest({
        'sanitizer': 'toFloat',
        'expect': {
          2: 2,
          '2.': 2,
          '-2.5': -2.5,
          '.5': 0.5,
          '2020-01-06T14:31:00.135Z': double.nan,
          'foo': double.nan,
        },
      });
    });

    test('should escape HTML', () {
      validatorTest({
        'sanitizer': 'escape',
        'expect': {
          '<script> alert("xss&fun"); </script>':
              '&lt;script&gt; alert(&quot;xss&amp;fun&quot;); &lt;&#x2F;script&gt;',
          "<script> alert('xss&fun'); </script>":
              '&lt;script&gt; alert(&#x27;xss&amp;fun&#x27;); &lt;&#x2F;script&gt;',
          'Backtick: `': 'Backtick: &#96;',
          'Backslash: \\': 'Backslash: &#x5C;',
        },
      });
    });

    test('should unescape HTML', () {
      validatorTest({
        'sanitizer': 'unescape',
        'expect': {
          '&lt;script&gt; alert(&quot;xss&amp;fun&quot;); &lt;&#x2F;script&gt;':
              '<script> alert("xss&fun"); </script>',
          '&lt;script&gt; alert(&#x27;xss&amp;fun&#x27;); &lt;&#x2F;script&gt;':
              "<script> alert('xss&fun'); </script>",
          'Backtick: &#96;': 'Backtick: `',
          'Escaped string: &amp;lt;': 'Escaped string: &lt;',
        },
      });
    });

    test('should remove control characters (<32 and 127)', () {
      // Check basic functionality
      validatorTest({
        'sanitizer': 'stripLow',
        'expect': {
          'foo\x00': 'foo',
          '\x7Ffoo\x02': 'foo',
          '\x01\x09': '',
          'foo\x0A\x0D': 'foo',
        },
      });
      // Unicode safety
      validatorTest({
        'sanitizer': 'stripLow',
        'expect': {
          'perché': 'perch\u00e9',
          '\u20ac': '\u20ac',
          '\u2206\x0A': '\u2206',
          '\ud83d\ude04': '\ud83d\ude04',
        },
      });
      // Preserve newlines
      validatorTest({
        'sanitizer': 'stripLow',
        'args': [true], // keep_new_lines
        'expect': {
          'foo\x0A\x0D': 'foo\x0A\x0D',
          '\x03foo\x0A\x0D': 'foo\x0A\x0D',
        },
      });
    });

    test('should sanitize a string based on a whitelist', () {
      validatorTest({
        'sanitizer': 'whitelist',
        'args': ['abc'],
        'expect': {
          'abcdef': 'abc',
          'aaaaaaaaaabbbbbbbbbb': 'aaaaaaaaaabbbbbbbbbb',
          'a1b2c3': 'abc',
          '   ': '',
        },
      });
    });

    test('should sanitize a string based on a blacklist', () {
      validatorTest({
        'sanitizer': 'blacklist',
        'args': ['abc'],
        'expect': {
          'abcdef': 'def',
          'aaaaaaaaaabbbbbbbbbb': '',
          'a1b2c3': '123',
          '   ': '   ',
        },
      });
    });

    test('should score passwords', () {
      validatorTest({
        'sanitizer': 'isStrongPassword',
        'args': [
          PasswordOptions(
            returnScore: true,
            pointsPerUnique: 1,
            pointsPerRepeat: 0.5,
            pointsForContainingLower: 10,
            pointsForContainingUpper: 10,
            pointsForContainingNumber: 10,
            pointsForContainingSymbol: 10,
          )
        ],
        'expect': {
          'abc': 13,
          'abcc': 13.5,
          'aBc': 23,
          'Abc123!': 47,
          '!@#\$%^&*()': 20,
        },
      });
    });

    test('should score passwords with default options', () {
      validatorTest({
        'sanitizer': 'isStrongPassword',
        'expect': {
          'abc': false,
          'abcc': false,
          'aBc': false,
          'Abc123!': false,
          '!@#\$%^&*()': false,
          'abc123!@f#rA': true,
        },
      });
    });

    test('should normalize an email based on domain', () {
      validatorTest({
        'sanitizer': 'normalizeEmail',
        'expect': {
          'test@me.com': 'test@me.com',
          'some.name@gmail.com': 'somename@gmail.com',
          'some.name@googleMail.com': 'somename@gmail.com',
          'some.name+extension@gmail.com': 'somename@gmail.com',
          'some.Name+extension@GoogleMail.com': 'somename@gmail.com',
          'some.name.middleName+extension@gmail.com':
              'somenamemiddlename@gmail.com',
          'some.name.middleName+extension@GoogleMail.com':
              'somenamemiddlename@gmail.com',
          'some.name.midd.leNa.me.+extension@gmail.com':
              'somenamemiddlename@gmail.com',
          'some.name.midd.leNa.me.+extension@GoogleMail.com':
              'somenamemiddlename@gmail.com',
          'some.name+extension@unknown.com': 'some.name+extension@unknown.com',
          'hans@m端ller.com': 'hans@m端ller.com',
          'some.name.midd..leNa...me...+extension@GoogleMail.com':
              'somenamemidd..lena...me...@gmail.com',
          'matthew..example@gmail.com': 'matthew..example@gmail.com',
          '"foo@bar"@baz.com': '"foo@bar"@baz.com',
          'test@ya.ru': 'test@yandex.ru',
          'test@yandex.kz': 'test@yandex.ru',
          'test@yandex.ru': 'test@yandex.ru',
          'test@yandex.ua': 'test@yandex.ru',
          'test@yandex.com': 'test@yandex.ru',
          'test@yandex.by': 'test@yandex.ru',
          // cannot compare to false like in JS version because dart is
          // strongly-typed
          // '@gmail.com': false,
          // '@icloud.com': false,
          // '@outlook.com': false,
          // '@yahoo.com': false,
          '@gmail.com': '',
          '@icloud.com': '',
          '@outlook.com': '',
          '@yahoo.com': '',
        },
      });

      // Testing all_lowercase switch, should apply to domains not known to be case-insensitive
      validatorTest({
        'sanitizer': 'normalizeEmail',
        'args': [EmailNormalizationOptions(allLowercase: false)],
        'expect': {
          'test@foo.com': 'test@foo.com',
          'hans@m端ller.com': 'hans@m端ller.com',
          'test@FOO.COM': 'test@foo.com', // Hostname is always lowercased
          'blAH@x.com': 'blAH@x.com',
          // In case of domains that are known to be case-insensitive, there's a separate switch
          'TEST@me.com': 'test@me.com',
          'TEST@ME.COM': 'test@me.com',
          'SOME.name@GMAIL.com': 'somename@gmail.com',
          'SOME.name.middleName+extension@GoogleMail.com':
              'somenamemiddlename@gmail.com',
          'SOME.name.midd.leNa.me.+extension@gmail.com':
              'somenamemiddlename@gmail.com',
          'SOME.name@gmail.com': 'somename@gmail.com',
          'SOME.name@yahoo.ca': 'some.name@yahoo.ca',
          'SOME.name@outlook.ie': 'some.name@outlook.ie',
          'SOME.name@me.com': 'some.name@me.com',
          'SOME.name@yandex.ru': 'some.name@yandex.ru',
        },
      });

      // Testing *_lowercase
      validatorTest({
        'sanitizer': 'normalizeEmail',
        'args': [
          EmailNormalizationOptions(
            allLowercase: false,
            gmailLowercase: false,
            icloudLowercase: false,
            outlookdotcomLowercase: false,
            yahooLowercase: false,
            yandexLowercase: false,
          )
        ],
        'expect': {
          'TEST@FOO.COM': 'TEST@foo.com', // all_lowercase
          'ME@gMAil.com': 'ME@gmail.com', // gmail_lowercase
          'ME@me.COM': 'ME@me.com', // icloud_lowercase
          'ME@icloud.COM': 'ME@icloud.com', // icloud_lowercase
          'ME@outlook.COM': 'ME@outlook.com', // outlookdotcom_lowercase
          'JOHN@live.CA': 'JOHN@live.ca', // outlookdotcom_lowercase
          'ME@ymail.COM': 'ME@ymail.com', // yahoo_lowercase
          'ME@yandex.RU': 'ME@yandex.ru', // yandex_lowercase
        },
      });

      // Testing all_lowercase
      // Should overwrite all the *_lowercase options
      validatorTest({
        'sanitizer': 'normalizeEmail',
        'args': [
          EmailNormalizationOptions(
            allLowercase: true,
            gmailLowercase: false, // Overruled
            icloudLowercase: false, // Overruled
            outlookdotcomLowercase: false, // Overruled
            yahooLowercase: false, // Overruled
          )
        ],
        'expect': {
          'TEST@FOO.COM': 'test@foo.com', // all_lowercase
          'ME@gMAil.com': 'me@gmail.com', // gmail_lowercase
          'ME@me.COM': 'me@me.com', // icloud_lowercase
          'ME@icloud.COM': 'me@icloud.com', // icloud_lowercase
          'ME@outlook.COM': 'me@outlook.com', // outlookdotcom_lowercase
          'JOHN@live.CA': 'john@live.ca', // outlookdotcom_lowercase
          'ME@ymail.COM': 'me@ymail.com', // yahoo_lowercase
        },
      });

      // Testing *_remove_dots
      validatorTest({
        'sanitizer': 'normalizeEmail',
        'args': [
          EmailNormalizationOptions(
            gmailRemoveDots: false,
          )
        ],
        'expect': {
          'SOME.name@GMAIL.com': 'some.name@gmail.com',
          'SOME.name+me@GMAIL.com': 'some.name@gmail.com',
          'my.self@foo.com': 'my.self@foo.com',
        },
      });

      validatorTest({
        'sanitizer': 'normalizeEmail',
        'args': [
          EmailNormalizationOptions(
            gmailRemoveDots: true,
          )
        ],
        'expect': {
          'SOME.name@GMAIL.com': 'somename@gmail.com',
          'SOME.name+me@GMAIL.com': 'somename@gmail.com',
          'some.name..multiple@gmail.com': 'somename..multiple@gmail.com',
          'my.self@foo.com': 'my.self@foo.com',
        },
      });

      // Testing *_remove_subaddress
      validatorTest({
        'sanitizer': 'normalizeEmail',
        'args': [
          EmailNormalizationOptions(
            gmailRemoveSubaddress: false,
            icloudRemoveSubaddress: false,
            outlookdotcomRemoveSubaddress: false,
            yahooRemoveSubaddress: false, // Note Yahoo uses "-"
          )
        ],
        'expect': {
          'foo+bar@unknown.com': 'foo+bar@unknown.com',
          'foo+bar@gmail.com': 'foo+bar@gmail.com', // gmail_remove_subaddress
          'foo+bar@me.com': 'foo+bar@me.com', // icloud_remove_subaddress
          'foo+bar@icloud.com':
              'foo+bar@icloud.com', // icloud_remove_subaddress
          'foo+bar@live.fr':
              'foo+bar@live.fr', // outlookdotcom_remove_subaddress
          'foo+bar@hotmail.co.uk':
              'foo+bar@hotmail.co.uk', // outlookdotcom_remove_subaddress
          'foo-bar@yahoo.com': 'foo-bar@yahoo.com', // yahoo_remove_subaddress
          'foo+bar@yahoo.com': 'foo+bar@yahoo.com', // yahoo_remove_subaddress
        },
      });

      validatorTest({
        'sanitizer': 'normalizeEmail',
        'args': [
          EmailNormalizationOptions(
            gmailRemoveSubaddress: true,
            icloudRemoveSubaddress: true,
            outlookdotcomRemoveSubaddress: true,
            yahooRemoveSubaddress: true, // Note Yahoo uses "-"
          )
        ],
        'expect': {
          'foo+bar@unknown.com': 'foo+bar@unknown.com',
          'foo+bar@gmail.com': 'foo@gmail.com', // gmail_remove_subaddress
          'foo+bar@me.com': 'foo@me.com', // icloud_remove_subaddress
          'foo+bar@icloud.com': 'foo@icloud.com', // icloud_remove_subaddress
          'foo+bar@live.fr': 'foo@live.fr', // outlookdotcom_remove_subaddress
          'foo+bar@hotmail.co.uk':
              'foo@hotmail.co.uk', // outlookdotcom_remove_subaddress
          'foo-bar@yahoo.com': 'foo@yahoo.com', // yahoo_remove_subaddress
          'foo+bar@yahoo.com': 'foo+bar@yahoo.com', // yahoo_remove_subaddress
        },
      });

      // Testing gmail_convert_googlemaildotcom
      validatorTest({
        'sanitizer': 'normalizeEmail',
        'args': [
          EmailNormalizationOptions(
            gmailConvertGooglemaildotcom: false,
          )
        ],
        'expect': {
          'SOME.name@GMAIL.com': 'somename@gmail.com',
          'SOME.name+me@GMAIL.com': 'somename@gmail.com',
          'SOME.name+me@googlemail.com': 'somename@googlemail.com',
          'SOME.name+me@googlemail.COM': 'somename@googlemail.com',
          'SOME.name+me@googlEmail.com': 'somename@googlemail.com',
          'my.self@foo.com': 'my.self@foo.com',
        },
      });

      validatorTest({
        'sanitizer': 'normalizeEmail',
        'args': [
          EmailNormalizationOptions(
            gmailConvertGooglemaildotcom: true,
          )
        ],
        'expect': {
          'SOME.name@GMAIL.com': 'somename@gmail.com',
          'SOME.name+me@GMAIL.com': 'somename@gmail.com',
          'SOME.name+me@googlemail.com': 'somename@gmail.com',
          'SOME.name+me@googlemail.COM': 'somename@gmail.com',
          'SOME.name+me@googlEmail.com': 'somename@gmail.com',
          'my.self@foo.com': 'my.self@foo.com',
        },
      });
    });
  });
}
