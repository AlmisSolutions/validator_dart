final RegExp md5 = RegExp(r"^[a-f0-9]{32}$");

bool $isMD5(String str) {
  return md5.hasMatch(str);
}
