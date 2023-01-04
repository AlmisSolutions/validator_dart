import 'dart:collection';

final validMediaType =
    RegExp(r'^[a-z]+\/[a-z0-9\-\+\.]+$', caseSensitive: false);

final validAttribute = RegExp(r'^[a-z\-]+=[a-z0-9\-]+$', caseSensitive: false);

final validData = RegExp(r'''^[a-z0-9!\$&'\(\)\*\+,;=\-\._~:@\/\?%\s]*$''',
    caseSensitive: false);

bool $isDataURI(String str) {
  final data = ListQueue.of(str.split(','));
  if (data.length < 2) {
    return false;
  }
  final attributes = ListQueue.of(data.removeFirst().trim().split(';'));
  final schemeAndMediaType = attributes.removeFirst();
  if (schemeAndMediaType.substring(0, 5) != 'data:') {
    return false;
  }
  final mediaType = schemeAndMediaType.substring(5);
  if (mediaType != '' && !validMediaType.hasMatch(mediaType)) {
    return false;
  }
  for (var i = 0; i < attributes.length; i++) {
    final attribute = attributes.elementAt(i);
    if (!(i == attributes.length - 1 && attribute.toLowerCase() == 'base64') &&
        !validAttribute.hasMatch(attribute)) {
      return false;
    }
  }
  for (final d in data) {
    if (!validData.hasMatch(d)) {
      return false;
    }
  }
  return true;
}
