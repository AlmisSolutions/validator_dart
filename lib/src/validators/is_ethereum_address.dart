final eth = RegExp(r'^(0x)[0-9a-f]{40}$', caseSensitive: false);

bool $isEthereumAddress(String str) {
  return eth.hasMatch(str);
}
