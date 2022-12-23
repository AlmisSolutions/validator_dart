import 'package:validator_dart/src/validators/is_int.dart';

bool $isPort(str) {
  return $isInt(str, options: IntOptions(min: 0, max: 65535));
}
