// common patterns
final threeDigit = RegExp(r'^\d{3}$');
final fourDigit = RegExp(r'^\d{4}$');
final fiveDigit = RegExp(r'^\d{5}$');
final sixDigit = RegExp(r'^\d{6}$');

final patterns = {
  'AD': RegExp(r'^AD\d{3}$'),
  'AT': fourDigit,
  'AU': fourDigit,
  'AZ': RegExp(r'^AZ\d{4}$'),
  'BA': RegExp(r'^([7-8]\d{4}$)'),
  'BE': fourDigit,
  'BG': fourDigit,
  'BR': RegExp(r'^\d{5}-\d{3}$'),
  'BY': RegExp(r'2[1-4]{1}\d{4}$'),
  'CA': RegExp(
      r'^[ABCEGHJKLMNPRSTVXY]\d[ABCEGHJ-NPRSTV-Z][\s\-]?\d[ABCEGHJ-NPRSTV-Z]\d$',
      caseSensitive: false),
  'CH': fourDigit,
  'CN': RegExp(
      r'^(0[1-7]|1[012356]|2[0-7]|3[0-6]|4[0-7]|5[1-7]|6[1-7]|7[1-5]|8[1345]|9[09])\d{4}$'),
  'CZ': RegExp(r'^\d{3}\s?\d{2}$'),
  'DE': fiveDigit,
  'DK': fourDigit,
  'DO': fiveDigit,
  'DZ': fiveDigit,
  'EE': fiveDigit,
  'ES': RegExp(r'^(5[0-2]{1}|[0-4]{1}\d{1})\d{3}$'),
  'FI': fiveDigit,
  'FR': RegExp(r'^\d{2}\s?\d{3}$'),
  'GB': RegExp(r'^(gir\s?0aa|[a-z]{1,2}\d[\da-z]?\s?(\d[a-z]{2})?)$',
      caseSensitive: false),
  'GR': RegExp(r'^\d{3}\s?\d{2}$'),
  'HR': RegExp(r'^([1-5]\d{4}$)'),
  'HT': RegExp(r'^HT\d{4}$'),
  'HU': fourDigit,
  'ID': fiveDigit,
  'IE': RegExp(r'^(?!.*(?:o))[A-Za-z]\d[\dw]\s\w{4}$', caseSensitive: false),
  'IL': RegExp(r'^(\d{5}|\d{7})$'),
  'IN': RegExp(r'^((?!10|29|35|54|55|65|66|86|87|88|89)[1-9][0-9]{5})$'),
  'IR': RegExp(r'\b(?!(\d)\1{3})[13-9]{4}[1346-9][013-9]{5}\b'),
  'IS': threeDigit,
  'IT': fiveDigit,
  'JP': RegExp(r'^\d{3}\-\d{4}$'),
  'KE': fiveDigit,
  'KR': RegExp(r'^(\d{5}|\d{6})$'),
  'LI': RegExp(r'^(948[5-9]|949[0-7])$'),
  'LT': RegExp(r'^LT\-\d{5}$'),
  'LU': fourDigit,
  'LV': RegExp(r'^LV\-\d{4}$'),
  'LK': fiveDigit,
  'MG': threeDigit,
  'MX': fiveDigit,
  'MT': RegExp(r'^[A-Za-z]{3}\s{0,1}\d{4}$'),
  'MY': fiveDigit,
  'NL': RegExp(r'^\d{4}\s?[a-z]{2}$', caseSensitive: false),
  'NO': fourDigit,
  'NP': RegExp(r'^(10|21|22|32|33|34|44|45|56|57)\d{3}$|^(977)$',
      caseSensitive: false),
  'NZ': fourDigit,
  'PL': RegExp(r'^\d{2}\-\d{3}$'),
  'PR': RegExp(r'^00[679]\d{2}([ -]\d{4})?$'),
  'PT': RegExp(r'^\d{4}\-\d{3}?$'),
  'RO': sixDigit,
  'RU': sixDigit,
  'SA': fiveDigit,
  'SE': RegExp(r'^[1-9]\d{2}\s?\d{2}$'),
  'SG': sixDigit,
  'SI': fourDigit,
  'SK': RegExp(r'^\d{3}\s?\d{2}$'),
  'TH': fiveDigit,
  'TN': fourDigit,
  'TW': RegExp(r'^\d{3}(\d{2})?$'),
  'UA': fiveDigit,
  'US': RegExp(r'^\d{5}(-\d{4})?$'),
  'ZA': fourDigit,
  'ZM': fiveDigit,
};

bool $isPostalCode(String str, String locale) {
  if (patterns.containsKey(locale)) {
    return patterns[locale]!.hasMatch(str);
  } else if (locale == 'any') {
    for (final key in patterns.keys) {
      final pattern = patterns[key];
      if (pattern!.hasMatch(str)) {
        return true;
      }
    }
    return false;
  }
  throw Exception("Invalid locale '$locale'");
}
