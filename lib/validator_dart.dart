/// Support for doing something awesome.
///
/// More dartdocs go here.
library validator_dart;

import 'package:validator_dart/src/validators/blacklist.dart';
import 'package:validator_dart/src/validators/contains.dart';
import 'package:validator_dart/src/validators/equals.dart';
import 'package:validator_dart/src/validators/escape.dart';
import 'package:validator_dart/src/validators/is_after.dart';
import 'package:validator_dart/src/validators/is_alpha.dart';
import 'package:validator_dart/src/validators/is_alphanumeric.dart';
import 'package:validator_dart/src/validators/is_ascii.dart';
import 'package:validator_dart/src/validators/is_base64.dart';
import 'package:validator_dart/src/validators/is_before.dart';
import 'package:validator_dart/src/validators/is_bic.dart';
import 'package:validator_dart/src/validators/is_byte_length.dart';
import 'package:validator_dart/src/validators/is_credit_card.dart';
import 'package:validator_dart/src/validators/is_decimal.dart';
import 'package:validator_dart/src/validators/is_divisible_by.dart';
import 'package:validator_dart/src/validators/is_email.dart';
import 'package:validator_dart/src/validators/is_empty.dart';
import 'package:validator_dart/src/validators/is_float.dart';
import 'package:validator_dart/src/validators/is_fqdn.dart';
import 'package:validator_dart/src/validators/is_full_width.dart';
import 'package:validator_dart/src/validators/is_hash.dart';
import 'package:validator_dart/src/validators/is_hex_color.dart';
import 'package:validator_dart/src/validators/is_hexadecimal.dart';
import 'package:validator_dart/src/validators/is_hsl.dart';
import 'package:validator_dart/src/validators/is_iban.dart';
import 'package:validator_dart/src/validators/is_identity_card.dart';
import 'package:validator_dart/src/validators/is_imei.dart';
import 'package:validator_dart/src/validators/is_in.dart';
import 'package:validator_dart/src/validators/is_int.dart';
import 'package:validator_dart/src/validators/is_ip.dart';
import 'package:validator_dart/src/validators/is_ip_range.dart';
import 'package:validator_dart/src/validators/is_isin.dart';
import 'package:validator_dart/src/validators/is_iso_31661_alpha2.dart';
import 'package:validator_dart/src/validators/is_isrc.dart';
import 'package:validator_dart/src/validators/is_jwt.dart';
import 'package:validator_dart/src/validators/is_length.dart';
import 'package:validator_dart/src/validators/is_locale.dart';
import 'package:validator_dart/src/validators/is_lowercase.dart';
import 'package:validator_dart/src/validators/is_luhn_valid.dart';
import 'package:validator_dart/src/validators/is_mac_address.dart';
import 'package:validator_dart/src/validators/is_md5.dart';
import 'package:validator_dart/src/validators/is_mongo_id.dart';
import 'package:validator_dart/src/validators/is_multibyte.dart';
import 'package:validator_dart/src/validators/is_numeric.dart';
import 'package:validator_dart/src/validators/is_octal.dart';
import 'package:validator_dart/src/validators/is_passport_number.dart';
import 'package:validator_dart/src/validators/is_port.dart';
import 'package:validator_dart/src/validators/is_rgb_color.dart';
import 'package:validator_dart/src/validators/is_strong_password.dart';
import 'package:validator_dart/src/validators/is_uppercase.dart';
import 'package:validator_dart/src/validators/is_url.dart';
import 'package:validator_dart/src/validators/is_uuid.dart';
import 'package:validator_dart/src/validators/ltrim.dart';
import 'package:validator_dart/src/validators/matches.dart';
import 'package:validator_dart/src/validators/normalize_email.dart';
import 'package:validator_dart/src/validators/rtrim.dart';
import 'package:validator_dart/src/validators/strip_low.dart';
import 'package:validator_dart/src/validators/to_boolean.dart';
import 'package:validator_dart/src/validators/to_float.dart';
import 'package:validator_dart/src/validators/to_int.dart';
import 'package:validator_dart/src/validators/trim.dart';
import 'package:validator_dart/src/validators/unescape.dart';
import 'package:validator_dart/src/validators/whitelist.dart';

class Validator {
  Validator._();

