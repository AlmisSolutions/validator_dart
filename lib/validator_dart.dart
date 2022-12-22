/// Support for doing something awesome.
///
/// More dartdocs go here.
library validator_dart;

import 'package:validator_dart/src/validators/blacklist.dart';
import 'package:validator_dart/src/validators/escape.dart';
import 'package:validator_dart/src/validators/is_alpha.dart';
import 'package:validator_dart/src/validators/is_byte_length.dart';
import 'package:validator_dart/src/validators/is_email.dart';
import 'package:validator_dart/src/validators/is_fqdn.dart';
import 'package:validator_dart/src/validators/is_ip.dart';
import 'package:validator_dart/src/validators/is_ip_range.dart';
import 'package:validator_dart/src/validators/is_mac_address.dart';
import 'package:validator_dart/src/validators/is_strong_password.dart';
import 'package:validator_dart/src/validators/is_uppercase.dart';
import 'package:validator_dart/src/validators/is_url.dart';
import 'package:validator_dart/src/validators/ltrim.dart';
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
  static bool isByteLength(String str, {ByteLengthOptions? options}) =>
      $isByteLength(str, options: options);
  static bool isUppercase(dynamic str) => $isUppercase(str);
}
