import 'package:validator_dart/src/validators/is_base64.dart';

bool $isJWT(String str) {
  final List<String> dotSplit = str.split('.');
  final int len = dotSplit.length;

  if (len > 3 || len < 2) {
    return false;
  }

  return dotSplit.fold(
      true,
      (bool acc, String currElem) =>
          acc && $isBase64(currElem, options: Base64Options(urlSafe: true)));
}
