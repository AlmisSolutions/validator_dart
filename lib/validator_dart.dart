/// Support for doing something awesome.
///
/// More dartdocs go here.
library validator_dart;

import 'package:validator_dart/src/validators/ltrim.dart';
import 'package:validator_dart/src/validators/to_boolean.dart';

class Validator {
  Validator._();

  static bool toBoolean({dynamic str, bool? strict}) =>
      $toBoolean(str: str, strict: strict);
  static String ltrim({dynamic str, String? chars}) =>
      $ltrim(str: str, chars: chars);
}
