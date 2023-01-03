final multibyte = RegExp(r'[^\x00-\x7F]');

bool $isMultibyte(String str) {
  return multibyte.hasMatch(str);
}
