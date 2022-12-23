class ByteLengthOptions {
  final int min;
  final int? max;

  ByteLengthOptions({
    this.min = 0,
    this.max,
  });
}

bool $isByteLength(String str, {ByteLengthOptions? options}) {
  options ??= ByteLengthOptions();

  final encoded = Uri.encodeComponent(str);

  final len = encoded.split(RegExp(r'%..|.')).length - 1;
  return len >= options.min && (options.max == null || len <= options.max!);
}
