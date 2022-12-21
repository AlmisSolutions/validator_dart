import 'package:validator_dart/src/util/assert_string.dart';

String $escape(dynamic str) {
  assertString(str);
  return (str
      .replaceAll('&', '&amp;')
      .replaceAll('"', '&quot;')
      .replaceAll("'", '&#x27;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;')
      .replaceAll('/', '&#x2F;')
      .replaceAll('\\', '&#x5C;')
      .replaceAll('`', '&#96;'));
}
