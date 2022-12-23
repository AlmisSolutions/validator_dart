import 'package:validator_dart/src/validators/alpha.dart';

class DecimalOptions {
  final String locale;
  final bool forceDecimals;
  final String decimalDigits;

  DecimalOptions({
    this.forceDecimals = false,
    this.decimalDigits = '1,',
    this.locale = 'en-US',
  });
}

final decimal = Alpha().decimal;

/// Returns a RegExp for matching decimals in the given [options].
RegExp decimalRegExp(DecimalOptions options) {
  final regExp = RegExp(
      '^[-+]?([0-9]+)?(\\${decimal[options.locale]}[0-9]{${options.decimalDigits}})${options.forceDecimals ? "" : "?"}\$');
  return regExp;
}

const List<String> blacklist = ['', '-', '+'];

/// Returns true if [str] is a decimal.
bool $isDecimal(String str, {DecimalOptions? options}) {
  options ??= DecimalOptions();

  if (decimal.containsKey(options.locale)) {
    var result = !blacklist.contains(str.replaceAll(' ', '')) &&
        decimalRegExp(options).hasMatch(str);

    if (!result) {
      return result;
    }
    return result;
  }
  throw Exception('Invalid locale ${options.locale}');
}
