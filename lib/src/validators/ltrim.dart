import 'package:validator_dart/src/util/assert_string.dart';

String $ltrim({dynamic str, String? chars}) {
  assertString(str);
  RegExp pattern;
  if (chars != null) {
    pattern = RegExp(
        '^[${chars.replaceAll(RegExp(r'[.*+?^${}()|[\]\\]'), '\\\$1')}]+');
  } else {
    pattern = RegExp(r'^\s+');
  }
  var res = str.replaceFirst(pattern, '');

  return res;
}
