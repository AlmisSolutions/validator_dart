double $toFloat(dynamic str) {
  var num = double.tryParse(str);

  if (num == null) {
    return double.nan;
  }

  return num;
}
