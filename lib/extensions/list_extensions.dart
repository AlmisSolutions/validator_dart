extension ListExtensions on List {
  dynamic get(index) {
    return length > index ? this[index] : null;
  }
}
