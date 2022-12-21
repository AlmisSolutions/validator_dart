void assertString(dynamic input) {
  bool isString = input is String;

  if (!isString) {
    String invalidType = input.runtimeType.toString();
    if (input == null) invalidType = 'null';

    throw Error.safeToString('Expected a string but received a $invalidType');
  }
}
