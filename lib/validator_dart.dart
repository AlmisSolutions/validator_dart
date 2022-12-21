/// Support for doing something awesome.
///
/// More dartdocs go here.
library validator_dart;

import 'package:validator_dart/src/validators/ltrim.dart';
import 'package:validator_dart/src/validators/rtrim.dart';
import 'package:validator_dart/src/validators/to_boolean.dart';
import 'package:validator_dart/src/validators/trim.dart';

class Validator {
  Validator._();

  static bool toBoolean({dynamic str, bool? strict}) =>
      $toBoolean(str: str, strict: strict);
  static String ltrim({dynamic str, String? chars}) =>
      $ltrim(str: str, chars: chars);
  static String rtrim({dynamic str, String? chars}) =>
      $rtrim(str: str, chars: chars);
  static String trim({dynamic str, String? chars}) =>
      $trim(str: str, chars: chars);
}
