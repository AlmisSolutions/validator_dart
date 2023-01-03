final surrogatePair = RegExp(r'[\uD800-\uDBFF][\uDC00-\uDFFF]');

bool $isSurrogatePair(String str) {
  return surrogatePair.hasMatch(str);
}
