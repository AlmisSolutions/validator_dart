import 'package:validator_dart/src/util/assert_string.dart';

final upperCaseRegex = RegExp(r'^[A-Z]$');
final lowerCaseRegex = RegExp(r'^[a-z]$');
final numberRegex = RegExp(r'^[0-9]$');
final symbolRegex = RegExp(r'''^[-#!$@%^&*()_+|~=`{}\[\]:";\'<>?,.\/ ]$''');

class PasswordOptions {
  final int minLength;
  final int minLowercase;
  final int minUppercase;
  final int minNumbers;
  final int minSymbols;
  final bool returnScore;
  final double pointsPerUnique;
  final double pointsPerRepeat;
  final int pointsForContainingLower;
  final int pointsForContainingUpper;
  final int pointsForContainingNumber;
  final int pointsForContainingSymbol;

  const PasswordOptions({
    this.minLength = 8,
    this.minLowercase = 1,
    this.minUppercase = 1,
    this.minNumbers = 1,
    this.minSymbols = 1,
    this.returnScore = false,
    this.pointsPerUnique = 1.0,
    this.pointsPerRepeat = 0.5,
    this.pointsForContainingLower = 10,
    this.pointsForContainingUpper = 10,
    this.pointsForContainingNumber = 10,
    this.pointsForContainingSymbol = 10,
  });
}

class Analysis {
  final int length;
  final int uniqueChars;
  int uppercaseCount = 0;
  int lowercaseCount = 0;
  int numberCount = 0;
  int symbolCount = 0;

  Analysis(this.length, this.uniqueChars);
}

/* Counts number of occurrences of each char in a string
 * could be moved to util/ ?
*/
Map<String, int> countChars(String str) {
  final result = <String, int>{};
  for (var rune in str.runes) {
    final char = String.fromCharCode(rune);
    result.putIfAbsent(char, () => 1);
    result[char] = result[char]! + 1;
  }
  return result;
}

/* Return information about a password */
Analysis analyzePassword(String password) {
  final charMap = countChars(password);
  final analysis = Analysis(password.length, charMap.keys.length);

  for (var char in charMap.keys) {
    if (upperCaseRegex.hasMatch(char)) {
      analysis.uppercaseCount += charMap[char]!;
    } else if (lowerCaseRegex.hasMatch(char)) {
      analysis.lowercaseCount += charMap[char]!;
    } else if (numberRegex.hasMatch(char)) {
      analysis.numberCount += charMap[char]!;
    } else if (symbolRegex.hasMatch(char)) {
      analysis.symbolCount += charMap[char]!;
    }
  }
  return analysis;
}

double scorePassword(Analysis analysis, PasswordOptions scoringOptions) {
  double points = 0;
  points += analysis.uniqueChars * scoringOptions.pointsPerUnique;
  points +=
      (analysis.length - analysis.uniqueChars) * scoringOptions.pointsPerRepeat;
  if (analysis.lowercaseCount > 0) {
    points += scoringOptions.pointsForContainingLower;
  }
  if (analysis.uppercaseCount > 0) {
    points += scoringOptions.pointsForContainingUpper;
  }
  if (analysis.numberCount > 0) {
    points += scoringOptions.pointsForContainingNumber;
  }
  if (analysis.symbolCount > 0) {
    points += scoringOptions.pointsForContainingSymbol;
  }
  return points;
}

dynamic $isStrongPassword(dynamic str, {PasswordOptions? options}) {
  assertString(str);
  var analysis = analyzePassword(str);
  options = options ?? PasswordOptions();
  if (options.returnScore) {
    return scorePassword(analysis, options);
  }
  return analysis.length >= options.minLength &&
      analysis.lowercaseCount >= options.minLowercase &&
      analysis.uppercaseCount >= options.minUppercase &&
      analysis.numberCount >= options.minNumbers &&
      analysis.symbolCount >= options.minSymbols;
}
