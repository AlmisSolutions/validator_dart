bool $toBoolean(String str, bool? strict) {
  if (strict ?? false) {
    return str == '1' || RegExp(r'^true$', caseSensitive: false).hasMatch(str);
  }
  return str != '0' &&
      !RegExp(r'^false$', caseSensitive: false).hasMatch(str) &&
      str != '';
}
