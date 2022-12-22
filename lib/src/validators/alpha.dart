final _alpha = {
  'en-US': RegExp(r'^[A-Z]+$', caseSensitive: false),
  'az-AZ': RegExp(r'^[A-VXYZÇƏĞİıÖŞÜ]+$', caseSensitive: false),
  'bg-BG': RegExp(r'^[А-Я]+$', caseSensitive: false),
  'cs-CZ': RegExp(r'^[A-ZÁČĎÉĚÍŇÓŘŠŤÚŮÝŽ]+$', caseSensitive: false),
  'da-DK': RegExp(r'^[A-ZÆØÅ]+$', caseSensitive: false),
  'de-DE': RegExp(r'^[A-ZÄÖÜß]+$', caseSensitive: false),
  'el-GR': RegExp(r'^[Α-ώ]+$', caseSensitive: false),
  'es-ES': RegExp(r'^[A-ZÁÉÍÑÓÚÜ]+$', caseSensitive: false),
  'fa-IR':
      RegExp(r'^[ابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهی]+$', caseSensitive: false),
  'fi-FI': RegExp(r'^[A-ZÅÄÖ]+$', caseSensitive: false),
  'fr-FR': RegExp(r'^[A-ZÀÂÆÇÉÈÊËÏÎÔŒÙÛÜŸ]+$', caseSensitive: false),
  'it-IT': RegExp(r'^[A-ZÀÉÈÌÎÓÒÙ]+$', caseSensitive: false),
  'ja-JP': RegExp(r'^[ぁ-んァ-ヶｦ-ﾟ一-龠ー・。、]+$', caseSensitive: false),
  'nb-NO': RegExp(r'^[A-ZÆØÅ]+$', caseSensitive: false),
  'nl-NL': RegExp(r'^[A-ZÁÉËÏÓÖÜÚ]+$', caseSensitive: false),
  'nn-NO': RegExp(r'^[A-ZÆØÅ]+$', caseSensitive: false),
  'hu-HU': RegExp(r'^[A-ZÁÉÍÓÖŐÚÜŰ]+$', caseSensitive: false),
  'pl-PL': RegExp(r'^[A-ZĄĆĘŚŁŃÓŻŹ]+$', caseSensitive: false),
  'pt-PT': RegExp(r'^[A-ZÃÁÀÂÄÇÉÊËÍÏÕÓÔÖÚÜ]+$', caseSensitive: false),
  'ru-RU': RegExp(r'^[А-ЯЁ]+$', caseSensitive: false),
  'sl-SI': RegExp(r'^[A-ZČĆĐŠŽ]+$', caseSensitive: false),
  'sk-SK': RegExp(r'^[A-ZÁČĎÉÍŇÓŠŤÚÝŽĹŔĽÄÔ]+$', caseSensitive: false),
  'sr-RS@latin': RegExp(r'^[A-ZČĆŽŠĐ]+$', caseSensitive: false),
  'sr-RS': RegExp(r'^[А-ЯЂЈЉЊЋЏ]+$', caseSensitive: false),
  'sv-SE': RegExp(r'^[A-ZÅÄÖ]+$', caseSensitive: false),
  'th-TH': RegExp(r'^[ก-๐\s]+$', caseSensitive: false),
  'tr-TR': RegExp(r'^[A-ZÇĞİıÖŞÜ]+$', caseSensitive: false),
  'uk-UA': RegExp(r'^[А-ЩЬЮЯЄIЇҐі]+$', caseSensitive: false),
  'vi-VN': RegExp(
      r'^[A-ZÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴĐÈÉẸẺẼÊỀẾỆỂỄÌÍỊỈĨÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠÙÚỤỦŨƯỪỨỰỬỮỲÝỴỶỸ]+$',
      caseSensitive: false),
  'ko-KR': RegExp(r'^[ㄱ-ㅎㅏ-ㅣ가-힣]*$'),
  'ku-IQ': RegExp(r'^[ئابپتجچحخدرڕزژسشعغفڤقکگلڵمنوۆھەیێيطؤثآإأكضصةظذ]+$',
      caseSensitive: false),
  'ar': RegExp(r'^[ءآأؤإئابةتثجحخدذرزسشصضطظعغفقكلمنهوىيًٌٍَُِّْٰ]+$'),
  'he': RegExp(r'^[א-ת]+$'),
  'fa': RegExp(r"^['آاءأؤئبپتثجچحخدذرزژسشصضطظعغفقکگلمنوهةی']+$",
      caseSensitive: false),
  'bn': RegExp(
      r"^['ঀঁংঃঅআইঈউঊঋঌএঐওঔকখগঘঙচছজঝঞটঠডঢণতথদধনপফবভমযরলশষসহ়ঽািীুূৃৄেৈোৌ্ৎৗড়ঢ়য়ৠৡৢৣৰৱ৲৳৴৵৶৷৸৹৺৻']+$"),
  'hi-IN': RegExp(r'^[\u0900-\u0961]+[\u0972-\u097F]*$', caseSensitive: false),
  'si-LK': RegExp(r'^[\u0D80-\u0DFF]+$'),
};

