bool $isWhitelisted(String str, String chars) {
  for (var i = str.length - 1; i >= 0; i--) {
    if (!chars.contains(str[i])) {
      return false;
    }
  }
  return true;
}
