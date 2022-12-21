import 'package:validator_dart/src/util/assert_string.dart';

int? $toInt(dynamic str, {int? radix = 10}) {
  assertString(str);

  var intNum = int.tryParse((str as String).trim(), radix: radix);

  if (intNum == null) {
    var doubleNum = double.tryParse((str).trim());

    if (doubleNum != null) {
      intNum = doubleNum.toInt();

      intNum = int.tryParse(intNum.toString(), radix: radix);
    }
  }

  return intNum;
}
