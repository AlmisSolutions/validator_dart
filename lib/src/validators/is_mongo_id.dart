import 'package:validator_dart/src/validators/is_hexadecimal.dart';

bool $isMongoId(String str) {
  return $isHexadecimal(str) && str.length == 24;
}
