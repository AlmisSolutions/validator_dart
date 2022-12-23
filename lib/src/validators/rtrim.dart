String $rtrim(String str, String? chars) {
  if (chars != null) {
    final pattern = RegExp(
        '[${chars.replaceAllMapped(RegExp(r'[.*+?^${}()|[\]\\]'), (match) => '\\${match.group(0)}')}]+\$');
    return str.replaceAll(pattern, '');
  }

  // Use a faster and more safe than regex trim method https://blog.stevenlevithan.com/archives/faster-trim-javascript
  int strIndex = str.length - 1;
  while (strIndex > -1 && RegExp(r'\s').hasMatch(str[strIndex])) {
    strIndex -= 1;
  }

  return str.substring(0, strIndex + 1);
}
