void main() {
  String ignore = '@_-+';
  String escaped = ignore.replaceAllMapped(
    RegExp(r'[\[\]{}()*+?.,\\^$|#\s]'),
    (match) => '\\${match.group(0)}',
  );

  print(escaped);
}
