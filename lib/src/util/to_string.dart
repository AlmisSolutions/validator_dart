String $toString(dynamic input) {
  if (input is String) {
    input = input.toString();
  } else if (input == null ||
      input is num && input.isNaN ||
      input is Function ||
      !input.isNotEmpty) {
    input = '';
  }
  return input.toString();
}
