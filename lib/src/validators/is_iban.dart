/*
 * List of country codes with
 * corresponding IBAN regular expression
 * Reference: https://en.wikipedia.org/wiki/International_Bank_Account_Number
 */
final ibanRegexThroughCountryCode = {
  'AD': RegExp(r'^(AD[0-9]{2})\d{8}[A-Z0-9]{12}$'),
  'AE': RegExp(r'^(AE[0-9]{2})\d{3}\d{16}$'),
  'AL': RegExp(r'^(AL[0-9]{2})\d{8}[A-Z0-9]{16}$'),
  'AT': RegExp(r'^(AT[0-9]{2})\d{16}$'),
  'AZ': RegExp(r'^(AZ[0-9]{2})[A-Z0-9]{4}\d{20}$'),
  'BA': RegExp(r'^(BA[0-9]{2})\d{16}$'),
  'BE': RegExp(r'^(BE[0-9]{2})\d{12}$'),
  'BG': RegExp(r'^(BG[0-9]{2})[A-Z]{4}\d{6}[A-Z0-9]{8}$'),
  'BH': RegExp(r'^(BH[0-9]{2})[A-Z]{4}[A-Z0-9]{14}$'),
  'BR': RegExp(r'^(BR[0-9]{2})\d{23}[A-Z]{1}[A-Z0-9]{1}$'),
  'BY': RegExp(r'^(BY[0-9]{2})[A-Z0-9]{4}\d{20}$'),
  'CH': RegExp(r'^(CH[0-9]{2})\d{5}[A-Z0-9]{12}$'),
  'CR': RegExp(r'^(CR[0-9]{2})\d{18}$'),
  'CY': RegExp(r'^(CY[0-9]{2})\d{8}[A-Z0-9]{16}$'),
  'CZ': RegExp(r'^(CZ[0-9]{2})\d{20}$'),
  'DE': RegExp(r'^(DE[0-9]{2})\d{18}$'),
  'DK': RegExp(r'^(DK[0-9]{2})\d{14}$'),
  'DO': RegExp(r'^(DO[0-9]{2})[A-Z]{4}\d{20}$'),
  'EE': RegExp(r'^(EE[0-9]{2})\d{16}$'),
  'EG': RegExp(r'^(EG[0-9]{2})\d{25}$'),
  'ES': RegExp(r'^(ES[0-9]{2})\d{20}$'),
  'FI': RegExp(r'^(FI[0-9]{2})\d{14}$'),
  'FO': RegExp(r'^(FO[0-9]{2})\d{14}$'),
  'FR': RegExp(r'^(FR[0-9]{2})\d{10}[A-Z0-9]{11}\d{2}$'),
  'GB': RegExp(r'^(GB[0-9]{2})[A-Z]{4}\d{14}$'),
  'GE': RegExp(r'^(GE[0-9]{2})[A-Z0-9]{2}\d{16}$'),
  'GI': RegExp(r'^(GI[0-9]{2})[A-Z]{4}[A-Z0-9]{15}$'),
  'GL': RegExp(r'^(GL[0-9]{2})\d{14}$'),
  'GR': RegExp(r'^(GR[0-9]{2})\d{7}[A-Z0-9]{16}$'),
  'GT': RegExp(r'^(GT[0-9]{2})[A-Z0-9]{4}[A-Z0-9]{20}$'),
  'HR': RegExp(r'^(HR[0-9]{2})\d{17}$'),
  'HU': RegExp(r'^(HU[0-9]{2})\d{24}$'),
  'IE': RegExp(r'^(IE[0-9]{2})[A-Z0-9]{4}\d{14}$'),
  'IL': RegExp(r'^(IL[0-9]{2})\d{19}$'),
  'IQ': RegExp(r'^(IQ[0-9]{2})[A-Z]{4}\d{15}$'),
  'IR': RegExp(r'^(IR[0-9]{2})0\d{2}0\d{18}$'),
  'IS': RegExp(r'^(IS[0-9]{2})\d{22}$'),
  'IT': RegExp(r'^(IT[0-9]{2})[A-Z]{1}\d{10}[A-Z0-9]{12}$'),
  'JO': RegExp(r'^(JO[0-9]{2})[A-Z]{4}\d{22}$'),
  'KW': RegExp(r'^(KW[0-9]{2})[A-Z]{4}[A-Z0-9]{22}$'),
  'KZ': RegExp(r'^(KZ[0-9]{2})\d{3}[A-Z0-9]{13}$'),
  'LB': RegExp(r'^(LB[0-9]{2})\d{4}[A-Z0-9]{20}$'),
  'LC': RegExp(r'^(LC[0-9]{2})[A-Z]{4}[A-Z0-9]{24}$'),
  'LI': RegExp(r'^(LI[0-9]{2})\d{5}[A-Z0-9]{12}$'),
  'LT': RegExp(r'^(LT[0-9]{2})\d{16}$'),
  'LU': RegExp(r'^(LU[0-9]{2})\d{3}[A-Z0-9]{13}$'),
  'LV': RegExp(r'^(LV[0-9]{2})[A-Z]{4}[A-Z0-9]{13}$'),
  'MC': RegExp(r'^(MC[0-9]{2})\d{10}[A-Z0-9]{11}\d{2}$'),
  'MD': RegExp(r'^(MD[0-9]{2})[A-Z0-9]{20}$'),
  'ME': RegExp(r'^(ME[0-9]{2})\d{18}$'),
  'MK': RegExp(r'^(MK[0-9]{2})\d{3}[A-Z0-9]{10}\d{2}$'),
  'MR': RegExp(r'^(MR[0-9]{2})\d{23}$'),
  'MT': RegExp(r'^(MT[0-9]{2})[A-Z]{4}\d{5}[A-Z0-9]{18}$'),
  'MU': RegExp(r'^(MU[0-9]{2})[A-Z]{4}\d{19}[A-Z]{3}$'),
  'MZ': RegExp(r'^(MZ[0-9]{2})\d{21}$'),
  'NL': RegExp(r'^(NL[0-9]{2})[A-Z]{4}\d{10}$'),
  'NO': RegExp(r'^(NO[0-9]{2})\d{11}$'),
  'PK': RegExp(r'^(PK[0-9]{2})[A-Z0-9]{4}\d{16}$'),
  'PL': RegExp(r'^(PL[0-9]{2})\d{24}$'),
  'PS': RegExp(r'^(PS[0-9]{2})[A-Z0-9]{4}\d{21}$'),
  'PT': RegExp(r'^(PT[0-9]{2})\d{21}$'),
  'QA': RegExp(r'^(QA[0-9]{2})[A-Z]{4}[A-Z0-9]{21}$'),
  'RO': RegExp(r'^(RO[0-9]{2})[A-Z]{4}[A-Z0-9]{16}$'),
  'RS': RegExp(r'^(RS[0-9]{2})\d{18}$'),
  'SA': RegExp(r'^(SA[0-9]{2})\d{2}[A-Z0-9]{18}$'),
  'SC': RegExp(r'^(SC[0-9]{2})[A-Z]{4}\d{20}[A-Z]{3}$'),
  'SE': RegExp(r'^(SE[0-9]{2})\d{20}$'),
  'SI': RegExp(r'^(SI[0-9]{2})\d{15}$'),
  'SK': RegExp(r'^(SK[0-9]{2})\d{20}$'),
  'SM': RegExp(r'^(SM[0-9]{2})[A-Z]{1}\d{10}[A-Z0-9]{12}$'),
  'SV': RegExp(r'^(SV[0-9]{2})[A-Z0-9]{4}\d{20}$'),
  'TL': RegExp(r'^(TL[0-9]{2})\d{19}$'),
  'TN': RegExp(r'^(TN[0-9]{2})\d{20}$'),
  'TR': RegExp(r'^(TR[0-9]{2})\d{5}[A-Z0-9]{17}$'),
  'UA': RegExp(r'^(UA[0-9]{2})\d{6}[A-Z0-9]{19}$'),
  'VA': RegExp(r'^(VA[0-9]{2})\d{18}$'),
  'VG': RegExp(r'^(VG[0-9]{2})[A-Z0-9]{4}\d{16}$'),
  'XK': RegExp(r'^(XK[0-9]{2})\d{16}$'),
};

