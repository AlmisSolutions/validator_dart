import 'package:validator_dart/src/validators/alpha.dart';

class AlphaOptions {
  final dynamic ignore;

  AlphaOptions({
    this.ignore,
  });
}

final alpha = Alpha().alpha;

bool $isAlpha(String str, {String locale = 'en-US', AlphaOptions? options}) {
  options ??= AlphaOptions();
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

  if (alpha.containsKey(locale)) {
    return alpha[locale]?.hasMatch(str) ?? false;
  }
  throw Exception('Invalid locale "$locale"');
}
