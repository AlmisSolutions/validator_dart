final Map<dynamic, RegExp> uuid = {
  1: RegExp(r'^[0-9A-F]{8}-[0-9A-F]{4}-1[0-9A-F]{3}-[0-9A-F]{4}-[0-9A-F]{12}$',
      caseSensitive: false),
  2: RegExp(r'^[0-9A-F]{8}-[0-9A-F]{4}-2[0-9A-F]{3}-[0-9A-F]{4}-[0-9A-F]{12}$',
      caseSensitive: false),
  3: RegExp(r'^[0-9A-F]{8}-[0-9A-F]{4}-3[0-9A-F]{3}-[0-9A-F]{4}-[0-9A-F]{12}$',
      caseSensitive: false),
  4: RegExp(
      r'^[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$',
      caseSensitive: false),
  5: RegExp(
      r'^[0-9A-F]{8}-[0-9A-F]{4}-5[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$',
      caseSensitive: false),
  'all': RegExp(
      r'^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}$',
      caseSensitive: false),
};

bool $isUUID(String str, {int? version}) {
  final pattern = uuid[version ?? 'all'];
  return pattern != null && pattern.hasMatch(str);
}
