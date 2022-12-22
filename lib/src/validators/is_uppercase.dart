import 'package:validator_dart/src/util/assert_string.dart';

bool $isUppercase(dynamic str) {
  assertString(str);
  return str == str.toUpperCase();
}
