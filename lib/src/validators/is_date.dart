import 'dart:math' as math;
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

class DateOptions {
  final String format;
  final List<String> delimiters;
  final bool strictMode;

  DateOptions({
    this.format = 'YYYY/MM/DD',
    this.delimiters = const ['/', '-'],
    this.strictMode = false,
  });
}

bool isValidFormat(String format) {
  return RegExp(
          r'(^(y{4}|y{2})[.\/-](m{1,2})[.\/-](d{1,2})$)|(^(m{1,2})[.\/-](d{1,2})[.\/-]((y{4}|y{2})$))|(^(d{1,2})[.\/-](m{1,2})[.\/-]((y{4}|y{2})$))',
          caseSensitive: false)
      .hasMatch(format);
}

Map<String, String> zip(List<String> date, List<String> format) {
  final zippedArr = <String, String>{};
  final len = math.min(date.length, format.length);
  for (int i = 0; i < len; i++) {
    zippedArr[format[i]] = date[i];
  }
  return zippedArr;
}

bool $isDate(dynamic input, {DateOptions? options}) {
  options ??= DateOptions();

  if (input is String && isValidFormat(options.format)) {
    final formatDelimiter = options.delimiters
        .firstWhereOrNull((delimiter) => options!.format.contains(delimiter));

    if (formatDelimiter == null) {
      return false;
    }

    final dateDelimiter = options.strictMode
        ? formatDelimiter
        : options.delimiters
            .firstWhereOrNull((delimiter) => input.contains(delimiter));

    if (dateDelimiter == null) {
      return false;
    }

    final dateAndFormat = zip(
      input.split(dateDelimiter),
      options.format.toLowerCase().split(formatDelimiter),
    );
    final dateObj = <String, String>{};

    for (final entry in dateAndFormat.entries) {
      var formatWord = entry.key;
      var dateWord = entry.value;

      if (dateWord.length != formatWord.length) {
        return false;
      }
      dateObj[formatWord[0]] = dateWord;
    }

    var date = DateTime(int.parse(dateObj['y']!), int.parse(dateObj['m']!),
        int.parse(dateObj['d']!));

    return date.month == int.parse(dateObj['m']!) &&
        date.day == int.parse(dateObj['d']!);
  }

  if (!options.strictMode) {
    return input is DateTime && input.millisecondsSinceEpoch.isFinite;
  }

  return false;
}
