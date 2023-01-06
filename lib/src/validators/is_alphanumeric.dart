import 'package:validator_dart/src/validators/alpha.dart';

class AlphanumericOptions {
  final dynamic ignore;

  AlphanumericOptions({
    this.ignore,
  });
}

final alphanumeric = Alpha().alphanumeric;

bool $isAlphanumeric(String str,
    {String? locale = 'en-US', AlphanumericOptions? options}) {
  options ??= AlphanumericOptions();
  final ignore = options.ignore;

  if (ignore != null) {
    if (ignore is RegExp) {
      str = str.replaceAll(ignore, '');
    } else if (ignore is String) {
      str = str.replaceAll(
          RegExp(
              '[${ignore.replaceAllMapped(RegExp(r'[-\[\]{}()*+?.,\\^$|#\s]'), (match) => '\\${match.group(0)}')}]'),
          ''); // escape regex for ignore
    } else {
      throw Exception('ignore should be instance of a String or RegExp');
    }
  }

  if (alphanumeric.containsKey(locale)) {
    return alphanumeric[locale]!.hasMatch(str);
  }
  throw Exception("Invalid locale '$locale'");
}