Map<String, RegExp> alphanumeric = {
  'en-US': RegExp(r'^[0-9A-Z]+$', caseSensitive: false),
  'az-AZ': RegExp(r'^[0-9A-VXYZÇƏĞİıÖŞÜ]+$', caseSensitive: false),
  'bg-BG': RegExp(r'^[0-9А-Я]+$', caseSensitive: false),
  'cs-CZ': RegExp(r'^[0-9A-ZÁČĎÉĚÍŇÓŘŠŤÚŮÝŽ]+$', caseSensitive: false),
  'da-DK': RegExp(r'^[0-9A-ZÆØÅ]+$', caseSensitive: false),
  'de-DE': RegExp(r'^[0-9A-ZÄÖÜß]+$', caseSensitive: false),
  'el-GR': RegExp(r'^[0-9Α-ω]+$', caseSensitive: false),
  'es-ES': RegExp(r'^[0-9A-ZÁÉÍÑÓÚÜ]+$', caseSensitive: false),
  'fi-FI': RegExp(r'^[0-9A-ZÅÄÖ]+$', caseSensitive: false),
  'fr-FR': RegExp(r'^[0-9A-ZÀÂÆÇÉÈÊËÏÎÔŒÙÛÜŸ]+$', caseSensitive: false),
  'it-IT': RegExp(r'^[0-9A-ZÀÉÈÌÎÓÒÙ]+$', caseSensitive: false),
  'ja-JP': RegExp(r'^[0-9０-９ぁ-んァ-ヶｦ-ﾟ一-龠ー・。、]+$', caseSensitive: false),
  'hu-HU': RegExp(r'^[0-9A-ZÁÉÍÓÖŐÚÜŰ]+$', caseSensitive: false),
  'nb-NO': RegExp(r'^[0-9A-ZÆØÅ]+$', caseSensitive: false),
  'nl-NL': RegExp(r'^[0-9A-ZÁÉËÏÓÖÜÚ]+$', caseSensitive: false),
  'nn-NO': RegExp(r'^[0-9A-ZÆØÅ]+$', caseSensitive: false),
  'pl-PL': RegExp(r'^[0-9A-ZĄĆĘŚŁŃÓŻŹ]+$', caseSensitive: false),
  'pt-PT': RegExp(r'^[0-9A-ZÃÁÀÂÄÇÉÊËÍÏÕÓÔÖÚÜ]+$', caseSensitive: false),
  'ru-RU': RegExp(r'^[0-9А-ЯЁ]+$', caseSensitive: false),
  'sl-SI': RegExp(r'^[0-9A-ZČĆĐŠŽ]+$', caseSensitive: false),
  'sk-SK': RegExp(r'^[0-9A-ZÁČĎÉÍŇÓŠŤÚÝŽĹŔĽÄÔ]+$', caseSensitive: false),
  'sr-RS@latin': RegExp(r'^[0-9A-ZČĆŽŠĐ]+$', caseSensitive: false),
  'sr-RS': RegExp(r'^[0-9А-ЯЂЈЉЊЋЏ]+$', caseSensitive: false),
  'sv-SE': RegExp(r'^[0-9A-ZÅÄÖ]+$', caseSensitive: false),
  'th-TH': RegExp(r'^[ก-๙\s]+$', caseSensitive: false),
  'tr-TR': RegExp(r'^[0-9A-ZÇĞİıÖŞÜ]+$', caseSensitive: false),
  'uk-UA': RegExp(r'^[0-9А-ЩЬЮЯЄIЇҐі]+$', caseSensitive: false),
  'ko-KR': RegExp(r'^[0-9ㄱ-ㅎㅏ-ㅣ가-힣]*$'),
  'ku-IQ': RegExp(
      r'^[٠١٢٣٤٥٦٧٨٩0-9ئابپتجچحخدرڕزژسشعغفڤقکگلڵمنوۆھەیێيطؤثآإأكضصةظذ]+$',
      caseSensitive: false),
  'vi-VN': RegExp(
      r'^[0-9A-ZÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴĐÈÉẸẺẼÊỀẾỆỂỄÌÍỊỈĨÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠÙÚỤỦŨƯỪỨỰỬỮỲÝỴỶỸ]+$',
      caseSensitive: false),
  'ar': RegExp(
      r'^[٠١٢٣٤٥٦٧٨٩0-9ءآأؤإئابةتثجحخدذرزسشصضطظعغفقكلمنهوىيًٌٍَُِّْٰ]+$'),
  'he': RegExp(r'^[0-9א-ת]+$'),
  'fa': RegExp(
      r'''^[\'0-9آاءأؤئبپتثجچحخدذرزژسشصضطظعغفقکگلمنوهةی۱۲۳۴۵۶۷۸۹۰\']+$''',
      caseSensitive: false),
  'bn': RegExp(
      r'''^[\'ঀঁংঃঅআইঈউঊঋঌএঐওঔকখগঘঙচছজঝঞটঠডঢণতথদধনপফবভমযরলশষসহ়ঽািীুূৃৄেৈোৌ্ৎৗড়ঢ়য়ৠৡৢৣ০১২৩৪৫৬৭৮৯ৰৱ৲৳৴৵৶৷৸৹৺৻\']+$'''),
  'hi-IN': RegExp(r'^[\u0900-\u0963]+[\u0966-\u097F]*$', caseSensitive: false),
  'si-LK': RegExp(r'^[0-9\u0D80-\u0DFF]+$'),
};

