DateTime? $toDate(String? date) {
  return date == null ? null : DateTime.tryParse(date);
}
