bool $isLuhnValid(String str) {
  final sanitized = str.replaceAll(RegExp(r'[- ]+'), '');
  double sum = 0;
  int? digit;
  double tmpNum;
  bool shouldDouble = false;
  for (int i = sanitized.length - 1; i >= 0; i--) {
    digit = int.tryParse(sanitized.substring(i, (i + 1)), radix: 10);
    tmpNum = digit == null ? double.nan : digit.toDouble();
    if (shouldDouble) {
      tmpNum *= 2;
      if (tmpNum >= 10) {
        sum += ((tmpNum % 10) + 1);
      } else {
        sum += tmpNum;
      }
    } else {
      sum += tmpNum;
    }
    shouldDouble = !shouldDouble;
  }
  return (sum % 10) == 0 ? sanitized.isNotEmpty : false;
}
