import 'package:validator_dart/src/validators/alpha.dart';

class NumericOptions {
  final bool noSymbols;
  final String locale;

  NumericOptions({
    this.noSymbols = false,
    this.locale = '.',
  });
}

final numericNoSymbols = RegExp(r'^[0-9]+$');
final decimal = Alpha().decimal;

bool $isNumeric(String str, {NumericOptions? options}) {
  options ??= NumericOptions();

  if (options.noSymbols) {
    return numericNoSymbols.hasMatch(str);
  }
  return RegExp(
          '^[+-]?([0-9]*[${(options.locale == '.') ? options.locale : decimal[options.locale]}])?[0-9]+\$')
      .hasMatch(str);
}
