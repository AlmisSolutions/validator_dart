class MACAddressOptions {
  final String? eui;
  final bool noSeparators;

  MACAddressOptions({
    this.eui,
    this.noSeparators = false,
  });
}

final macAddress48 = RegExp(
    r'^(?:[0-9a-fA-F]{2}([-:\s]))([0-9a-fA-F]{2}\1){4}([0-9a-fA-F]{2})$');
final macAddress48NoSeparators = RegExp(r'^([0-9a-fA-F]){12}$');
final macAddress48WithDots = RegExp(r'^([0-9a-fA-F]{4}\.){2}([0-9a-fA-F]{4})$');
final macAddress64 = RegExp(
    r'^(?:[0-9a-fA-F]{2}([-:\s]))([0-9a-fA-F]{2}\1){6}([0-9a-fA-F]{2})$');
final macAddress64NoSeparators = RegExp(r'^([0-9a-fA-F]){16}$');
final macAddress64WithDots = RegExp(r'^([0-9a-fA-F]{4}\.){3}([0-9a-fA-F]{4})$');

bool $isMACAddress(String str, {MACAddressOptions? options}) {
  options ??= MACAddressOptions();

  if (options.noSeparators) {
    if (options.eui == '48') {
      return macAddress48NoSeparators.hasMatch(str);
    }
    if (options.eui == '64') {
      return macAddress64NoSeparators.hasMatch(str);
    }
    return macAddress48NoSeparators.hasMatch(str) ||
        macAddress64NoSeparators.hasMatch(str);
  }
  if (options.eui == '48') {
    return macAddress48.hasMatch(str) || macAddress48WithDots.hasMatch(str);
  }
  if (options.eui == '64') {
    return macAddress64.hasMatch(str) || macAddress64WithDots.hasMatch(str);
  }
  return $isMACAddress(str, options: MACAddressOptions(eui: '48')) ||
      $isMACAddress(str, options: MACAddressOptions(eui: '64'));
}
