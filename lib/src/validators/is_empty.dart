class EmptyOptions {
  final bool ignoreWhitespace;

  EmptyOptions({this.ignoreWhitespace = false});
}

bool $isEmpty(dynamic str, {EmptyOptions? options}) {
  options ??= EmptyOptions();

  return options.ignoreWhitespace ? str.trim().isEmpty : str.isEmpty;
}
