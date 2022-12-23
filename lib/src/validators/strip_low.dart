import 'package:validator_dart/src/validators/blacklist.dart';

String $stripLow(String str, {bool? keepNewLines = false}) {
  final chars = (keepNewLines ?? false)
      ? r'\x00-\x09\x0B\x0C\x0E-\x1F\x7F'
      : r'\x00-\x1F\x7F';
  return $blacklist(str, chars);
}
