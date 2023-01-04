class BooleanOptions {
  final bool loose;

  BooleanOptions({
    this.loose = false,
  });
}

const strictBooleans = ['true', 'false', '1', '0'];
const looseBooleans = [...strictBooleans, 'yes', 'no'];

bool $isBoolean(String str, {BooleanOptions? options}) {
  options ??= BooleanOptions();

  if (options.loose) {
    return looseBooleans.contains(str.toLowerCase());
  }

  return strictBooleans.contains(str);
}
