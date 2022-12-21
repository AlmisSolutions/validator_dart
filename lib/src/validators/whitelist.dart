import 'package:validator_dart/src/util/assert_string.dart';

String $whitelist(String str, String chars) {
  assertString(str);
  return str.replaceAll(RegExp('[^$chars]+', multiLine: true), '');
}
