String $whitelist(String str, String chars) {
  return str.replaceAll(RegExp('[^$chars]+', multiLine: true), '');
}
