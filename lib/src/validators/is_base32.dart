final base32 = RegExp(r'^[A-Z2-7]+=*$');
final crockfordBase32 = RegExp(r'^[A-HJKMNP-TV-Z0-9]+$');

class Base32Options {
  final bool crockford;

  Base32Options({this.crockford = false});
}

bool $isBase32(String str, {Base32Options? options}) {
  options ??= Base32Options();

  if (options.crockford) {
    return crockfordBase32.hasMatch(str);
  }

  final len = str.length;
  if (len % 8 == 0 && base32.hasMatch(str)) {
    return true;
  }
  return false;
}