/*
 * Check whether string has correct universal IBAN format
 * The IBAN consists of up to 34 alphanumeric characters, as follows:
 * Country Code using ISO 3166-1 alpha-2, two letters
 * check digits, two digits and
 * Basic Bank Account Number (BBAN), up to 30 alphanumeric characters.
 * NOTE: Permitted IBAN characters are: digits [0-9] and the 26 latin alphabetic [A-Z]
 *
 * @param {string} str - string under validation
 * @return {boolean}
 */
bool hasValidIbanFormat(String str) {
  // Strip white spaces and hyphens
  var strippedStr = str.replaceAll(RegExp(r'[\s\-]+'), '').toUpperCase();
  var isoCountryCode = strippedStr.substring(0, 2).toUpperCase();

  return ibanRegexThroughCountryCode.containsKey(isoCountryCode) &&
      (ibanRegexThroughCountryCode[isoCountryCode]?.hasMatch(strippedStr) ??
          false);
}

/*
* Check whether string has valid IBAN Checksum
* by performing basic mod-97 operation and
* the remainder should equal 1
* -- Start by rearranging the IBAN by moving the four initial characters to the end of the string
* -- Replace each letter in the string with two digits, A -> 10, B = 11, Z = 35
* -- Interpret the string as a decimal integer and
* -- compute the remainder on division by 97 (mod 97)
* Reference: https://en.wikipedia.org/wiki/International_Bank_Account_Number
*
* @param {string} str
* @return {boolean}
*/
bool hasValidIbanChecksum(String str) {
  final strippedStr = str.replaceAll(RegExp(r'[^A-Z0-9]+'), '').toUpperCase();
  final rearranged = strippedStr.substring(4) + strippedStr.substring(0, 4);
  final alphaCapsReplacedWithDigits = rearranged.replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => match.group(0) != null
          ? (match.group(0)!.codeUnitAt(0) - 55).toString()
          : '');

  final remainder =
      RegExp(r'\d{1,7}').allMatches(alphaCapsReplacedWithDigits).fold(
            '',
            (acc, match) =>
                (int.parse(acc + (match.group(0) ?? '')) % 97).toString(),
          );

  return remainder == '1';
}

bool $isIBAN(String str) {
  return hasValidIbanFormat(str) && hasValidIbanChecksum(str);
}
