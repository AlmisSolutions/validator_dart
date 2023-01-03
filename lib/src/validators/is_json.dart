import 'dart:convert';

class JSONOptions {
  final bool allowPrimitives;
  JSONOptions({this.allowPrimitives = false});
}

bool $isJSON(String str, {JSONOptions? options}) {
  try {
    options ??= JSONOptions();
    List<dynamic> primitives = [];
    if (options.allowPrimitives) {
      primitives = [null, false, true];
    }

    dynamic obj = jsonDecode(str);
    return primitives.contains(obj) || (obj != null && obj is Map);
  } catch (_) {
    return false;
  }
}
