String $escape(String str) {
  return (str
      .replaceAll('&', '&amp;')
      .replaceAll('"', '&quot;')
      .replaceAll("'", '&#x27;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;')
      .replaceAll('/', '&#x2F;')
      .replaceAll('\\', '&#x5C;')
      .replaceAll('`', '&#96;'));
}
