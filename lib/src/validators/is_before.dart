import 'package:validator_dart/src/validators/to_date.dart';

bool $isBefore(String str, String? date) {
  final comparison = $toDate(date ?? DateTime.now().toString());
  final original = $toDate(str);
  return original != null &&
      comparison != null &&
      original.isBefore(comparison);
}
