final RegExp localeReg = RegExp(
    r'^[A-Za-z]{2,4}([_-]([A-Za-z]{4}|[\d]{3}))?([_-]([A-Za-z]{2}|[\d]{3}))?$');

bool $isLocale(String str) {
  if (str == 'en_US_POSIX' || str == 'ca_ES_VALENCIA') {
    return true;
  }
  return localeReg.hasMatch(str);
}
