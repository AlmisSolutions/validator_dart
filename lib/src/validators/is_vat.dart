import 'package:validator_dart/src/util/algorithms.dart';

bool pt(String str) {
  var match = RegExp(r'^(PT)?(\d{9})$').firstMatch(str);
  if (match == null) {
    return false;
  }

  String tin = match.group(2)!;

  int checksum = 11 -
      (Algorithms.reverseMultiplyAndSum(
              tin
                  .split('')
                  .sublist(0, 8)
                  .map((a) => int.parse(a, radix: 10))
                  .toList(),
              9) %
          11);
  if (checksum > 9) {
    return int.parse(tin[8], radix: 10) == 0;
  }
  return checksum == int.parse(tin[8], radix: 10);
}

final vatMatchers = {
/*
 * European Union VAT identification numbers
 */
  'AT': (str) => RegExp(r'^(AT)?U\d{8}$').hasMatch(str),
  'BE': (str) => RegExp(r'^(BE)?\d{10}$').hasMatch(str),
  'BG': (str) => RegExp(r'^(BG)?\d{9,10}$').hasMatch(str),
  'HR': (str) => RegExp(r'^(HR)?\d{11}$').hasMatch(str),
  'CY': (str) => RegExp(r'^(CY)?\w{9}$').hasMatch(str),
  'CZ': (str) => RegExp(r'^(CZ)?\d{8,10}$').hasMatch(str),
  'DK': (str) => RegExp(r'^(DK)?\d{8}$').hasMatch(str),
  'EE': (str) => RegExp(r'^(EE)?\d{9}$').hasMatch(str),
  'FI': (str) => RegExp(r'^(FI)?\d{8}$').hasMatch(str),
  'FR': (str) => RegExp(r'^(FR)?\w{2}\d{9}$').hasMatch(str),
  'DE': (str) => RegExp(r'^(DE)?\d{9}$').hasMatch(str),
  'EL': (str) => RegExp(r'^(EL)?\d{9}$').hasMatch(str),
  'HU': (str) => RegExp(r'^(HU)?\d{8}$').hasMatch(str),
  'IE': (str) => RegExp(r'^(IE)?\d{7}\w{1}(W)?$').hasMatch(str),
  'IT': (str) => RegExp(r'^(IT)?\d{11}$').hasMatch(str),
  'LV': (str) => RegExp(r'^(LV)?\d{11}$').hasMatch(str),
  'LT': (str) => RegExp(r'^(LT)?\d{9,12}$').hasMatch(str),
  'LU': (str) => RegExp(r'^(LU)?\d{8}$').hasMatch(str),
  'MT': (str) => RegExp(r'^(MT)?\d{8}$').hasMatch(str),
  'NL': (str) => RegExp(r'^(NL)?\d{9}B\d{2}$').hasMatch(str),
  'PL': (str) => RegExp(
          r'^(PL)?(\d{10}|(\d{3}-\d{3}-\d{2}-\d{2})|(\d{3}-\d{2}-\d{2}-\d{3}))$')
      .hasMatch(str),
  'PT': pt,
  'RO': (str) => RegExp(r'^(RO)?\d{2,10}$').hasMatch(str),
  'SK': (str) => RegExp(r'^(SK)?\d{10}$').hasMatch(str),
  'SI': (str) => RegExp(r'^(SI)?\d{8}$').hasMatch(str),
  'ES': (str) => RegExp(r'^(ES)?\w\d{7}[A-Z]$').hasMatch(str),
  'SE': (str) => RegExp(r'^(SE)?\d{12}$').hasMatch(str),

  /**
   * VAT numbers of non-EU countries
   */
  'AL': (str) => RegExp(r'^(AL)?\w{9}[A-Z]$').hasMatch(str),
  'MK': (str) => RegExp(r'^(MK)?\d{13}$').hasMatch(str),
  'AU': (str) => RegExp(r'^(AU)?\d{11}$').hasMatch(str),
  'BY': (str) => RegExp(r'^(УНП )?\d{9}$').hasMatch(str),
  'CA': (str) => RegExp(r'^(CA)?\d{9}$').hasMatch(str),
  'IS': (str) => RegExp(r'^(IS)?\d{5,6}$').hasMatch(str),
  'IN': (str) => RegExp(r'^(IN)?\d{15}$').hasMatch(str),
  'ID': (str) =>
      RegExp(r'^(ID)?(\d{15}|(\d{2}.\d{3}.\d{3}.\d{1}-\d{3}.\d{3}))$')
          .hasMatch(str),
  'IL': (str) => RegExp(r'^(IL)?\d{9}$').hasMatch(str),
  'KZ': (str) => RegExp(r'^(KZ)?\d{9}$').hasMatch(str),
  'NZ': (str) => RegExp(r'^(NZ)?\d{9}$').hasMatch(str),
  'NG': (str) => RegExp(r'^(NG)?(\d{12}|(\d{8}-\d{4}))$').hasMatch(str),
  'NO': (str) => RegExp(r'^(NO)?\d{9}MVA$').hasMatch(str),
  'PH': (str) =>
      RegExp(r'^(PH)?(\d{12}|\d{3} \d{3} \d{3} \d{3})$').hasMatch(str),
  'RU': (str) => RegExp(r'^(RU)?(\d{10}|\d{12})$').hasMatch(str),
  'SM': (str) => RegExp(r'^(SM)?\d{5}$').hasMatch(str),
  'SA': (str) => RegExp(r'^(SA)?\d{15}$').hasMatch(str),
  'RS': (str) => RegExp(r'^(RS)?\d{9}$').hasMatch(str),
  'CH': (str) => RegExp(
          r'^(CH)?(\d{6}|\d{9}|(\d{3}.\d{3})|(\d{3}.\d{3}.\d{3}))(TVA|MWST|IVA)$')
      .hasMatch(str),
  'TR': (str) => RegExp(r'^(TR)?\d{10}$').hasMatch(str),
  'UA': (str) => RegExp(r'^(UA)?\d{12}$').hasMatch(str),
  'GB': (str) => RegExp(
          r'^GB((\d{3} \d{4} ([0-8][0-9]|9[0-6]))|(\d{9} \d{3})|(((GD[0-4])|(HA[5-9]))[0-9]{2}))$')
      .hasMatch(str),
  'UZ': (str) => RegExp(r'^(UZ)?\d{9}$').hasMatch(str),

  /**
   * VAT numbers of Latin American countries
   */
  'AR': (str) => RegExp(r'^(AR)?\d{11}$').hasMatch(str),
  'BO': (str) => RegExp(r'^(BO)?\d{7}$').hasMatch(str),
  'BR': (str) => RegExp(
          r'^(BR)?((\d{2}.\d{3}.\d{3}\/\d{4}-\d{2})|(\d{3}.\d{3}.\d{3}-\d{2}))$')
      .hasMatch(str),
  'CL': (str) => RegExp(r'^(CL)?\d{8}-\d{1}$').hasMatch(str),
  'CO': (str) => RegExp(r'^(CO)?\d{10}$').hasMatch(str),
  'CR': (str) => RegExp(r'^(CR)?\d{9,12}$').hasMatch(str),
  'EC': (str) => RegExp(r'^(EC)?\d{13}$').hasMatch(str),
  'SV': (str) => RegExp(r'^(SV)?\d{4}-\d{6}-\d{3}-\d{1}$').hasMatch(str),
  'GT': (str) => RegExp(r'^(GT)?\d{7}-\d{1}$').hasMatch(str),
  'HN': (str) => RegExp(r'^(HN)?$').hasMatch(str),
  'MX': (str) => RegExp(r'^(MX)?\w{3,4}\d{6}\w{3}$').hasMatch(str),
  'NI': (str) => RegExp(r'^(NI)?\d{3}-\d{6}-\d{4}\w{1}$').hasMatch(str),
  'PA': (str) => RegExp(r'^(PA)?$').hasMatch(str),
  'PY': (str) => RegExp(r'^(PY)?\d{6,8}-\d{1}$').hasMatch(str),
  'PE': (str) => RegExp(r'^(PE)?\d{11}$').hasMatch(str),
  'DO': (str) => RegExp(
          r'^(DO)?(\d{11}|(\d{3}-\d{7}-\d{1})|[1,4,5]{1}\d{8}|([1,4,5]{1})-\d{2}-\d{5}-\d{1})$')
      .hasMatch(str),
  'UY': (str) => RegExp(r'^(UY)?\d{12}$').hasMatch(str),
  'VE': (str) =>
      RegExp(r'^(VE)?[J,G,V,E]{1}-(\d{9}|(\d{8}-\d{1}))$').hasMatch(str),
};

bool $isVAT(String str, String countryCode) {
  if (vatMatchers.containsKey(countryCode)) {
    return vatMatchers[countryCode]!(str);
  }
  throw Exception('Invalid country code: \'$countryCode\'');
}
