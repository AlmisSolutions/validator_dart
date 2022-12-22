import 'package:validator_dart/src/util/assert_string.dart';

class ByteLengthOptions {
  final int min;
  final int? max;

  ByteLengthOptions({
    this.min = 0,
    this.max,
  });
}

bool $isByteLength(String str, {ByteLengthOptions? options}) {
  assertString(str);

  options ??= ByteLengthOptions();

  final encoded = Uri.encodeComponent(str);

  final len = encoded.split(RegExp(r'%..|.')).length - 1;
  return len >= options.min && (options.max == null || len <= options.max!);
}
