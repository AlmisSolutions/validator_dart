class CurrencyOptions {
  final String symbol;
  final bool requireSymbol;
  final bool allowSpaceAfterSymbol;
  final bool symbolAfterDigits;
  final bool allowNegatives;
  final bool parensForNegatives;
  final bool negativeSignBeforeDigits;
  final bool negativeSignAfterDigits;
  final bool allowNegativeSignPlaceholder;
  final String thousandsSeparator;
  final String decimalSeparator;
  final bool allowDecimal;
  final bool requireDecimal;
  final List<int> digitsAfterDecimal;
  final bool allowSpaceAfterDigits;

  const CurrencyOptions({
    this.symbol = '\$',
    this.requireSymbol = false,
    this.allowSpaceAfterSymbol = false,
    this.symbolAfterDigits = false,
    this.allowNegatives = true,
    this.parensForNegatives = false,
    this.negativeSignBeforeDigits = false,
    this.negativeSignAfterDigits = false,
    this.allowNegativeSignPlaceholder = false,
    this.thousandsSeparator = ',',
    this.decimalSeparator = '.',
    this.allowDecimal = true,
    this.requireDecimal = false,
    this.digitsAfterDecimal = const [2],
    this.allowSpaceAfterDigits = false,
  });
}

RegExp currencyRegex(CurrencyOptions options) {
  var decimalDigits = '\\d{${options.digitsAfterDecimal[0]}}';
  options.digitsAfterDecimal.asMap().forEach((index, digit) {
    if (index != 0) decimalDigits = '$decimalDigits|\\d{$digit}';
  });

  final symbol =
      '(${options.symbol.replaceAllMapped(RegExp(r'\W'), (m) => '\\${m.group(0)!}')})${(options.requireSymbol ? '' : '?')}';
  final negative = '-?';
  final wholeDollarAmountWithoutSep = '[1-9]\\d*';
  final wholeDollarAmountWithSep =
      '[1-9]\\d{0,2}(\\${options.thousandsSeparator}\\d{3})*';
  final validWholeDollarAmounts = [
    '0',
    wholeDollarAmountWithoutSep,
    wholeDollarAmountWithSep
  ];
  final wholeDollarAmount = '(${validWholeDollarAmounts.join('|')})?';
  final decimalAmount =
      '(\\${options.decimalSeparator}($decimalDigits))${options.requireDecimal ? '' : '?'}';
  String pattern = wholeDollarAmount +
      (options.allowDecimal || options.requireDecimal ? decimalAmount : '');

  if (options.allowNegatives && !options.parensForNegatives) {
    if (options.negativeSignAfterDigits) {
      pattern += negative;
    } else if (options.negativeSignBeforeDigits) {
      pattern = negative + pattern;
    }
  }

  if (options.allowNegativeSignPlaceholder) {
    pattern = '( (?!\\-))?$pattern';
  } else if (options.allowSpaceAfterSymbol) {
    pattern = ' ?$pattern';
  } else if (options.allowSpaceAfterDigits) {
    pattern += '( (?!\$))?';
  }

  if (options.symbolAfterDigits) {
    pattern += symbol;
  } else {
    pattern = symbol + pattern;
  }

  if (options.allowNegatives) {
    if (options.parensForNegatives) {
      pattern = "(\\($pattern\\)|$pattern)";
    } else if (!(options.negativeSignBeforeDigits ||
        options.negativeSignAfterDigits)) {
      pattern = "$negative$pattern";
    }
  }

  // ensure there's a dollar and/or decimal amount, and that
  // it doesn't start with a space or a negative sign followed by a space
  return RegExp("^(?!-? )(?=.*\\d)$pattern\$");
}

bool $isCurrency(String str, {CurrencyOptions? options}) {
  options ??= CurrencyOptions();

  return currencyRegex(options).hasMatch(str);
}
