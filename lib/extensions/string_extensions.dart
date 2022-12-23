extension StringExtensions on String? {
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;
}
