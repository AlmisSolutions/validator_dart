extension ListExtensions<T> on List<T> {
  T? get(index) {
    return length > index ? this[index] : null;
  }
}
