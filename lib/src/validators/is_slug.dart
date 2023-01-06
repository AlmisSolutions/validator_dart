final charsetRegex =
    RegExp(r'^[^\s-_](?!.*?[-_]{2,})[a-z0-9-\\][^\s]*[^-_\s]$');

bool $isSlug(str) {
  return charsetRegex.hasMatch(str);
}
