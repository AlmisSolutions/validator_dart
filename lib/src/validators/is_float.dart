import 'package:validator_dart/extensions/string_extensions.dart';
import 'package:validator_dart/src/validators/alpha.dart';

class FloatOptions {
  final bool allowLeadingZeroes;
  final double? min;
  final double? max;
  final double? lt;
  final double? gt;
  final String? locale;

  FloatOptions({
    this.allowLeadingZeroes = true,
    this.min,
    this.max,
    this.lt,
    this.gt,
    this.locale,
  });
}

final decimal = Alpha().decimal;

/// Returns true if [str] is a float.
bool $isFloat(String str, {FloatOptions? options}) {
  options ??= FloatOptions();

  final float = RegExp(
      '^(?:[-+])?(?:[0-9]+)?(?:\\${!options.locale.isNullOrEmpty ? decimal[options.locale] : "."}[0-9]*)?(?:[eE][\\+\\-]?(?:[0-9]+))?\$');
  if (str.isNullOrEmpty || str == '.' || str == '-' || str == '+') {
    return false;
  }
  final value = double.tryParse(str.replaceAll(',', '.').replaceAll('٫', '.'));

  if (value == null) {
    return false;
  }

  return float.hasMatch(str) &&
      (options.min == null || value >= options.min!) &&
      (options.max == null || value <= options.max!) &&
      (options.lt == null || value < options.lt!) &&
      (options.gt == null || value > options.gt!);
}
