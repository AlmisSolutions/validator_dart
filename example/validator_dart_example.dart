import 'package:validator_dart/validator_dart.dart';

void main() {
  var isEmail = Validator.isEmail('test@gmail.com');
  print(isEmail); // true

  var isPostalCode = Validator.isPostalCode('99950', 'US');
  print(isPostalCode); // true
}
