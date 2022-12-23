final RegExp notBase64 = RegExp(r'[^A-Z0-9+\/=]', caseSensitive: false);
final RegExp urlSafeBase64 = RegExp(r'^[A-Z0-9_\-]*$', caseSensitive: false);

class Base64Options {
  bool urlSafe;

  Base64Options({this.urlSafe = false});
}

final Base64Options defaultBase64Options = Base64Options(urlSafe: false);

bool $isBase64(String str, {Base64Options? options}) {
  options ??= Base64Options();
  final int len = str.length;

  if (options.urlSafe) {
    return urlSafeBase64.hasMatch(str);
  }

  if (len % 4 != 0 || notBase64.hasMatch(str)) {
    return false;
  }

  final int firstPaddingChar = str.indexOf('=');
  return firstPaddingChar == -1 ||
      firstPaddingChar == len - 1 ||
      (firstPaddingChar == len - 2 && str[len - 1] == '=');
}
