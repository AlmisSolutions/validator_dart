import 'package:validator_dart/src/validators/to_float.dart';

bool $isDivisibleBy(String str, dynamic num) {
  return $toFloat(str) % (num is int ? num : int.parse(num, radix: 10)) == 0;
}
