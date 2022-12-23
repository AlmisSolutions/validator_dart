final RegExp rgbColor = RegExp(
    r"^rgb\((([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5]),){2}([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\)$");
final RegExp rgbaColor = RegExp(
    r"^rgba\((([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5]),){3}(0?\.\d|1(\.0)?|0(\.0)?)\)$");
final RegExp rgbColorPercent = RegExp(
    r"^rgb\((([0-9]%|[1-9][0-9]%|100%),){2}([0-9]%|[1-9][0-9]%|100%)\)$");
final RegExp rgbaColorPercent = RegExp(
    r"^rgba\((([0-9]%|[1-9][0-9]%|100%),){3}(0?\.\d|1(\.0)?|0(\.0)?)\)$");

bool $isRgbColor(String str, {bool includePercentValues = true}) {
  if (!includePercentValues) {
    return rgbColor.hasMatch(str) || rgbaColor.hasMatch(str);
  }

  return rgbColor.hasMatch(str) ||
      rgbaColor.hasMatch(str) ||
      rgbColorPercent.hasMatch(str) ||
      rgbaColorPercent.hasMatch(str);
}
