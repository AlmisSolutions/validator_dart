final isin = RegExp(r'^[A-Z]{2}[0-9A-Z]{9}[0-9]$');

// this link details how the check digit is calculated:
// https://www.isin.org/isin-format/. it is a little bit
// odd in that it works with digits, not numbers. in order
// to make only one pass through the ISIN characters, the
// each alpha character is handled as 2 characters within
// the loop.
bool $isISIN(String str) {
  if (!isin.hasMatch(str)) {
    return false;
  }

  bool double = true;
  int sum = 0;
  // convert values
  for (int i = str.length - 2; i >= 0; i--) {
    if (str.codeUnitAt(i) >= 65 && str.codeUnitAt(i) <= 90) {
      final value = str[i].codeUnitAt(0) - 55;
      final lo = value % 10;
      final hi = (value / 10).truncate();
      // letters have two digits, so handle the low order
      // and high order digits separately.
      for (final digit in [lo, hi]) {
        if (double) {
          if (digit >= 5) {
            sum += 1 + ((digit - 5) * 2);
          } else {
            sum += digit * 2;
          }
        } else {
          sum += digit;
        }
        double = !double;
      }
    } else {
      final digit = str.codeUnitAt(i) - 48;
      if (double) {
        if (digit >= 5) {
          sum += 1 + ((digit - 5) * 2);
        } else {
          sum += digit * 2;
        }
      } else {
        sum += digit;
      }
      double = !double;
    }
  }

  final check = (((sum + 9) / 10).truncate() * 10) - sum;

  return int.parse(str[str.length - 1]) == check;
}
