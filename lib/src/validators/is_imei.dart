class IMEIOptions {
  final bool allowHyphens;

  IMEIOptions({
    this.allowHyphens = false,
  });
}

final RegExp imeiRegexWithoutHypens = RegExp(r'^[0-9]{15}$');
final RegExp imeiRegexWithHypens = RegExp(r'^\d{2}-\d{6}-\d{6}-\d{1}$');

/// Returns true if [str] is an IMEI.
bool $isIMEI(String str, {IMEIOptions? options}) {
  options ??= IMEIOptions();

  // default regex for checking imei is the one without hyphens
  RegExp imeiRegex = imeiRegexWithoutHypens;

  if (options.allowHyphens) {
    imeiRegex = imeiRegexWithHypens;
  }

  if (!imeiRegex.hasMatch(str)) {
    return false;
  }

  str = str.replaceAll('-', '');

  int sum = 0, mul = 2, l = 14;

  for (int i = 0; i < l; i++) {
    final digit = str.substring(l - i - 1, l - i);
    final tp = int.parse(digit) * mul;
    if (tp >= 10) {
      sum += (tp % 10) + 1;
    } else {
      sum += tp;
    }
    if (mul == 1) {
      mul += 1;
    } else {
      mul -= 1;
    }
  }
  final chk = ((10 - (sum % 10)) % 10);
  if (chk != int.parse(str.substring(14, 15))) {
    return false;
  }
  return true;
}
