import 'package:validator_dart/src/validators/to_date.dart';

bool $isAfter(String str, String? date) {
  final comparison = $toDate(date ?? DateTime.now().toString());
  final original = $toDate(str);
  return original != null && comparison != null && original.isAfter(comparison);
}
