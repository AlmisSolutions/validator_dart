class LengthOptions {
  final int min;
  final int? max;

  LengthOptions({
    this.min = 0,
    this.max,
  });
}

bool $isLength(String str, {LengthOptions? options}) {
  options ??= LengthOptions();

  final min = options.min;
  final max = options.max;

  final presentationSequences = RegExp(r'(\uFE0F|\uFE0E)').allMatches(str);
  final surrogatePairs =
      RegExp(r'[\uD800-\uDBFF][\uDC00-\uDFFF]').allMatches(str);
  final len = str.length - presentationSequences.length - surrogatePairs.length;

  return len >= min && (max == null || len <= max);
}
