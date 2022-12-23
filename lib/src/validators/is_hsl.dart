final RegExp hslComma = RegExp(
    r'^hsla?\(((\+|\-)?([0-9]+(\.[0-9]+)?(e(\+|\-)?[0-9]+)?|\.[0-9]+(e(\+|\-)?[0-9]+)?))(deg|grad|rad|turn)?(,(\+|\-)?([0-9]+(\.[0-9]+)?(e(\+|\-)?[0-9]+)?|\.[0-9]+(e(\+|\-)?[0-9]+)?)%){2}(,((\+|\-)?([0-9]+(\.[0-9]+)?(e(\+|\-)?[0-9]+)?|\.[0-9]+(e(\+|\-)?[0-9]+)?)%?))?\)$',
    caseSensitive: false);
final RegExp hslSpace = RegExp(
    r'^hsla?\(((\+|\-)?([0-9]+(\.[0-9]+)?(e(\+|\-)?[0-9]+)?|\.[0-9]+(e(\+|\-)?[0-9]+)?))(deg|grad|rad|turn)?(\s(\+|\-)?([0-9]+(\.[0-9]+)?(e(\+|\-)?[0-9]+)?|\.[0-9]+(e(\+|\-)?[0-9]+)?)%){2}\s?(\/\s((\+|\-)?([0-9]+(\.[0-9]+)?(e(\+|\-)?[0-9]+)?|\.[0-9]+(e(\+|\-)?[0-9]+)?)%?)\s?)?\)$',
    caseSensitive: false);

bool $isHSL(String str) {
  final strippedStr = str.replaceAll(RegExp(r'\s+'), ' ').replaceAllMapped(
      RegExp(r'\s?(hsla?\(|\)|,)\s?', caseSensitive: false),
      (match) => match.group(1)!);

  if (strippedStr.contains(',')) {
    return hslComma.hasMatch(strippedStr);
  }

  return hslSpace.hasMatch(strippedStr);
}
