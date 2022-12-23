int? $toInt(String str, {int? radix = 10}) {
  var intNum = int.tryParse(str.trim(), radix: radix);

  if (intNum == null) {
    var doubleNum = double.tryParse((str).trim());

    if (doubleNum != null) {
      intNum = doubleNum.toInt();

      intNum = int.tryParse(intNum.toString(), radix: radix);
    }
  }

  return intNum;
}
