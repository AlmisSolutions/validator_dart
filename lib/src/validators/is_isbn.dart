final isbn10Maybe = RegExp(r'^(?:[0-9]{9}X|[0-9]{10})$');
final isbn13Maybe = RegExp(r'^(?:[0-9]{13})$');
const factor = [1, 3];

bool $isISBN(String str, dynamic version) {
  if (version is int) {
    version = version.toString();
  }

  if (version == null) {
    return $isISBN(str, '10') || $isISBN(str, '13');
  }
  final sanitized = str.replaceAll(RegExp(r'[\s-]+'), '');
  int checksum = 0;
  int i;
  if (version == '10') {
    if (!isbn10Maybe.hasMatch(sanitized)) {
      return false;
    }
    for (i = 0; i < 9; i++) {
      checksum += (i + 1) * int.parse(sanitized[i]);
    }
    if (sanitized[9] == 'X') {
      checksum += 10 * 10;
    } else {
      checksum += 10 * int.parse(sanitized[9]);
    }
    if ((checksum % 11) == 0) {
      return sanitized.isNotEmpty;
    }
  } else if (version == '13') {
    if (!isbn13Maybe.hasMatch(sanitized)) {
      return false;
    }
    for (i = 0; i < 12; i++) {
      checksum += factor[i % 2] * int.parse(sanitized[i]);
    }
    if (int.parse(sanitized[12]) - ((10 - (checksum % 10)) % 10) == 0) {
      return sanitized.isNotEmpty;
    }
  }
  return false;
}
