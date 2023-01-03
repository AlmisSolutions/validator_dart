import 'package:validator_dart/src/validators/is_iso_31661_alpha2.dart';

final isBICReg = RegExp(r'^[A-Za-z]{6}[A-Za-z0-9]{2}([A-Za-z0-9]{3})?$');

bool $isBIC(String str) {
  if (!validISO31661Alpha2CountriesCodes
      .contains(str.substring(4, 6).toUpperCase())) {
    return false;
  }

  return isBICReg.hasMatch(str);
}
