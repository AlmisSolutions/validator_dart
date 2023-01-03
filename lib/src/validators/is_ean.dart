/*
 * The most commonly used EAN standard is
 * the thirteen-digit EAN-13, while the
 * less commonly used 8-digit EAN-8 barcode was
 * introduced for use on small packages.
 * Also EAN/UCC-14 is used for Grouping of individual
 * trade items above unit level(Intermediate, Carton or Pallet).
 * For more info about EAN-14 checkout: https://www.gtin.info/itf-14-barcodes/
 * EAN consists of:
 * GS1 prefix, manufacturer code, product code and check digit
 * Reference: https://en.wikipedia.org/wiki/International_Article_Number
 * Reference: https://www.gtin.info/
 */

/*
 * Define EAN Lenghts; 8 for EAN-8; 13 for EAN-13; 14 for EAN-14
 * and Regular Expression for valid EANs (EAN-8, EAN-13, EAN-14),
 * with exact numberic matching of 8 or 13 or 14 digits [0-9]
 */
const lengthEan8 = 8;
const lengthEan14 = 14;
final validEanRegex = RegExp(r'^(\d{8}|\d{13}|\d{14})$');

/*
 * Get position weight given:
 * EAN length and digit index/position
 *
 * @param {number} length
 * @param {number} index
 * @return {number}
 */
int getPositionWeightThroughLengthAndIndex(length, index) {
  if (length == lengthEan8 || length == lengthEan14) {
    return (index % 2 == 0) ? 3 : 1;
  }

  return (index % 2 == 0) ? 1 : 3;
}

/*
 * Calculate EAN Check Digit
 * Reference: https://en.wikipedia.org/wiki/International_Article_Number#Calculation_of_checksum_digit
 *
 * @param {string} ean
 * @return {number}
 */
int calculateCheckDigit(String ean) {
  final eanList = ean.substring(0, ean.length - 1).split('');
  final checksum = eanList
      .asMap()
      .entries
      .map((e) =>
          int.parse(e.value) *
          getPositionWeightThroughLengthAndIndex(ean.length, e.key))
      .reduce((acc, partialSum) => acc + partialSum);
  final remainder = 10 - (checksum % 10);
  return remainder < 10 ? remainder : 0;
}

/*
 * Check if string is valid EAN:
 * Matches EAN-8/EAN-13/EAN-14 regex
 * Has valid check digit.
 *
 * @param {string} str
 * @return {boolean}
 */
bool $isEAN(String str) {
  final actualCheckDigit = int.parse(str.substring(str.length - 1));

  return validEanRegex.hasMatch(str) &&
      actualCheckDigit == calculateCheckDigit(str);
}
