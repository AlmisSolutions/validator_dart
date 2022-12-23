final RegExp octal = RegExp(r'^(0o)?[0-7]+$', caseSensitive: false);

bool $isOctal(String str) {
  return octal.hasMatch(str);
}
