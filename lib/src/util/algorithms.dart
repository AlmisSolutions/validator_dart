class Algorithms {
  /*
  * ISO 7064 validation function
  * Called with a string of numbers (incl. check digit)
  * to validate according to ISO 7064 (MOD 11, 10).
  */
  static bool iso7064Check(str) {
    var checkvalue = 10;
    for (var i = 0; i < str.length - 1; i++) {
      checkvalue = (int.parse(str[i], radix: 10) + checkvalue) % 10 == 0
          ? (10 * 2) % 11
          : (((int.parse(str[i], radix: 10) + checkvalue) % 10) * 2) % 11;
    }
    checkvalue = checkvalue == 1 ? 0 : 11 - checkvalue;
    return checkvalue == int.parse(str[10], radix: 10);
  }

  /*
  * Luhn (mod 10) validation function
  * Called with a string of numbers (incl. check digit)
  * to validate according to the Luhn algorithm.
  */
  static bool luhnCheck(str) {
    var checksum = 0;
    var second = false;
    for (var i = str.length - 1; i >= 0; i--) {
      if (second) {
        final product = int.parse(str[i], radix: 10) * 2;
        if (product > 9) {
          // sum digits of product and add to checksum
          checksum += product
              .toString()
              .split('')
              .map((a) => int.parse(a, radix: 10))
              .reduce((a, b) => a + b);
        } else {
          checksum += product;
        }
      } else {
        checksum += int.parse(str[i], radix: 10);
      }
      second = !second;
    }
    return checksum % 10 == 0;
  }

  /*
  * Reverse TIN multiplication and summation helper function
  * Called with an array of single-digit integers and a base multiplier
  * to calculate the sum of the digits multiplied in reverse.
  * Normally used in variations of MOD 11 algorithmic checks.
  */
  static int reverseMultiplyAndSum(List<int> digits, int base) {
    var total = 0;
    for (var i = 0; i < digits.length; i++) {
      total += digits[i] * (base - i);
    }
    return total;
  }

  /*
  * Verhoeff validation helper function
  * Called with a string of numbers
  * to validate according to the Verhoeff algorithm.
  */
  static bool verhoeffCheck(String str) {
    final dTable = [
      [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
      [1, 2, 3, 4, 0, 6, 7, 8, 9, 5],
      [2, 3, 4, 0, 1, 7, 8, 9, 5, 6],
      [3, 4, 0, 1, 2, 8, 9, 5, 6, 7],
      [4, 0, 1, 2, 3, 9, 5, 6, 7, 8],
      [5, 9, 8, 7, 6, 0, 4, 3, 2, 1],
      [6, 5, 9, 8, 7, 1, 0, 4, 3, 2],
      [7, 6, 5, 9, 8, 2, 1, 0, 4, 3],
      [8, 7, 6, 5, 9, 3, 2, 1, 0, 4],
      [9, 8, 7, 6, 5, 4, 3, 2, 1, 0],
    ];

    final pTable = [
      [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
      [1, 5, 7, 6, 2, 8, 3, 0, 9, 4],
      [5, 8, 0, 3, 7, 9, 6, 1, 4, 2],
      [8, 9, 1, 6, 0, 4, 3, 5, 2, 7],
      [9, 4, 5, 3, 1, 2, 6, 8, 7, 0],
      [4, 2, 8, 6, 5, 7, 3, 9, 0, 1],
      [2, 7, 9, 3, 8, 0, 6, 4, 1, 5],
      [7, 0, 4, 6, 9, 1, 3, 2, 5, 8],
    ];

    // Copy (to prevent replacement) and reverse
    final strCopy = str.split('').reversed.join();
    int checksum = 0;
    for (int i = 0; i < strCopy.length; i++) {
      checksum = dTable[checksum][pTable[i % 8][int.parse(strCopy[i])]];
    }
    return checksum == 0;
  }
}
