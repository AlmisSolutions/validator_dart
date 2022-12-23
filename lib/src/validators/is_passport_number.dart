/*
 * Reference:
 * https://en.wikipedia.org/ -- Wikipedia
 * https://docs.microsoft.com/en-us/microsoft-365/compliance/eu-passport-number -- EU Passport Number
 * https://countrycode.org/ -- Country Codes
 */
final passportRegexByCountryCode = {
  'AM': RegExp(r'^[A-Z]{2}\d{7}$'), // ARMENIA
  'AR': RegExp(r'^[A-Z]{3}\d{6}$'), // ARGENTINA
  'AT': RegExp(r'^[A-Z]\d{7}$'), // AUSTRIA
  'AU': RegExp(r'^[A-Z]\d{7}$'), // AUSTRALIA
  'BE': RegExp(r'^[A-Z]{2}\d{6}$'), // BELGIUM
  'BG': RegExp(r'^\d{9}$'), // BULGARIA
  'BR': RegExp(r'^[A-Z]{2}\d{6}$'), // BRAZIL
  'BY': RegExp(r'^[A-Z]{2}\d{7}$'), // BELARUS
  'CA': RegExp(r'^[A-Z]{2}\d{6}$'), // CANADA
  'CH': RegExp(r'^[A-Z]\d{7}$'), // SWITZERLAND
  'CN': RegExp(
      r'G\d{8}$|^E(?![IO])[A-Z0-9]\d{7}$'), // CHINA [G=Ordinary, E=Electronic] followed by 8-digits, or E followed by any UPPERCASE letter (except I and O) followed by 7 digits
  'CY': RegExp(r'^[A-Z](\d{6}|\d{8})$'), // CYPRUS
  'CZ': RegExp(r'^\d{8}$'), // CZECH REPUBLIC
  'DE': RegExp(r'^[CFGHJKLMNPRTVWXYZ0-9]{9}$'), // GERMANY
  'DK': RegExp(r'^\d{9}$'), // DENMARK
  'DZ': RegExp(r'^\d{9}$'), // ALGERIA
  'EE': RegExp(
      r'([A-Z]\d{7}|[A-Z]{2}\d{7})$'), // ESTONIA (K followed by 7-digits), e-passports have 2 UPPERCASE followed by 7 digits
  'ES': RegExp(r'^[A-Z0-9]{2}([A-Z0-9]?)\d{6}$'), // SPAIN
  'FI': RegExp(r'^[A-Z]{2}\d{7}$'), // FINLAND
  'FR': RegExp(r'^\d{2}[A-Z]{2}\d{5}$'), // FRANCE
  'GB': RegExp(r'^\d{9}$'), // UNITED KINGDOM
  'GR': RegExp(r'^[A-Z]{2}\d{7}$'), // GREECE
  'HR': RegExp(r'^\d{9}$'), // CROATIA
  'HU': RegExp(r'^[A-Z]{2}(\d{6}|\d{7})$'), // HUNGARY
  'IE': RegExp(r'^[A-Z0-9]{2}\d{7}$'), // IRELAND
  'IN': RegExp(r'^[A-Z]{1}-?\d{7}$'), // INDIA
  'ID': RegExp(r'^[A-C]\d{7}$'), // INDONESIA
  'IR': RegExp(r'^[A-Z]\d{8}$'), // IRAN
  'IS': RegExp(r'^(A)\d{7}$'), // ICELAND
  'IT': RegExp(r'^[A-Z0-9]{2}\d{7}$'), // ITALY
  'JP': RegExp(r'^[A-Z]{2}\d{7}$'), // JAPAN
  'KR': RegExp(
      r'[MS]\d{8}$'), // SOUTH KOREA, REPUBLIC OF KOREA, [S=PS Passports, M=PM Passports]
  'LT': RegExp(r'^[A-Z0-9]{8}$'), // LITHUANIA
  'LU': RegExp(r'^[A-Z0-9]{8}$'), // LUXEMBURG
  'LV': RegExp(r'^[A-Z0-9]{2}\d{7}$'), // LATVIA
  'LY': RegExp(r'^[A-Z0-9]{8}$'), // LIBYA
  'MT': RegExp(r'^\d{7}$'), // MALTA
  'MZ': RegExp(r'^([A-Z]{2}\d{7})|(\d{2}[A-Z]{2}\d{5})$'), // MOZAMBIQUE
  'MY': RegExp(r'^[AHK]\d{8}$'), // MALAYSIA
  'MX': RegExp(r'^\d{10,11}$'), // MEXICO
  'NL': RegExp(r'^[A-Z]{2}[A-Z0-9]{6}\d$'), // NETHERLANDS
  'PL': RegExp(r'^[A-Z]{2}\d{7}$'), // POLAND
  'PT': RegExp(r'^[A-Z]\d{6}$'), // PORTUGAL
  'RO': RegExp(r'^\d{8,9}$'), // ROMANIA
  'RU': RegExp(r'^\d{9}$'), // RUSSIAN FEDERATION
  'SE': RegExp(r'^\d{8}$'), // SWEDEN
  'SL': RegExp(r'^(P)[A-Z]\d{7}$'), // SLOVANIA
  'SK': RegExp(r'^[0-9A-Z]\d{7}$'), // SLOVAKIA
  'TH': RegExp(r'^[A-Z]{1,2}\d{6,7}$'), // THAILAND
  'TR': RegExp(r'^[A-Z]\d{8}$'), // TURKEY
  'UA': RegExp(r'^[A-Z]{2}\d{6}$'), // UKRAINE
  'US': RegExp(r'^\d{9}$'), // UNITED STATES
};

/// Check if [str] is a valid passport number relative to provided ISO Country Code.
bool $isPassportNumber(String str, String countryCode) {
  // Remove All Whitespaces, Convert to UPPERCASE
  final normalizedStr = str.replaceAll(RegExp(r'\s'), '').toUpperCase();

  return passportRegexByCountryCode.containsKey(countryCode.toUpperCase()) &&
      passportRegexByCountryCode[countryCode.toUpperCase()]!
          .hasMatch(normalizedStr);
}
