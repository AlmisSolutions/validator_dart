final RegExp isrc = RegExp(r"^[A-Z]{2}[0-9A-Z]{3}\d{2}\d{5}$");

bool $isISRC(String str) {
  return isrc.hasMatch(str);
}
