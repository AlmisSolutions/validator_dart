extension StringOptionalExtensions on String? {
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;
}

extension StringExtensions on String {
  /// Returns a new string that is a substring of this string.
  /// The substring begins at the specified `start` index and extends
  /// to the character at index `end - 1`.
  ///
  /// If `start` is negative, it is treated as `length + start` where `length`
  /// is the length of the string.
  ///
  /// If `end` is negative, it is treated as `length + end` where `length`
  /// is the length of the string.
  ///
  /// If `end` is omitted, the slice includes all characters from `start` to the end of the string.
  String slice([int? start, int? end]) {
    start ??= 0;
    end ??= length;
    if (start < 0) {
      start = length + start;
    }
    if (end < 0) {
      end = length + end;
    }
    return substring(start, end);
  }
}
