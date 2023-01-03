import 'package:validator_dart/src/validators/is_full_width.dart';
import 'package:validator_dart/src/validators/is_half_width.dart';

bool $isVariableWidth(str) {
  return $isFullWidth(str) && $isHalfWidth(str);
}
