import 'dart:collection';

final lat = RegExp(r'^\(?[+-]?(90(\.0+)?|[1-8]?\d(\.\d+)?)$');
final long =
    RegExp(r'^\s?[+-]?(180(\.0+)?|1[0-7]\d(\.\d+)?|\d{1,2}(\.\d+)?)\)?$');

final latDMS = RegExp(
    r'^(([1-8]?\d)\D+([1-5]?\d|60)\D+([1-5]?\d|60)(\.\d+)?|90\D+0\D+0)\D+[NSns]?$',
    caseSensitive: false);
final longDMS = RegExp(
    r'^\s*([1-7]?\d{1,2}\D+([1-5]?\d|60)\D+([1-5]?\d|60)(\.\d+)?|180\D+0\D+0)\D+[EWew]?$',
    caseSensitive: false);

class LatLongOptions {
  final bool checkDMS;

  LatLongOptions({
    this.checkDMS = false,
  });
}

bool $isLatLong(String str, {LatLongOptions? options}) {
  options ??= LatLongOptions();

  if (!str.contains(',')) return false;
  final pair = ListQueue.of(str.split(','));
  if ((pair.elementAt(0).startsWith('(') && !pair.elementAt(1).endsWith(')')) ||
      (pair.elementAt(1).endsWith(')') && !pair.elementAt(0).startsWith('('))) {
    return false;
  }

  if (options.checkDMS) {
    return latDMS.hasMatch(pair.elementAt(0)) &&
        longDMS.hasMatch(pair.elementAt(1));
  }
  return lat.hasMatch(pair.elementAt(0)) && long.hasMatch(pair.elementAt(1));
}
