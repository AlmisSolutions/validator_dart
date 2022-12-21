import 'package:validator_dart/src/util/assert_string.dart';

String $ltrim(dynamic str, String? chars) {
  assertString(str);

  RegExp pattern;
  if (chars != null) {
    pattern = RegExp(
        '^[${chars.replaceAllMapped(RegExp(r'[.*+?^${}()|[\]\\]'), (match) => '\\${match.group(0)}')}]+');
  } else {
    pattern = RegExp(r'^\s+');
  }

  return str.replaceFirst(pattern, '');
}
