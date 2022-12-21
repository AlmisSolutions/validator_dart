import 'package:validator_dart/src/validators/ltrim.dart';
import 'package:validator_dart/src/validators/rtrim.dart';

String $trim({dynamic str, String? chars}) {
  return $rtrim(str: $ltrim(str: str, chars: chars), chars: chars);
}
