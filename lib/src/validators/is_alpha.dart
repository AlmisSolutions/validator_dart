import 'package:validator_dart/src/validators/alpha.dart';

class AlphaOptions {
  final dynamic ignore;

  AlphaOptions({
    this.ignore,
  });
}

final alpha = $alpha();

bool $isAlpha(String str, {String locale = 'en-US', AlphaOptions? options}) {
  options ??= AlphaOptions();
  String s = str;
  final ignore = options.ignore;

  if (ignore != null) {
    if (ignore is RegExp) {
      s = s.replaceAll(ignore, '');
    } else if (ignore is String) {
      s = s.replaceAll(
          RegExp(
              '[${ignore.replaceAllMapped(r'[-[\]{}()*+?.,\\^$|#\\s]', ((match) => match.group(0)!))}]'),
          ''); // escape regex for ignore
    } else {
      throw Exception('ignore should be instance of a String or RegExp');
    }
  }

  if (alpha.containsKey(locale)) {
    return alpha[locale]?.hasMatch(s) ?? false;
  }
  throw Exception('Invalid locale "$locale"');
}
