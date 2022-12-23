String $unescape(String str) {
  return (str
      .replaceAll('&quot;', '"')
      .replaceAll('&#x27;', "'")
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .replaceAll('&#x2F;', '/')
      .replaceAll('&#x5C;', '\\')
      .replaceAll('&#96;', '`')
      .replaceAll('&amp;', '&'));
  // &amp; replacement has to be the last one to prevent
  // bugs with intermediate strings containing escape sequences
  // See: https://github.com/validatorjs/validator.js/issues/1827
}