Map<String, String> decimal = {
  'en-US': '.',
  'ar': '٫',
};

final englishLocales = ['AU', 'GB', 'HK', 'IN', 'NZ', 'ZA', 'ZM'];

// Source: http://www.localeplanet.com/java/
final arabicLocales = [
  'AE',
  'BH',
  'DZ',
  'EG',
  'IQ',
  'JO',
  'KW',
  'LB',
  'LY',
  'MA',
  'QM',
  'QA',
  'SA',
  'SD',
  'SY',
  'TN',
  'YE'
];
final farsiLocales = ['IR', 'AF'];

final bengaliLocales = ['BD', 'IN'];

final dotDecimal = ['ar-EG', 'ar-LB', 'ar-LY'];
final commaDecimal = [
  'bg-BG',
  'cs-CZ',
  'da-DK',
  'de-DE',
  'el-GR',
  'en-ZM',
  'es-ES',
  'fr-CA',
  'fr-FR',
  'id-ID',
  'it-IT',
  'ku-IQ',
  'hi-IN',
  'hu-HU',
  'nb-NO',
  'nn-NO',
  'nl-NL',
  'pl-PL',
  'pt-PT',
  'ru-RU',
  'si-LK',
  'sl-SI',
  'sr-RS@latin',
  'sr-RS',
  'sv-SE',
  'tr-TR',
  'uk-UA',
  'vi-VN',
];

Map<String, dynamic> $alpha() {
  for (var i = 0; i < englishLocales.length; i++) {
    final locale = 'en-${englishLocales[i]}';
    _alpha[locale] = _alpha['en-US']!;
    alphanumeric[locale] = alphanumeric['en-US']!;
    decimal[locale] = decimal['en-US']!;
  }

  for (var i = 0; i < arabicLocales.length; i++) {
    final locale = 'ar-${arabicLocales[i]}';
    _alpha[locale] = _alpha['ar']!;
    alphanumeric[locale] = alphanumeric['ar']!;
    decimal[locale] = decimal['ar']!;
  }

  for (var i = 0; i < bengaliLocales.length; i++) {
    final locale = 'bn-${bengaliLocales[i]}';
    _alpha[locale] = _alpha['bn']!;
    alphanumeric[locale] = alphanumeric['bn']!;
    decimal[locale] = decimal['en-US']!;
  }

  for (var i = 0; i < farsiLocales.length; i++) {
    final locale = 'fa-${farsiLocales[i]}';
    alphanumeric[locale] = alphanumeric['fa']!;
    decimal[locale] = decimal['ar']!;
  }

  for (var i = 0; i < dotDecimal.length; i++) {
    decimal[dotDecimal[i]] = decimal['en-US']!;
  }

  for (var i = 0; i < commaDecimal.length; i++) {
    decimal[commaDecimal[i]] = ',';
  }

  _alpha['fr-CA'] = _alpha['fr-FR']!;
  alphanumeric['fr-CA'] = alphanumeric['fr-FR']!;

  _alpha['pt-BR'] = _alpha['pt-PT']!;
  alphanumeric['pt-BR'] = alphanumeric['pt-PT']!;
  decimal['pt-BR'] = decimal['pt-PT']!;

  // see #862
  _alpha['pl-Pl'] = _alpha['pl-PL']!;
  alphanumeric['pl-Pl'] = alphanumeric['pl-PL']!;
  decimal['pl-Pl'] = decimal['pl-PL']!;

  // see #1455
  _alpha['fa-AF'] = _alpha['fa']!;

  return _alpha;
}
