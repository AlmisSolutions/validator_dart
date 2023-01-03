final ascii = RegExp(r'^[\x00-\x7F]+$');

bool $isAscii(String str) {
  return ascii.hasMatch(str);
}
