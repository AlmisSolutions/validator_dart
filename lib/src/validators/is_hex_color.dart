final RegExp hexcolor = RegExp(
    r'^#?([0-9A-F]{3}|[0-9A-F]{4}|[0-9A-F]{6}|[0-9A-F]{8})$',
    caseSensitive: false);

bool $isHexColor(String str) {
  return hexcolor.hasMatch(str);
}
