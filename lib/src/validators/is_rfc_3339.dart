final dateFullYear = RegExp(r'[0-9]{4}');
final dateMonth = RegExp(r'(0[1-9]|1[0-2])');
final dateMDay = RegExp(r'([12]\d|0[1-9]|3[01])');

final timeHour = RegExp(r'([01][0-9]|2[0-3])');
final timeMinute = RegExp(r'[0-5][0-9]');
final timeSecond = RegExp(r'([0-5][0-9]|60)');

final timeSecFrac = RegExp(r'(\.[0-9]+)?');
final timeNumOffset = RegExp('[-+]${timeHour.pattern}:${timeMinute.pattern}');
final timeOffset = RegExp('([zZ]|${timeNumOffset.pattern})');

final partialTime = RegExp(
    '${timeHour.pattern}:${timeMinute.pattern}:${timeSecond.pattern}${timeSecFrac.pattern}');

final fullDate =
    RegExp('${dateFullYear.pattern}-${dateMonth.pattern}-${dateMDay.pattern}');
final fullTime = RegExp('${partialTime.pattern}${timeOffset.pattern}');

final rfc3339 = RegExp('^${fullDate.pattern}[ tT]${fullTime.pattern}\$');

bool $isRFC3339(String str) {
  return rfc3339.hasMatch(str);
}