  static bool toBoolean(dynamic str, bool? strict) => $toBoolean(str, strict);
  static String ltrim(dynamic str, String? chars) => $ltrim(str, chars);
  static String rtrim(dynamic str, String? chars) => $rtrim(str, chars);
  static String trim(dynamic str, String? chars) => $trim(str, chars);
  static int? toInt(dynamic str, {int? radix = 10}) =>
      $toInt(str, radix: radix);
  static double toFloat(dynamic str) => $toFloat(str);
  static String escape(dynamic str) => $escape(str);
  static String unescape(dynamic str) => $unescape(str);
  static String stripLow(dynamic str, {bool? keepNewLines = false}) =>
      $stripLow(str, keepNewLines: keepNewLines);
  static String whitelist(dynamic str, String chars) => $whitelist(str, chars);
  static String blacklist(dynamic str, String chars) => $blacklist(str, chars);
  static dynamic isStrongPassword(dynamic str, {PasswordOptions? options}) =>
      $isStrongPassword(str, options: options);
  static dynamic normalizeEmail(String email,
          {EmailNormalizationOptions? options}) =>
      $normalizeEmail(email, options: options);
  static bool isEmail(String str, {EmailOptions? options}) =>
      $isEmail(str, options: options);
  static bool isURL(String str, {UrlOptions? options}) =>
      $isURL(str, options: options);
  static bool isMACAddress(String str, {MACAddressOptions? options}) =>
      $isMACAddress(str, options: options);
  static bool isIP(String str, {int? version}) => $isIP(str, version: version);
  static bool isIPRange(String str, {int? version}) =>
      $isIPRange(str, version: version);
  static bool isFQDN(String str, {FqdnOptions? options}) =>
      $isFQDN(str, options: options);
  static bool isAlpha(String str,
          {String? locale = 'en-US', AlphaOptions? options}) =>
      $isAlpha(str, locale: locale ?? 'en-US', options: options);
  static bool isAlphanumeric(String str,
          {String? locale = 'en-US', AlphanumericOptions? options}) =>
      $isAlphanumeric(str, locale: locale ?? 'en-US', options: options);
  static bool isNumeric(String str, {NumericOptions? options}) =>
      $isNumeric(str, options: options);
  static bool isPort(String str) => $isPort(str);
  static bool isPassportNumber(String str, String countryCode) =>
      $isPassportNumber(str, countryCode);
  static bool isDecimal(String str, {DecimalOptions? options}) =>
      $isDecimal(str, options: options);
  static bool isLowercase(String str) => $isLowercase(str);
  static bool isIMEI(String str, {IMEIOptions? options}) =>
      $isIMEI(str, options: options);
  static bool isUppercase(dynamic str) => $isUppercase(str);
  static bool isInt(String str, {IntOptions? options}) =>
      $isInt(str, options: options);
  static bool isFloat(String str, {FloatOptions? options}) =>
      $isFloat(str, options: options);
  static bool isHexadecimal(String str) => $isHexadecimal(str);
  static bool isOctal(String str) => $isOctal(str);
  static bool isHexColor(String str) => $isHexColor(str);
  static bool isHSL(String str) => $isHSL(str);
  static bool isRgbColor(String str, {bool includePercentValues = true}) =>
      $isRgbColor(str, includePercentValues: includePercentValues);
  static bool isISRC(String str) => $isISRC(str);
  static bool isMD5(String str) => $isMD5(str);
  static bool isHash(String str, String algorithm) => $isHash(str, algorithm);
  static bool isJWT(String str) => $isJWT(str);
  static bool isMongoId(String str) => $isMongoId(str);
  static bool isEmpty(String str, {EmptyOptions? options}) =>
      $isEmpty(str, options: options);
  static bool equals(String str, String comparison) => $equals(str, comparison);
  static bool contains(String str, String elem, {ContainsOptions? options}) =>
      $contains(str, elem, options: options);
  static bool matches(String str, RegExp pattern) => $matches(str, pattern);
  static bool isLength(String str, {LengthOptions? options}) =>
      $isLength(str, options: options);
  static bool isLocale(String str) => $isLocale(str);
  static bool isByteLength(String str, {ByteLengthOptions? options}) =>
      $isByteLength(str, options: options);
  static bool isUUID(String str, {int? version}) =>
      $isUUID(str, version: version);
  static bool isIn(String str, dynamic options) => $isIn(str, options);
  static bool isAfter(String str, String? date) => $isAfter(str, date);
  static bool isBefore(String str, String? date) => $isBefore(str, date);
  static bool isIBAN(String str) => $isIBAN(str);
  static bool isBIC(String str) => $isBIC(str);
  static bool isDivisibleBy(String str, dynamic num) =>
      $isDivisibleBy(str, num);
  static bool isLuhnValid(String str) => $isLuhnValid(str);
  static bool isCreditCard(String str, {CreditCardOptions? options}) =>
      $isCreditCard(str, options: options);
  static bool isIdentityCard(String str, String locale) =>
      $isIdentityCard(str, locale);
  static bool isISIN(String str) => $isISIN(str);
  static bool isMultibyte(String str) => $isMultibyte(str);
  static bool isAscii(String str) => $isAscii(str);
  static bool isFullWidth(String str) => $isFullWidth(str);
  static bool isISO31661Alpha2(String str) => $isISO31661Alpha2(str);
  static bool isBase64(String str, {Base64Options? options}) =>
      $isBase64(str, options: options);
}
