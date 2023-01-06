import 'package:validator_dart/extensions/list_extensions.dart';
import 'package:validator_dart/extensions/string_extensions.dart';

class ISO8601Options {
  final bool strict;
  final bool strictSeparator;

  ISO8601Options({
    this.strict = false,
    this.strictSeparator = false,
  });
}

// from http://goo.gl/0ejHHW
final iso8601 = RegExp(
    r'^([\+-]?\d{4}(?!\d{2}\b))((-?)((0[1-9]|1[0-2])(\3([12]\d|0[1-9]|3[01]))?|W([0-4]\d|5[0-3])(-?[1-7])?|(00[1-9]|0[1-9]\d|[12]\d{2}|3([0-5]\d|6[1-6])))([T\s]((([01]\d|2[0-3])((:?)[0-5]\d)?|24:?00)([\.,]\d+(?!:))?)?(\17[0-5]\d([\.,]\d+)?)?([zZ]|([\+-])([01]\d|2[0-3]):?([0-5]\d)?)?)?)?$');
// same as above, except with a strict 'T' separator between date and time
final iso8601StrictSeparator = RegExp(
    r'^([\+-]?\d{4}(?!\d{2}\b))((-?)((0[1-9]|1[0-2])(\3([12]\d|0[1-9]|3[01]))?|W([0-4]\d|5[0-3])(-?[1-7])?|(00[1-9]|0[1-9]\d|[12]\d{2}|3([0-5]\d|6[1-6])))([T]((([01]\d|2[0-3])((:?)[0-5]\d)?|24:?00)([\.,]\d+(?!:))?)?(\17[0-5]\d([\.,]\d+)?)?([zZ]|([\+-])([01]\d|2[0-3]):?([0-5]\d)?)?)?)?$');

bool isValidDate(String str) {
  final ordinalMatch = RegExp(r'^(\d{4})-?(\d{3})([ T]{1}\.*|$)')
      .allMatches(str)
      .map((m) => List.generate(
          m.groupCount + 1, (index) => int.tryParse(m.group(index)!)))
      .expand((element) => element)
      .toList();
  if (ordinalMatch.isNotEmpty) {
    final oYear = ordinalMatch[1]!;
    final oDay = ordinalMatch[2]!;
    if ((oYear % 4 == 0 && oYear % 100 != 0) || oYear % 400 == 0) {
      return oDay <= 366;
    }
    return oDay <= 365;
  }
  final match = RegExp(r'(\d{4})-?(\d{0,2})-?(\d*)')
      .allMatches(str)
      .map((m) => List.generate(
          m.groupCount + 1, (index) => int.tryParse(m.group(index)!)))
      .expand((element) => element)
      .toList();
  final year = match.get(1);
  final month = match.get(2);
  final day = match.get(3);
  final monthString = month != null ? '0$month'.slice(-2) : month;
  final dayString = day != null ? '0$day'.slice(-2) : day;

  final d =
      DateTime.tryParse('$year-${monthString ?? '01'}-${dayString ?? '01'}');
  if (month != null && day != null) {
    return d!.year == year && d.month == month && d.day == day;
  }
  return true;
}

bool $isISO8601(String str, {ISO8601Options? options}) {
  options ??= ISO8601Options();

  final check = options.strictSeparator
      ? iso8601StrictSeparator.hasMatch(str)
      : iso8601.hasMatch(str);
  if (check && options.strict) {
    return isValidDate(str);
  }
  return check;
}
