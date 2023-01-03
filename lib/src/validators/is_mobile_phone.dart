const enUs =
    r'^((\+1|1)?( |-)?)?(\([2-9][0-9]{2}\)|[2-9][0-9]{2})( |-)?([2-9][0-9]{2}( |-)?[0-9]{4})$';
const nlBE = r'^(\+?32|0)4\d{8}$';
const enHK = r'^(\+?852[-\s]?)?[456789]\d{3}[-\s]?\d{4}$';
const enMO = r'^(\+?853[-\s]?)?[6]\d{3}[-\s]?\d{4}$';
const enIE = r'^(\+?353|0)8[356789]\d{7}$';
const deCH = r'^(\+41|0)([1-9])\d{1,9}$';

final phones = {
  'am-AM': RegExp(r'^(\+?374|0)((10|[9|7][0-9])\d{6}$|[2-4]\d{7}$)'),
  'ar-AE': RegExp(r'^((\+?971)|0)?5[024568]\d{7}$'),
  'ar-BH': RegExp(r'^(\+?973)?(3|6)\d{7}$'),
  'ar-DZ': RegExp(r'^(\+?213|0)(5|6|7)\d{8}$'),
  'ar-LB': RegExp(r'^(\+?961)?((3|81)\d{6}|7\d{7})$'),
  'ar-EG': RegExp(r'^((\+?20)|0)?1[0125]\d{8}$'),
  'ar-IQ': RegExp(r'^(\+?964|0)?7[0-9]\d{8}$'),
  'ar-JO': RegExp(r'^(\+?962|0)?7[789]\d{7}$'),
  'ar-KW': RegExp(r'^(\+?965)[569]\d{7}$'),
  'ar-LY': RegExp(r'^((\+?218)|0)?(9[1-6]\d{7}|[1-8]\d{7,9})$'),
  'ar-MA': RegExp(r'^(?:(?:\+|00)212|0)[5-7]\d{8}$'),
  'ar-OM': RegExp(r'^((\+|00)968)?(9[1-9])\d{6}$'),
  'ar-PS': RegExp(r'^(\+?970|0)5[6|9](\d{7})$'),
  'ar-SA': RegExp(r'^(!?(\+?966)|0)?5\d{8}$'),
  'ar-SY': RegExp(r'^(!?(\+?963)|0)?9\d{8}$'),
  'ar-TN': RegExp(r'^(\+?216)?[2459]\d{7}$'),
  'az-AZ': RegExp(r'^(\+994|0)(10|5[015]|7[07]|99)\d{7}$'),
  'bs-BA': RegExp(r'^((((\+|00)3876)|06))((([0-3]|[5-6])\d{6})|(4\d{7}))$'),
  'be-BY': RegExp(r'^(\+?375)?(24|25|29|33|44)\d{7}$'),
  'bg-BG': RegExp(r'^(\+?359|0)?8[789]\d{7}$'),
  'bn-BD': RegExp(r'^(\+?880|0)1[13456789][0-9]{8}$'),
  'ca-AD': RegExp(r'^(\+376)?[346]\d{5}$'),
  'cs-CZ': RegExp(r'^(\+?420)? ?[1-9][0-9]{2} ?[0-9]{3} ?[0-9]{3}$'),
  'da-DK': RegExp(r'^(\+?45)?\s?\d{2}\s?\d{2}\s?\d{2}\s?\d{2}$'),
  'de-DE':
      RegExp(r'^((\+49|0)1)(5[0-25-9]\d|6([23]|0\d?)|7([0-57-9]|6\d))\d{7,9}$'),
  'de-AT': RegExp(r'^(\+43|0)\d{1,4}\d{3,12}$'),
  'de-CH': RegExp(deCH),
  'de-LU': RegExp(r'^(\+352)?((6\d1)\d{6})$'),
  'dv-MV': RegExp(r'^(\+?960)?(7[2-9]|91|9[3-9])\d{7}$'),
  'el-GR': RegExp(r'^(\+?30|0)?(69\d{8})$'),
  'el-CY': RegExp(r'^(\+?357?)?(9(9|6)\d{6})$'),
  'en-AI': RegExp(
      r'^(\+?1|0)264(?:2(35|92)|4(?:6[1-2]|76|97)|5(?:3[6-9]|8[1-4])|7(?:2(4|9)|72))\d{4}$'),
  'en-AU': RegExp(r'^(\+?61|0)4\d{8}$'),
  'en-AG': RegExp(
      r'^(?:\+1|1)268(?:464|7(?:1[3-9]|[28]\d|3[0246]|64|7[0-689]))\d{4}$'),
  'en-BM': RegExp(r'^(\+?1)?441(((3|7)\d{6}$)|(5[0-3][0-9]\d{4}$)|(59\d{5}))'),
  'en-BS': RegExp(r'^(\+?1[-\s]?|0)?\(?242\)?[-\s]?\d{3}[-\s]?\d{4}$'),
  'en-CA': RegExp(enUs),
  'en-GB': RegExp(r'^(\+?44|0)7\d{9}$'),
  'en-GG': RegExp(r'^(\+?44|0)1481\d{6}$'),
  'en-GH': RegExp(r'^(\+233|0)(20|50|24|54|27|57|26|56|23|28|55|59)\d{7}$'),
  'en-GY': RegExp(r'^(\+592|0)6\d{6}$'),
  'en-HK': RegExp(enHK),
  'en-MO': RegExp(enMO),
  'en-IE': RegExp(enIE),
  'en-IN': RegExp(r'^(\+?91|0)?[6789]\d{9}$'),
  'en-JM': RegExp(r'^(\+?876)?\d{7}$'),
  'en-KE': RegExp(r'^(\+?254|0)(7|1)\d{8}$'),
  'en-KI': RegExp(r'^((\+686|686)?)?( )?((6|7)(2|3|8)[0-9]{6})$'),
  'en-KN': RegExp(r'^(?:\+1|1)869(?:46\d|48[89]|55[6-8]|66\d|76[02-7])\d{4}$'),
  'en-LS': RegExp(r'^(\+?266)(22|28|57|58|59|27|52)\d{6}$'),
  'en-MT': RegExp(r'^(\+?356|0)?(99|79|77|21|27|22|25)[0-9]{6}$'),
  'en-MU': RegExp(r'^(\+?230|0)?\d{8}$'),
  'en-NA': RegExp(r'^(\+?264|0)(6|8)\d{7}$'),
  'en-NG': RegExp(r'^(\+?234|0)?[789]\d{9}$'),
  'en-NZ': RegExp(r'^(\+?64|0)[28]\d{7,9}$'),
  'en-PG': RegExp(r'^(\+?675|0)?(7\d|8[18])\d{6}$'),
  'en-PK': RegExp(r'^((00|\+)?92|0)3[0-6]\d{8}$'),
  'en-PH': RegExp(r'^(09|\+639)\d{9}$'),
  'en-RW': RegExp(r'^(\+?250|0)?[7]\d{8}$'),
  'en-SG': RegExp(r'^(\+65)?[3689]\d{7}$'),
  'en-SL': RegExp(r'^(\+?232|0)\d{8}$'),
  'en-TZ': RegExp(r'^(\+?255|0)?[67]\d{8}$'),
  'en-UG': RegExp(r'^(\+?256|0)?[7]\d{8}$'),
  'en-US': RegExp(enUs),
  'en-ZA': RegExp(r'^(\+?27|0)\d{9}$'),
  'en-ZM': RegExp(r'^(\+?26)?09[567]\d{7}$'),
  'en-ZW': RegExp(r'^(\+263)[0-9]{9}$'),
  'en-BW': RegExp(r'^(\+?267)?(7[1-8]{1})\d{6}$'),
  'es-AR': RegExp(r'^\+?549(11|[2368]\d)\d{8}$'),
  'es-BO': RegExp(r'^(\+?591)?(6|7)\d{7}$'),
  'es-CO': RegExp(r'^(\+?57)?3(0(0|1|2|4|5)|1\d|2[0-4]|5(0|1))\d{7}$'),
  'es-CL': RegExp(r'^(\+?56|0)[2-9]\d{1}\d{7}$'),
  'es-CR': RegExp(r'^(\+506)?[2-8]\d{7}$'),
  'es-CU': RegExp(r'^(\+53|0053)?5\d{7}'),
  'es-DO': RegExp(r'^(\+?1)?8[024]9\d{7}$'),
  'es-HN': RegExp(r'^(\+?504)?[9|8]\d{7}$'),
  'es-EC': RegExp(r'^(\+?593|0)([2-7]|9[2-9])\d{7}$'),
  'es-ES': RegExp(r'^(\+?34)?[6|7]\d{8}$'),
  'es-PE': RegExp(r'^(\+?51)?9\d{8}$'),
  'es-MX': RegExp(r'^(\+?52)?(1|01)?\d{10,11}$'),
  'es-NI': RegExp(r'^(\+?505)\d{7,8}$'),
  'es-PA': RegExp(r'^(\+?507)\d{7,8}$'),
  'es-PY': RegExp(r'^(\+?595|0)9[9876]\d{7}$'),
  'es-SV': RegExp(r'^(\+?503)?[67]\d{7}$'),
  'es-UY': RegExp(r'^(\+598|0)9[1-9][\d]{6}$'),
  'es-VE': RegExp(r'^(\+?58)?(2|4)\d{9}$'),
  'et-EE': RegExp(r'^(\+?372)?\s?(5|8[1-4])\s?([0-9]\s?){6,7}$'),
  'fa-IR': RegExp(r'^(\+?98[\-\s]?|0)9[0-39]\d[\-\s]?\d{3}[\-\s]?\d{4}$'),
  'fi-FI': RegExp(r'^(\+?358|0)\s?(4[0-6]|50)\s?(\d\s?){4,8}$'),
  'fj-FJ': RegExp(r'^(\+?679)?\s?\d{3}\s?\d{4}$'),
  'fo-FO': RegExp(r'^(\+?298)?\s?\d{2}\s?\d{2}\s?\d{2}$'),
  'fr-BE': RegExp(nlBE),
  'fr-BF': RegExp(r'^(\+226|0)[67]\d{7}$'),
  'fr-BJ': RegExp(r'^(\+229)\d{8}$'),
  'fr-CA': RegExp(enUs),
  'fr-CH': RegExp(deCH),
  'fr-CM': RegExp(r'^(\+?237)6[0-9]{8}$'),
  'fr-FR': RegExp(r'^(\+?33|0)[67]\d{8}$'),
  'fr-GF': RegExp(r'^(\+?594|0|00594)[67]\d{8}$'),
  'fr-GP': RegExp(r'^(\+?590|0|00590)[67]\d{8}$'),
  'fr-MQ': RegExp(r'^(\+?596|0|00596)[67]\d{8}$'),
  'fr-PF': RegExp(r'^(\+?689)?8[789]\d{6}$'),
  'fr-RE': RegExp(r'^(\+?262|0|00262)[67]\d{8}$'),
  'ga-IE': RegExp(enIE),
  'he-IL': RegExp(r'^(\+972|0)([23489]|5[012345689]|77)[1-9]\d{6}$'),
  'hu-HU': RegExp(r'^(\+?36|06)(20|30|31|50|70)\d{7}$'),
  'id-ID': RegExp(
      r'^(\+?62|0)8(1[123456789]|2[1238]|3[1238]|5[12356789]|7[78]|9[56789]|8[123456789])([\s?|\d]{5,11})$'),
  'ir-IR': RegExp(r'^(\+98|0)?9\d{9}$'),
  'it-CH': RegExp(deCH),
  'it-IT': RegExp(r'^(\+?39)?\s?3\d{2} ?\d{6,7}$'),
  'it-SM': RegExp(r'^((\+378)|(0549)|(\+390549)|(\+3780549))?6\d{5,9}$'),
  'ja-JP': RegExp(r'^(\+81[ \-]?(\(0\))?|0)[6789]0[ \-]?\d{4}[ \-]?\d{4}$'),
  'ka-GE': RegExp(r'^(\+?995)?(79\d{7}|5\d{8})$'),
  'kk-KZ': RegExp(r'^(\+?7|8)?7\d{9}$'),
  'kl-GL': RegExp(r'^(\+?299)?\s?\d{2}\s?\d{2}\s?\d{2}$'),
  'ko-KR': RegExp(
      r'^((\+?82)[ \-]?)?0?1([0|1|6|7|8|9]{1})[ \-]?\d{3,4}[ \-]?\d{4}$'),
  'ky-KG': RegExp(r'^(\+?7\s?\+?7|0)\s?\d{2}\s?\d{3}\s?\d{4}$'),
  'lt-LT': RegExp(r'^(\+370|8)\d{8}$'),
  'lv-LV': RegExp(r'^(\+?371)2\d{7}$'),
  'mg-MG': RegExp(r'^((\+?261|0)(2|3)\d)?\d{7}$'),
  'mn-MN': RegExp(r'^(\+|00|011)?976(77|81|88|91|94|95|96|99)\d{6}$'),
  'my-MM': RegExp(
      r'^(\+?959|09|9)(2[5-7]|3[1-2]|4[0-5]|6[6-9]|7[5-9]|9[6-9])[0-9]{7}$'),
  'ms-MY': RegExp(
      r'^(\+?6?01){1}(([0145]{1}(\-|\s)?\d{7,8})|([236789]{1}(\s|\-)?\d{7}))$'),
  'mz-MZ': RegExp(r'^(\+?258)?8[234567]\d{7}$'),
  'nb-NO': RegExp(r'^(\+?47)?[49]\d{7}$'),
  'ne-NP': RegExp(r'^(\+?977)?9[78]\d{8}$'),
  'nl-BE': RegExp(nlBE),
  'nl-NL': RegExp(r'^(((\+|00)?31\(0\))|((\+|00)?31)|0)6{1}\d{8}$'),
  'nl-AW': RegExp(r'^(\+)?297(56|59|64|73|74|99)\d{5}$'),
  'nn-NO': RegExp(r'^(\+?47)?[49]\d{7}$'),
  'pl-PL': RegExp(r'^(\+?48)? ?[5-8]\d ?\d{3} ?\d{2} ?\d{2}$'),
  'pt-BR': RegExp(
      r'^((\+?55\ ?[1-9]{2}\ ?)|(\+?55\ ?\([1-9]{2}\)\ ?)|(0[1-9]{2}\ ?)|(\([1-9]{2}\)\ ?)|([1-9]{2}\ ?))((\d{4}\-?\d{4})|(9[1-9]{1}\d{3}\-?\d{4}))$'),
  'pt-PT': RegExp(r'^(\+?351)?9[1236]\d{7}$'),
  'pt-AO': RegExp(r'^(\+244)\d{9}$'),
  'ro-RO': RegExp(r'^(\+?4?0)\s?7\d{2}(\/|\s|\.|\-)?\d{3}(\s|\.|\-)?\d{3}$'),
  'ru-RU': RegExp(r'^(\+?7|8)?9\d{9}$'),
  'si-LK': RegExp(r'^(?:0|94|\+94)?(7(0|1|2|4|5|6|7|8)( |-)?)\d{7}$'),
  'sl-SI': RegExp(
      r'^(\+386\s?|0)(\d{1}\s?\d{3}\s?\d{2}\s?\d{2}|\d{2}\s?\d{3}\s?\d{3})$'),
  'sk-SK': RegExp(r'^(\+?421)? ?[1-9][0-9]{2} ?[0-9]{3} ?[0-9]{3}$'),
  'sq-AL': RegExp(r'^(\+355|0)6[789]\d{6}$'),
  'sr-RS': RegExp(r'^(\+3816|06)[- \d]{5,9}$'),
  'sv-SE': RegExp(r'^(\+?46|0)[\s\-]?7[\s\-]?[02369]([\s\-]?\d){7}$'),
  'tg-TJ': RegExp(r'^(\+?992)?[5][5]\d{7}$'),
  'th-TH': RegExp(r'^(\+66|66|0)\d{9}$'),
  'tr-TR': RegExp(r'^(\+?90|0)?5\d{9}$'),
  'tk-TM': RegExp(r'^(\+993|993|8)\d{8}$'),
  'uk-UA': RegExp(r'^(\+?38|8)?0\d{9}$'),
  'uz-UZ': RegExp(r'^(\+?998)?(6[125-79]|7[1-69]|88|9\d)\d{7}$'),
  'vi-VN': RegExp(
      r'^((\+?84)|0)((3([2-9]))|(5([25689]))|(7([0|6-9]))|(8([1-9]))|(9([0-9])))([0-9]{7})$'),
  'zh-CN': RegExp(r'^((\+|00)86)?(1[3-9]|9[28])\d{9}$'),
  'zh-HK': RegExp(enHK),
  'zh-MO': RegExp(enMO),
  'zh-TW': RegExp(r'^(\+?886\-?|0)?9\d{8}$'),
  'dz-BT': RegExp(r'^(\+?975|0)?(17|16|77|02)\d{6}$'),
  'ar-YE': RegExp(r'^(((\+|00)9677|0?7)[0137]\d{7}|((\+|00)967|0)[1-7]\d{6})$'),
  'ar-EH': RegExp(r'^(\+?212|0)[\s\-]?(5288|5289)[\s\-]?\d{5}$'),
  'fa-AF': RegExp(r'^(\+93|0)?(2{1}[0-8]{1}|[3-5]{1}[0-4]{1})(\d{7})$'),
};

class MobilePhoneOptions {
  bool strictMode;

  MobilePhoneOptions({this.strictMode = false});
}

bool $isMobilePhone(String str, dynamic locale, {MobilePhoneOptions? options}) {
  options ??= MobilePhoneOptions();

  if (locale == 'en-ZW' || (locale is List && locale.contains('en-ZW'))) {
    int x = 0;
  }

  if (options.strictMode && !str.startsWith('+')) {
    return false;
  }
  if (locale is List) {
    return locale.any((key) {
      if (phones.containsKey(key)) {
        final phone = phones[key];
        if (phone!.hasMatch(str)) {
          return true;
        }
      }
      return false;
    });
  } else if (phones.containsKey(locale)) {
    return phones[locale]!.hasMatch(str);
  } else if (locale == null || locale == 'any') {
    for (final key in phones.keys) {
      final phone = phones[key];
      if (phone!.hasMatch(str)) {
        return true;
      }
    }
    return false;
  }
  throw Exception('Invalid locale "$locale"');
}
