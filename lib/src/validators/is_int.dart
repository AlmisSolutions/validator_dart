class IntOptions {
  final bool allowLeadingZeroes;
  final int? min;
  final int? max;
  final int? lt;
  final int? gt;

  IntOptions({
    this.allowLeadingZeroes = true,
    this.min,
    this.max,
    this.lt,
    this.gt,
  });
}

final intWithoutLeadingZeroes = RegExp(r'^(?:[-+]?(?:0|[1-9][0-9]*))$');
final intLeadingZeroes = RegExp(r'^[-+]?[0-9]+$');

bool $isInt(String str, {IntOptions? options}) {
  options ??= IntOptions();

  RegExp regex =
      !options.allowLeadingZeroes ? intWithoutLeadingZeroes : intLeadingZeroes;

  var val = int.tryParse(str);

  if (val == null) {
    return false;
  }

  bool minCheckPassed = options.min == null || val >= options.min!;
  bool maxCheckPassed = options.max == null || val <= options.max!;
  bool ltCheckPassed = options.lt == null || val < options.lt!;
  bool gtCheckPassed = options.gt == null || val > options.gt!;

  return regex.hasMatch(str) &&
      minCheckPassed &&
      maxCheckPassed &&
      ltCheckPassed &&
      gtCheckPassed;
}
