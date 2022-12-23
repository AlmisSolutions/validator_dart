final RegExp hexadecimal = RegExp(r'^(0x|0h)?[0-9A-F]+$', caseSensitive: false);

bool $isHexadecimal(String str) {
  return hexadecimal.hasMatch(str);
}
