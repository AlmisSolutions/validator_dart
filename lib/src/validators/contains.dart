class ContainsOptions {
  final bool ignoreCase;
  final int minOccurrences;

  const ContainsOptions({
    this.ignoreCase = false,
    this.minOccurrences = 1,
  });
}

bool $contains(String str, String elem, {ContainsOptions? options}) {
  options ??= ContainsOptions();

  if (options.ignoreCase) {
    return str.toLowerCase().split(elem.toLowerCase()).length >
        options.minOccurrences;
  }

  return str.split(elem).length > options.minOccurrences;
}
