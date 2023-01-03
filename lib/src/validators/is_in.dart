import 'package:validator_dart/src/util/to_string.dart';

bool $isIn(String str, dynamic options) {
  if (options is List) {
    List array = [];
    for (var i = 0; i < options.length; i++) {
      var value = options.elementAt(i);

      if (value is Map) {
        array.addAll(value.keys);
      } else {
        array.add($toString(value));
      }
    }
    return array.contains(str);
  } else if (options is String) {
    return options.contains(str);
  } else if (options is Map) {
    return options.containsKey(str);
  } else if (options is Iterable) {
    return options.contains(str);
  } else if (options is Function) {
    return options.toString().contains(str);
  }
  return false;
}
