final halfWidth =
    RegExp(r'[\u0020-\u007E\uFF61-\uFF9F\uFFA0-\uFFDC\uFFE8-\uFFEE0-9a-zA-Z]');

bool $isHalfWidth(String str) {
  return halfWidth.hasMatch(str);
}
