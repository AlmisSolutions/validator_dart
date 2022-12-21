import 'package:validator_dart/src/util/assert_string.dart';

bool $toBoolean({dynamic str, bool? strict}) {
  assertString(str);
  if (strict ?? false) {
    return str == '1' || RegExp(r'^true$', caseSensitive: false).hasMatch(str);
  }
  return str != '0' &&
      !RegExp(r'^false$', caseSensitive: false).hasMatch(str) &&
      str != '';
}
