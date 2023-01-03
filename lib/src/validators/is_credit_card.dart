import 'package:validator_dart/src/validators/is_luhn_valid.dart';

class CreditCardOptions {
  final String? provider;

  CreditCardOptions({
    this.provider,
  });
}

final cards = {
  'amex': RegExp(r'^3[47][0-9]{13}$'),
  'dinersclub': RegExp(r'^3(?:0[0-5]|[68][0-9])[0-9]{11}$'),
  'discover': RegExp(r'^6(?:011|5[0-9][0-9])[0-9]{12,15}$'),
  'jcb': RegExp(r'^(?:2131|1800|35\d{3})\d{11}$'),
  'mastercard': RegExp(
      r'^5[1-5][0-9]{2}|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720)[0-9]{12}$'),
  'unionpay': RegExp(r'^(6[27][0-9]{14}|^(81[0-9]{14,17}))$'),
  'visa': RegExp(r'^(?:4[0-9]{12})(?:[0-9]{3,6})?$'),
};

final allCards = RegExp(
    r'^(?:4[0-9]{12}(?:[0-9]{3,6})?|5[1-5][0-9]{14}|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720)[0-9]{12}|6(?:011|5[0-9][0-9])[0-9]{12,15}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11}|6[27][0-9]{14}|^(81[0-9]{14,17}))$');

bool $isCreditCard(String card, {CreditCardOptions? options}) {
  options ??= CreditCardOptions();

  final sanitized = card.replaceAll(RegExp(r'[- ]+'), '');
  if (options.provider != null &&
      cards.containsKey(options.provider?.toLowerCase())) {
    // specific provider in the list
    if (!(cards[options.provider?.toLowerCase()]?.hasMatch(sanitized) ??
        false)) {
      return false;
    }
  } else if (options.provider != null &&
      !cards.containsKey(options.provider?.toLowerCase())) {
    /* specific provider not in the list */
    throw Exception('${options.provider} is not a valid credit card provider.');
  } else if (!allCards.hasMatch(sanitized)) {
    // no specific provider
    return false;
  }
  return $isLuhnValid(card);
}
