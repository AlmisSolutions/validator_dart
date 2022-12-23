String $blacklist(String str, String chars) {
  return str.replaceAll(RegExp('[$chars+]', multiLine: true), '');
}
