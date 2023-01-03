class ISSNOptions {
  final bool requireHyphen;
  final bool caseSensitive;

  const ISSNOptions({
    this.requireHyphen = false,
    this.caseSensitive = false,
  });
}

final issn = r'^\d{4}-?\d{3}[\dX]$';

bool $isISSN(String str, {ISSNOptions? options}) {
  options ??= ISSNOptions();

  var testIssn =
      options.requireHyphen ? RegExp(issn.replaceAll('?', '')) : RegExp(issn);
  testIssn = RegExp(testIssn.pattern, caseSensitive: options.caseSensitive);
  if (!testIssn.hasMatch(str)) {
    return false;
  }
  final digits = str.replaceAll('-', '').toUpperCase();
  var checksum = 0;
  for (var i = 0; i < digits.length; i++) {
    final digit = digits[i];
    checksum += (digit == 'X' ? 10 : int.parse(digit)) * (8 - i);
  }
  return checksum % 11 == 0;
}
