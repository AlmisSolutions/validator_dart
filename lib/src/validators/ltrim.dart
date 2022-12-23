String $ltrim(String str, String? chars) {
  RegExp pattern;
  if (chars != null) {
    pattern = RegExp(
        '^[${chars.replaceAllMapped(RegExp(r'[.*+?^${}()|[\]\\]'), (match) => '\\${match.group(0)}')}]+');
  } else {
    pattern = RegExp(r'^\s+');
  }

  return str.replaceFirst(pattern, '');
}
