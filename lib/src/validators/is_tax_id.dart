import 'dart:math' as math;
import 'package:validator_dart/src/util/algorithms.dart';
import 'package:validator_dart/src/validators/is_date.dart';

/*
 * TIN Validation
 * Validates Tax Identification Numbers (TINs) from the US, EU member states and the United Kingdom.
 *
 * EU-UK:
 * National TIN validity is calculated using public algorithms as made available by DG TAXUD.
 *
 * See `https://ec.europa.eu/taxation_customs/tin/specs/FS-TIN%20Algorithms-Public.docx` for more information.
 *
 * US:
 * An Employer Identification Number (EIN), also known as a Federal Tax Identification Number,
 *  is used to identify a business entity.
 *
 * NOTES:
 *  - Prefix 47 is being reserved for future use
 *  - Prefixes 26, 27, 45, 46 and 47 were previously assigned by the Philadelphia campus.
 *
 * See `http://www.irs.gov/Businesses/Small-Businesses-&-Self-Employed/How-EINs-are-Assigned-and-Valid-EIN-Prefixes`
 * for more information.
 */

// Locale functions

/*
 * bg-BG validation function
 * (Edinen graždanski nomer (EGN/ЕГН), persons only)
 * Checks if birth date (first six digits) is valid and calculates check (last) digit
 */
bool bgBgCheck(String tin) {
  // Extract full year, normalize month and check birth date validity
  String centuryYear = tin.substring(0, 2);
  int month = int.parse(tin.substring(2, 4));
  String monthStr = month.toString();
  if (month > 40) {
    month -= 40;
    centuryYear = '20$centuryYear';
  } else if (month > 20) {
    month -= 20;
    centuryYear = '18$centuryYear';
  } else {
    centuryYear = '19$centuryYear';
  }
  if (month < 10) {
    monthStr = '0$month';
  }
  final date = '$centuryYear/$monthStr/${tin.substring(4, 6)}';
  if (!$isDate(date, options: DateOptions(format: 'YYYY/MM/DD'))) {
    return false;
  }

  // split digits into an array for further processing
  final digits = tin.split('').map((a) => int.parse(a)).toList();

  // Calculate checksum by multiplying digits with fixed values
  final ipLookup = [2, 4, 8, 5, 10, 9, 7, 3, 6];
  int checksum = 0;
  for (int i = 0; i < ipLookup.length; i++) {
    checksum += digits[i] * ipLookup[i];
  }
  checksum = checksum % 11 == 10 ? 0 : checksum % 11;
  return checksum == digits[9];
}

/*
 * Check if an input is a valid Canadian SIN (Social Insurance Number)
 *
 * The Social Insurance Number (SIN) is a 9 digit number that
 * you need to work in Canada or to have access to government programs and benefits.
 *
 * https://en.wikipedia.org/wiki/Social_Insurance_Number
 * https://www.canada.ca/en/employment-social-development/services/sin.html
 * https://www.codercrunch.com/challenge/819302488/sin-validator
 *
 * @param {string} input
 * @return {boolean}
 */
bool isCanadianSIN(String input) {
  List<String> digitsArray = input.split('');
  List<String> even = digitsArray
      .asMap()
      .entries
      .where((a) => a.key % 2 > 0)
      .map((i) => int.parse(i.value) * 2)
      .join('')
      .split('');

  int total = digitsArray
      .asMap()
      .entries
      .where((a) => a.key % 2 == 0)
      .map((e) => e.value)
      .followedBy(even)
      .map((i) => int.parse(i))
      .reduce((acc, cur) => acc + cur);

  return (total % 10 == 0);
}

/*
 * cs-CZ validation function
 * (Rodné číslo (RČ), persons only)
 * Checks if birth date (first six digits) is valid and divisibility by 11
 * Material not in DG TAXUD document sourced from:
 * -`https://lorenc.info/3MA381/overeni-spravnosti-rodneho-cisla.htm`
 * -`https://www.mvcr.cz/clanek/rady-a-sluzby-dokumenty-rodne-cislo.aspx`
 */
bool csCzCheck(String tin) {
  tin = tin.replaceAll(RegExp(r'\W'), '');

  // Extract full year from TIN length
  int fullYear = int.parse(tin.substring(0, 2));
  if (tin.length == 10) {
    if (fullYear < 54) {
      fullYear = int.parse('20$fullYear');
    } else {
      fullYear = int.parse('19$fullYear');
    }
  } else {
    if (tin.substring(6) == '000') {
      return false;
    } // Three-zero serial not assigned before 1954
    if (fullYear < 54) {
      fullYear = int.parse('19$fullYear');
    } else {
      return false; // No 18XX years seen in any of the resources
    }
  }
  // Add missing zero if needed
  if (fullYear.toString().length == 3) {
    fullYear = int.parse(
        '${fullYear.toString().substring(0, 2)}0${fullYear.toString().substring(2)}');
  }

  // Extract month from TIN and normalize
  int month = int.parse(tin.substring(2, 4));
  if (month > 50) {
    month -= 50;
  }
  if (month > 20) {
    // Month-plus-twenty was only introduced in 2004
    if (int.parse(fullYear.toString()) < 2004) {
      return false;
    }
    month -= 20;
  }
  String monthStr = month < 10 ? '0$month' : month.toString();

  // Check date validity
  String date = '$fullYear/$monthStr/${tin.substring(4, 6)}';
  if (!$isDate(date, options: DateOptions(format: 'YYYY/MM/DD'))) {
    return false;
  }

  // Verify divisibility by 11
  if (tin.length == 10) {
    if (int.parse(tin) % 11 != 0) {
      // Some numbers up to and including 1985 are still valid if
      // check (last) digit equals 0 and modulo of first 9 digits equals 10
      int checkdigit = int.parse(tin.substring(0, 9)) % 11;
      if (int.parse(fullYear.toString()) < 1986 && checkdigit == 10) {
        if (int.parse(tin.substring(9)) != 0) {
          return false;
        }
      } else {
        return false;
      }
    }
  }
  return true;
}

/*
 * de-AT validation function
 * (Abgabenkontonummer, persons/entities)
 * Verify TIN validity by calling luhnCheck()
 */
bool deAtCheck(tin) {
  return Algorithms.luhnCheck(tin);
}

/*
 * de-DE validation function
 * (Steueridentifikationsnummer (Steuer-IdNr.), persons only)
 * Tests for single duplicate/triplicate value, then calculates ISO 7064 check (last) digit
 * Partial implementation of spec (same result with both algorithms always)
 */
bool deDeCheck(String tin) {
  // Split digits into an array for further processing
  List<int> digits = tin.split('').map((a) => int.parse(a)).toList();

  // Fill array with strings of number positions
  List<String> occurences = [];
  for (int i = 0; i < digits.length - 1; i++) {
    occurences.add('');
    for (int j = 0; j < digits.length - 1; j++) {
      if (digits[i] == digits[j]) {
        occurences[i] += j.toString();
      }
    }
  }

  // Remove digits with one occurence and test for only one duplicate/triplicate
  occurences = occurences.where((a) => a.length > 1).toList();
  if (occurences.length != 2 && occurences.length != 3) {
    return false;
  }

  // In case of triplicate value only two digits are allowed next to each other
  if (occurences[0].length == 3) {
    List<int> tripLocations =
        occurences[0].split('').map((a) => int.parse(a)).toList();
    int recurrent = 0; // Amount of neighbour occurences
    for (int i = 0; i < tripLocations.length - 1; i++) {
      if (tripLocations[i] + 1 == tripLocations[i + 1]) {
        recurrent += 1;
      }
    }
    if (recurrent == 2) {
      return false;
    }
  }
  return Algorithms.iso7064Check(tin);
}

/*
 * dk-DK validation function
 * (CPR-nummer (personnummer), persons only)
 * Checks if birth date (first six digits) is valid and assigned to century (seventh) digit,
 * and calculates check (last) digit
 */
bool dkDkCheck(String tin) {
  tin = tin.replaceAll(RegExp(r'\W'), '');

  // Extract year, check if valid for given century digit and add century
  int year = int.parse(tin.substring(4, 6));
  String yearStr = year.toString();
  String centuryDigit = tin.substring(6, 7);
  switch (centuryDigit) {
    case '0':
    case '1':
    case '2':
    case '3':
      yearStr = '19$year';
      break;
    case '4':
    case '9':
      if (year < 37) {
        yearStr = '20$year';
      } else {
        yearStr = '19$year';
      }
      break;
    default:
      if (year < 37) {
        yearStr = '20$year';
      } else if (year > 58) {
        yearStr = '18$year';
      } else {
        return false;
      }
      break;
  }
  // Add missing zero if needed
  if (yearStr.length == 3) {
    yearStr = '${yearStr.substring(0, 2)}0${yearStr.substring(2)}';
  }
  // Check date validity
  String date = '$yearStr/${tin.substring(2, 4)}/${tin.substring(0, 2)}';
  if (!$isDate(date, options: DateOptions(format: 'YYYY/MM/DD'))) {
    return false;
  }

  // Split digits into an array for further processing
  List<int> digits = tin.split('').map((a) => int.parse(a)).toList();
  int checksum = 0;
  int weight = 4;
  // Multiply by weight and add to checksum
  for (int i = 0; i < 9; i++) {
    checksum += digits[i] * weight;
    weight -= 1;
    if (weight == 1) {
      weight = 7;
    }
  }
  checksum %= 11;
  if (checksum == 1) {
    return false;
  }
  return checksum == 0 ? digits[9] == 0 : digits[9] == 11 - checksum;
}

/*
 * el-CY validation function
 * (Arithmos Forologikou Mitroou (AFM/ΑΦΜ), persons only)
 * Verify TIN validity by calculating ASCII value of check (last) character
 */
bool elCyCheck(String tin) {
  // split digits into an array for further processing
  List<int> digits =
      tin.substring(0, 8).split('').map((a) => int.parse(a)).toList();

  int checksum = 0;
  // add digits in even places
  for (int i = 1; i < digits.length; i += 2) {
    checksum += digits[i];
  }

  // add digits in odd places
  for (int i = 0; i < digits.length; i += 2) {
    if (digits[i] < 2) {
      checksum += 1 - digits[i];
    } else {
      checksum += (2 * (digits[i] - 2)) + 5;
      if (digits[i] > 4) {
        checksum += 2;
      }
    }
  }
  return String.fromCharCode((checksum % 26) + 65) == tin[8];
}

/*
 * el-GR validation function
 * (Arithmos Forologikou Mitroou (AFM/ΑΦΜ), persons/entities)
 * Verify TIN validity by calculating check (last) digit
 * Algorithm not in DG TAXUD document- sourced from:
 * - `http://epixeirisi.gr/%CE%9A%CE%A1%CE%99%CE%A3%CE%99%CE%9C%CE%91-%CE%98%CE%95%CE%9C%CE%91%CE%A4%CE%91-%CE%A6%CE%9F%CE%A1%CE%9F%CE%9B%CE%9F%CE%93%CE%99%CE%91%CE%A3-%CE%9A%CE%91%CE%99-%CE%9B%CE%9F%CE%93%CE%99%CE%A3%CE%A4%CE%99%CE%9A%CE%97%CE%A3/23791/%CE%91%CF%81%CE%B9%CE%B8%CE%BC%CF%8C%CF%82-%CE%A6%CE%BF%CF%81%CE%BF%CE%BB%CE%BF%CE%B3%CE%B9%CE%BA%CE%BF%CF%8D-%CE%9C%CE%B7%CF%84%CF%81%CF%8E%CE%BF%CF%85`
 */
bool elGrCheck(String tin) {
  // split digits into an array for further processing
  List<int> digits = tin.split('').map((a) => int.parse(a, radix: 10)).toList();

  int checksum = 0;
  for (int i = 0; i < 8; i++) {
    checksum += (digits[i] * (math.pow(2, (8 - i))).toInt());
  }
  return ((checksum % 11) % 10) == digits[8];
}

/*
 * Luhn (mod 10) validation function
 * Called with a string of numbers (incl. check digit)
 * to validate according to the Luhn algorithm.
 */

/*
 * en-IE validation function
 * (Personal Public Service Number (PPS No), persons only)
 * Verify TIN validity by calculating check (second to last) character
 */
bool enIeCheck(String tin) {
  int checksum = Algorithms.reverseMultiplyAndSum(
      tin.split('').sublist(0, 7).map((a) => int.parse(a)).toList(), 8);
  if (tin.length == 9 && tin[8] != 'W') {
    checksum += (tin[8].codeUnitAt(0) - 64) * 9;
  }

  checksum %= 23;
  if (checksum == 0) {
    return tin[7].toUpperCase() == 'W';
  }
  return tin[7].toUpperCase() == String.fromCharCode(64 + checksum);
}

// Valid US IRS campus prefixes
final enUsCampusPrefix = {
  'andover': ['10', '12'],
  'atlanta': ['60', '67'],
  'austin': ['50', '53'],
  'brookhaven': [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '11',
    '13',
    '14',
    '16',
    '21',
    '22',
    '23',
    '25',
    '34',
    '51',
    '52',
    '54',
    '55',
    '56',
    '57',
    '58',
    '59',
    '65'
  ],
  'cincinnati': ['30', '32', '35', '36', '37', '38', '61'],
  'fresno': ['15', '24'],
  'internet': ['20', '26', '27', '45', '46', '47'],
  'kansas': ['40', '44'],
  'memphis': ['94', '95'],
  'ogden': ['80', '90'],
  'philadelphia': [
    '33',
    '39',
    '41',
    '42',
    '43',
    '46',
    '48',
    '62',
    '63',
    '64',
    '66',
    '68',
    '71',
    '72',
    '73',
    '74',
    '75',
    '76',
    '77',
    '81',
    '82',
    '83',
    '84',
    '85',
    '86',
    '87',
    '88',
    '91',
    '92',
    '93',
    '98',
    '99'
  ],
  'sba': ['31'],
};

// Return an array of all US IRS campus prefixes
List<String> enUsGetPrefixes() {
  final prefixes = <String>[];

  for (final location in enUsCampusPrefix.entries) {
    if (enUsCampusPrefix.containsKey(location.key)) {
      prefixes.addAll(location.value);
    }
  }

  return prefixes;
}

/*
 * en-US validation function
 * Verify that the TIN starts with a valid IRS campus prefix
 */
bool enUsCheck(String tin) {
  return enUsGetPrefixes().contains(tin.substring(0, 2));
}

/*
 * es-ES validation function
 * (Documento Nacional de Identidad (DNI)
 * or Número de Identificación de Extranjero (NIE), persons only)
 * Verify TIN validity by calculating check (last) character
 */
bool esEsCheck(String tin) {
  // Split characters into a list for further processing
  List<String> chars = tin.toUpperCase().split('');

  // Replace initial letter if needed
  if (int.tryParse(chars[0]) == null && chars.length > 1) {
    int leadReplace = 0;
    switch (chars[0]) {
      case 'Y':
        leadReplace = 1;
        break;
      case 'Z':
        leadReplace = 2;
        break;
      default:
    }
    chars.removeAt(0);
    chars.insert(0, leadReplace.toString());
    // Fill with zeros if smaller than proper
  } else {
    while (chars.length < 9) {
      chars.insert(0, '0');
    }
  }

  // Calculate checksum and check according to lookup
  List<String> lookup = [
    'T',
    'R',
    'W',
    'A',
    'G',
    'M',
    'Y',
    'F',
    'P',
    'D',
    'X',
    'B',
    'N',
    'J',
    'Z',
    'S',
    'Q',
    'V',
    'H',
    'L',
    'C',
    'K',
    'E'
  ];
  String charsString = chars.join();
  int checksum = (int.parse(charsString.substring(0, 8)) % 23);
  return chars[8] == lookup[checksum];
}

/*
 * et-EE validation function
 * (Isikukood (IK), persons only)
 * Checks if birth date (century digit and six following) is valid and calculates check (last) digit
 * Material not in DG TAXUD document sourced from:
 * - `https://www.oecd.org/tax/automatic-exchange/crs-implementation-and-assistance/tax-identification-numbers/Estonia-TIN.pdf`
 */
bool etEeCheck(String tin) {
  // Extract year and add century
  String fullYear = tin[1] + tin[2];
  final centuryDigit = tin[0];
  switch (centuryDigit) {
    case '1':
    case '2':
      fullYear = '18$fullYear';
      break;
    case '3':
    case '4':
      fullYear = '19$fullYear';
      break;
    default:
      fullYear = '20$fullYear';
      break;
  }
  // Check date validity
  final date = '$fullYear/${tin[3]}${tin[4]}/${tin[5]}${tin[6]}';
  if (!$isDate(date, options: DateOptions(format: 'YYYY/MM/DD'))) {
    return false;
  }

  // Split digits into an array for further processing
  final digits = tin.split('').map(int.tryParse).toList();
  var checksum = 0;
  var weight = 1;
  // Multiply by weight and add to checksum
  for (var i = 0; i < 10; i++) {
    checksum += digits[i]! * weight;
    weight += 1;
    if (weight == 10) {
      weight = 1;
    }
  }
  // Do again if modulo 11 of checksum is 10
  if (checksum % 11 == 10) {
    checksum = 0;
    weight = 3;
    for (var i = 0; i < 10; i++) {
      checksum += digits[i]! * weight;
      weight += 1;
      if (weight == 10) {
        weight = 1;
      }
    }
    if (checksum % 11 == 10) {
      return digits[10] == 0;
    }
  }

  return checksum % 11 == digits[10];
}

/*
 * fi-FI validation function
 * (Henkilötunnus (HETU), persons only)
 * Checks if birth date (first six digits plus century symbol) is valid
 * and calculates check (last) digit
 */
bool fiFiCheck(String tin) {
  // Extract year and add century
  var fullYear = tin.substring(4, 6);
  final centurySymbol = tin.substring(6, 7);
  switch (centurySymbol) {
    case '+':
      fullYear = '18$fullYear';
      break;
    case '-':
      fullYear = '19$fullYear';
      break;
    default:
      fullYear = '20$fullYear';
      break;
  }
  // Check date validity
  final date = '$fullYear/${tin.substring(2, 4)}/${tin.substring(0, 2)}';
  if (!$isDate(date, options: DateOptions(format: 'YYYY/MM/DD'))) {
    return false;
  }

  // Calculate check character
  var checksum =
      int.parse('${tin.substring(0, 6)}${tin.substring(7, 10)}') % 31;
  if (checksum < 10) {
    return checksum == int.parse(tin.substring(10));
  }

  checksum -= 10;
  final lettersLookup = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'H',
    'J',
    'K',
    'L',
    'M',
    'N',
    'P',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y'
  ];
  return lettersLookup[checksum] == tin.substring(10);
}

/*
 * fr/nl-BE validation function
 * (Numéro national (N.N.), persons only)
 * Checks if birth date (first six digits) is valid and calculates check (last two) digits
 */

bool frBeCheck(String tin) {
  // Zero month/day value is acceptable
  if (tin.substring(2, 4) != '00' || tin.substring(4, 6) != '00') {
    // Extract date from first six digits of TIN
    final date =
        '${tin.substring(0, 2)}/${tin.substring(2, 4)}/${tin.substring(4, 6)}';
    if (!$isDate(date, options: DateOptions(format: 'YY/MM/DD'))) {
      return false;
    }
  }

  int checksum = 97 - (int.parse(tin.substring(0, 9)) % 97);
  final checkdigits = int.parse(tin.substring(9, 11));
  if (checksum != checkdigits) {
    checksum = 97 - (int.parse('2${tin.substring(0, 9)}') % 97);
    if (checksum != checkdigits) {
      return false;
    }
  }
  return true;
}

/*
 * fr-FR validation function
 * (Numéro fiscal de référence (numéro SPI), persons only)
 * Verify TIN validity by calculating check (last three) digits
 */
bool frFrCheck(String tin) {
  tin = tin.replaceAll(RegExp(r'\s'), '');
  final checksum = int.parse(tin.substring(0, 10)) % 511;
  final checkdigits = int.parse(tin.substring(10, 13));
  return checksum == checkdigits;
}

/*
 * fr/lb-LU validation function
 * (numéro d’identification personnelle, persons only)
 * Verify birth date validity and run Luhn and Verhoeff checks
 */
bool frLuCheck(String tin) {
  // Extract date and check validity
  final date =
      '${tin.substring(0, 4)}/${tin.substring(4, 6)}/${tin.substring(6, 8)}';
  if (!$isDate(date, options: DateOptions(format: 'YYYY/MM/DD'))) {
    return false;
  }

  // Run Luhn check
  if (!Algorithms.luhnCheck(tin.substring(0, 12))) {
    return false;
  }
  // Remove Luhn check digit and run Verhoeff check
  return Algorithms.verhoeffCheck('${tin.substring(0, 11)}${tin[12]}');
}

/*
 * hr-HR validation function
 * (Osobni identifikacijski broj (OIB), persons/entities)
 * Verify TIN validity by calling iso7064Check(digits)
 */
bool hrHrCheck(String tin) {
  return Algorithms.iso7064Check(tin);
}

/*
 * hu-HU validation function
 * (Adóazonosító jel, persons only)
 * Verify TIN validity by calculating check (last) digit
 */
bool huHuCheck(String tin) {
  // split digits into a list for further processing
  List<int> digits = tin.split('').map(int.parse).toList();

  int checksum = 8;
  for (int i = 1; i < 9; i++) {
    checksum += digits[i] * (i + 1);
  }
  return checksum % 11 == digits[9];
}

/*
 * lt-LT validation function (should go here if needed)
 * (Asmens kodas, persons/entities respectively)
 * Current validation check is alias of etEeCheck- same format applies
 */

/*
 * it-IT first/last name validity check
 * Accepts it-IT TIN-encoded names as a three-element character array and checks their validity
 * Due to lack of clarity between resources ("Are only Italian consonants used?
 * What happens if a person has X in their name?" etc.) only two test conditions
 * have been implemented:
 * Vowels may only be followed by other vowels or an X character
 * and X characters after vowels may only be followed by other X characters.
 */
bool itItNameCheck(List<String> name) {
  // true at the first occurence of a vowel
  bool vowelflag = false;

  // true at the first occurence of an X AFTER vowel
  // (to properly handle last names with X as consonant)
  bool xflag = false;

  for (int i = 0; i < 3; i++) {
    if (!vowelflag && RegExp(r'[AEIOU]').hasMatch(name[i])) {
      vowelflag = true;
    } else if (!xflag && vowelflag && (name[i] == 'X')) {
      xflag = true;
    } else if (i > 0) {
      if (vowelflag && !xflag) {
        if (!RegExp(r'[AEIOU]').hasMatch(name[i])) {
          return false;
        }
      }
      if (xflag) {
        if (!RegExp(r'X').hasMatch(name[i])) {
          return false;
        }
      }
    }
  }
  return true;
}

/*
 * it-IT validation function
 * (Codice fiscale (TIN-IT), persons only)
 * Verify name, birth date and codice catastale validity
 * and calculate check character.
 * Material not in DG-TAXUD document sourced from:
 * `https://en.wikipedia.org/wiki/Italian_fiscal_code`
 */
bool itItCheck(String tin) {
  // Capitalize and split characters into an array for further processing
  List<String> chars = tin.toUpperCase().split('');

  // Check first and last name validity calling itItNameCheck()
  if (!itItNameCheck(chars.sublist(0, 3))) {
    return false;
  }
  if (!itItNameCheck(chars.sublist(3, 6))) {
    return false;
  }

  // Convert letters in number spaces back to numbers if any
  List<int> numberLocations = [6, 7, 9, 10, 12, 13, 14];
  Map<String, String> numberReplace = {
    'L': '0',
    'M': '1',
    'N': '2',
    'P': '3',
    'Q': '4',
    'R': '5',
    'S': '6',
    'T': '7',
    'U': '8',
    'V': '9',
  };
  for (int i in numberLocations) {
    if (numberReplace.containsKey(chars[i])) {
      chars[i] = numberReplace[chars[i]]!;
    }
  }

  // Extract month and day, and check date validity
  Map<String, String> monthReplace = {
    'A': '01',
    'B': '02',
    'C': '03',
    'D': '04',
    'E': '05',
    'H': '06',
    'L': '07',
    'M': '08',
    'P': '09',
    'R': '10',
    'S': '11',
    'T': '12',
  };

  var month = monthReplace[chars[8]];

  var day = int.parse(chars[9] + chars[10]);
  var dayStr = day.toString();

  if (day > 40) {
    day -= 40;
  }
  if (day < 10) {
    dayStr = '0$day';
  }

  var date = '${chars[6]}${chars[7]}/$month/$dayStr';
  if (!$isDate(date, options: DateOptions(format: 'YY/MM/DD'))) {
    return false;
  }

  var checksum = 0;
  for (var i = 1; i < chars.length - 1; i += 2) {
    var charToInt = int.tryParse(chars[i]);
    charToInt ??= chars[i].codeUnitAt(0) - 65;
    checksum += charToInt;
  }

  const oddConvert = {
    // Maps of characters at odd places
    'A': 1,
    'B': 0,
    'C': 5,
    'D': 7,
    'E': 9,
    'F': 13,
    'G': 15,
    'H': 17,
    'I': 19,
    'J': 21,
    'K': 2,
    'L': 4,
    'M': 18,
    'N': 20,
    'O': 11,
    'P': 3,
    'Q': 6,
    'R': 8,
    'S': 12,
    'T': 14,
    'U': 16,
    'V': 10,
    'W': 22,
    'X': 25,
    'Y': 24,
    'Z': 23,
    '0': 1,
    '1': 0,
  };

  for (int i = 0; i < chars.length - 1; i += 2) {
    int charToInt = 0;
    if (oddConvert.containsKey(chars[i])) {
      charToInt = oddConvert[chars[i]]!;
    } else {
      int multiplier = int.parse(chars[i]);
      charToInt = (2 * multiplier) + 1;
      if (multiplier > 4) {
        charToInt += 2;
      }
    }
    checksum += charToInt;
  }

  if (String.fromCharCode(65 + (checksum % 26)) != chars[15]) {
    return false;
  }
  return true;
}

/*
 * lv-LV validation function
 * (Personas kods (PK), persons only)
 * Check validity of birth date and calculate check (last) digit
 * Support only for old format numbers (not starting with '32', issued before 2017/07/01)
 * Material not in DG TAXUD document sourced from:
 * `https://boot.ritakafija.lv/forums/index.php?/topic/88314-personas-koda-algoritms-%C4%8Deksumma/`
 */
bool lvLvCheck(String tin) {
  tin = tin.replaceAll(RegExp(r"\W"), "");
  // Extract date from TIN
  final day = tin.substring(0, 2);
  if (day != '32') {
    // No date/checksum check if new format
    final month = tin.substring(2, 4);
    if (month != '00') {
      // No date check if unknown month
      String fullYear = tin.substring(4, 6);
      switch (tin[6]) {
        case '0':
          fullYear = '18$fullYear';
          break;
        case '1':
          fullYear = '19$fullYear';
          break;
        default:
          fullYear = '20$fullYear';
          break;
      }
      // Check date validity
      final date = '$fullYear/${tin.substring(2, 4)}/$day';
      if (!$isDate(date, options: DateOptions(format: 'YYYY/MM/DD'))) {
        return false;
      }
    }

    // Calculate check digit
    int checksum = 1101;
    final ipLookup = [1, 6, 3, 7, 9, 10, 5, 8, 4, 2];
    for (int i = 0; i < tin.length - 1; i++) {
      checksum -= int.parse(tin[i]) * ipLookup[i];
    }
    return (int.parse(tin[10]) == checksum % 11);
  }
  return true;
}

/*
 * mt-MT validation function
 * (Identity Card Number or Unique Taxpayer Reference, persons/entities)
 * Verify Identity Card Number structure (no other tests found)
 */
bool mtMtCheck(String tin) {
  if (tin.length != 9) {
    // No tests for UTR
    List<String> chars = tin.toUpperCase().split('');
    // Fill with zeros if smaller than proper
    while (chars.length < 8) {
      chars.insert(0, '0');
    }
    // Validate format according to last character
    switch (chars[7]) {
      case 'A':
      case 'P':
        if (int.parse(chars[6]) == 0) {
          return false;
        }
        break;
      default:
        {
          final firstPart = int.parse(chars.join('').substring(0, 5));
          if (firstPart > 32000) {
            return false;
          }
          final secondPart = int.parse(chars.join('').substring(5, 7));
          if (firstPart == secondPart) {
            return false;
          }
        }
    }
  }
  return true;
}

/*
 * nl-NL validation function
 * (Burgerservicenummer (BSN) or Rechtspersonen Samenwerkingsverbanden Informatie Nummer (RSIN),
 * persons/entities respectively)
 * Verify TIN validity by calculating check (last) digit (variant of MOD 11)
 */
bool nlNlCheck(String tin) {
  return Algorithms.reverseMultiplyAndSum(
              tin.split('').sublist(0, 8).map((a) => int.parse(a)).toList(),
              9) %
          11 ==
      int.parse(tin[8]);
}

/*
 * pl-PL validation function
 * (Powszechny Elektroniczny System Ewidencji Ludności (PESEL)
 * or Numer identyfikacji podatkowej (NIP), persons/entities)
 * Verify TIN validity by validating birth date (PESEL) and calculating check (last) digit
 */
bool plPlCheck(String tin) {
  // NIP
  if (tin.length == 10) {
    // Calculate last digit by multiplying with lookup
    final lookup = [6, 5, 7, 2, 3, 4, 5, 6, 7];
    int checksum = 0;
    for (int i = 0; i < lookup.length; i++) {
      checksum += int.parse(tin[i]) * lookup[i];
    }
    checksum %= 11;
    if (checksum == 10) {
      return false;
    }
    return (checksum == int.parse(tin[9]));
  }

  // PESEL
  // Extract full year using month
  String fullYear = tin.substring(0, 2);
  int month = int.parse(tin.substring(2, 4), radix: 10);
  var monthStr = month.toString();
  if (month > 80) {
    fullYear = '18$fullYear';
    month -= 80;
  } else if (month > 60) {
    fullYear = '22$fullYear';
    month -= 60;
  } else if (month > 40) {
    fullYear = '21$fullYear';
    month -= 40;
  } else if (month > 20) {
    fullYear = '20$fullYear';
    month -= 20;
  } else {
    fullYear = '19$fullYear';
  }
  // Add leading zero to month if needed
  if (month < 10) {
    monthStr = '0$month';
  } else {
    monthStr = month.toString();
  }
  // Check date validity
  final date = '$fullYear/$monthStr/${tin.substring(4, 6)}';
  if (!$isDate(date, options: DateOptions(format: 'YYYY/MM/DD'))) {
    return false;
  }

  // Calculate last digit by mulitplying with odd one-digit numbers except 5
  int checksum = 0;
  int multiplier = 1;
  for (int i = 0; i < tin.length - 1; i++) {
    checksum += (int.parse(tin[i]) * multiplier) % 10;
    multiplier += 2;
    if (multiplier > 10) {
      multiplier = 1;
    } else if (multiplier == 5) {
      multiplier += 2;
    }
  }
  checksum = 10 - (checksum % 10);
  return checksum == int.parse(tin[10]);
}

/*
* pt-BR validation function
* (Cadastro de Pessoas Físicas (CPF, persons)
* Cadastro Nacional de Pessoas Jurídicas (CNPJ, entities)
* Both inputs will be validated
*/
bool ptBrCheck(String tin) {
  if (tin.length == 11) {
    int sum;
    int remainder;
    sum = 0;

    if ( // Reject known invalid CPFs
        tin == '11111111111' ||
            tin == '22222222222' ||
            tin == '33333333333' ||
            tin == '44444444444' ||
            tin == '55555555555' ||
            tin == '66666666666' ||
            tin == '77777777777' ||
            tin == '88888888888' ||
            tin == '99999999999' ||
            tin == '00000000000') {
      return false;
    }

    for (int i = 1; i <= 9; i++) {
      sum += int.parse(tin.substring(i - 1, i)) * (11 - i);
    }
    remainder = (sum * 10) % 11;
    if (remainder == 10) remainder = 0;
    if (remainder != int.parse(tin.substring(9, 10))) {
      return false;
    }
    sum = 0;

    for (int i = 1; i <= 10; i++) {
      sum += int.parse(tin.substring(i - 1, i)) * (12 - i);
    }
    remainder = (sum * 10) % 11;
    if (remainder == 10) remainder = 0;
    if (remainder != int.parse(tin.substring(10, 11))) return false;

    return true;
  }

  if ( // Reject know invalid CNPJs
      tin == '00000000000000' ||
          tin == '11111111111111' ||
          tin == '22222222222222' ||
          tin == '33333333333333' ||
          tin == '44444444444444' ||
          tin == '55555555555555' ||
          tin == '66666666666666' ||
          tin == '77777777777777' ||
          tin == '88888888888888' ||
          tin == '99999999999999') {
    return false;
  }

  int length = tin.length - 2;
  String identifiers = tin.substring(0, length);
  String verificators = tin.substring(length);
  int sum = 0;
  int pos = length - 7;

  for (int i = length; i >= 1; i--) {
    sum += int.parse(identifiers[length - i]) * pos;
    pos -= 1;
    if (pos < 2) {
      pos = 9;
    }
  }
  int result = sum % 11 < 2 ? 0 : 11 - (sum % 11);
  if (result != int.parse(verificators[0], radix: 10)) {
    return false;
  }

  length += 1;
  identifiers = tin.substring(0, length);
  sum = 0;
  pos = length - 7;
  for (int i = length; i >= 1; i--) {
    sum += int.parse(identifiers[length - i]) * pos;
    pos -= 1;
    if (pos < 2) {
      pos = 9;
    }
  }
  result = sum % 11 < 2 ? 0 : 11 - (sum % 11);
  if (result != int.parse(verificators[1])) {
    return false;
  }

  return true;
}

/*
 * pt-PT validation function
 * (Número de identificação fiscal (NIF), persons/entities)
 * Verify TIN validity by calculating check (last) digit (variant of MOD 11)
 */
bool ptPtCheck(String tin) {
  int checksum = 11 -
      (Algorithms.reverseMultiplyAndSum(
              tin
                  .split('')
                  .sublist(0, 8)
                  .map((a) => int.parse(a, radix: 10))
                  .toList(),
              9) %
          11);
  if (checksum > 9) {
    return int.parse(tin[8], radix: 10) == 0;
  }
  return checksum == int.parse(tin[8], radix: 10);
}

/*
 * ro-RO validation function
 * (Cod Numeric Personal (CNP) or Cod de înregistrare fiscală (CIF),
 * persons only)
 * Verify CNP validity by calculating check (last) digit (test not found for CIF)
 * Material not in DG TAXUD document sourced from:
 * `https://en.wikipedia.org/wiki/National_identification_number#Romania`
 */
bool roRoCheck(String tin) {
  if (tin.substring(0, 4) != '9000') {
    // No test found for this format
    // Extract full year using century digit if possible
    String fullYear = tin.substring(1, 3);
    switch (tin[0]) {
      case '1':
      case '2':
        fullYear = '19$fullYear';
        break;
      case '3':
      case '4':
        fullYear = '18$fullYear';
        break;
      case '5':
      case '6':
        fullYear = '20$fullYear';
        break;
      default:
    }

    // Check date validity
    String date = '$fullYear/${tin.substring(3, 5)}/${tin.substring(5, 7)}';
    if (date.length == 8) {
      if (!$isDate(date, options: DateOptions(format: 'YY/MM/DD'))) {
        return false;
      }
    } else if (!$isDate(date, options: DateOptions(format: 'YYYY/MM/DD'))) {
      return false;
    }

    // Calculate check digit
    List<int> digits =
        tin.split('').map((a) => int.parse(a, radix: 10)).toList();
    List<int> multipliers = [2, 7, 9, 1, 4, 6, 3, 5, 8, 2, 7, 9];
    int checksum = 0;
    for (int i = 0; i < multipliers.length; i++) {
      checksum += digits[i] * multipliers[i];
    }
    if (checksum % 11 == 10) {
      return digits[12] == 1;
    }
    return digits[12] == checksum % 11;
  }
  return true;
}

/*
 * sk-SK validation function
 * (Rodné číslo (RČ) or bezvýznamové identifikačné číslo (BIČ), persons only)
 * Checks validity of pre-1954 birth numbers (rodné číslo) only
 * Due to the introduction of the pseudo-random BIČ it is not possible to test
 * post-1954 birth numbers without knowing whether they are BIČ or RČ beforehand
 */
bool skSkCheck(String tin) {
  if (tin.length == 9) {
    tin = tin.replaceAll(RegExp(r'\W'), '');
    if (tin.substring(6) == '000') {
      return false;
    } // Three-zero serial not assigned before 1954

    // Extract full year from TIN length
    int fullYear = int.parse(tin.substring(0, 2), radix: 10);
    var fullYearStr = fullYear.toString();
    if (fullYear > 53) {
      return false;
    }
    if (fullYear < 10) {
      fullYearStr = '190$fullYear';
    } else {
      fullYearStr = '19$fullYear';
    }

    // Extract month from TIN and normalize
    int month = int.parse(tin.substring(2, 4), radix: 10);
    var monthStr = month.toString();
    if (month > 50) {
      month -= 50;
    }
    if (month < 10) {
      monthStr = '0$month';
    }

    // Check date validity
    String date = '$fullYearStr/$monthStr/${tin.substring(4, 6)}';
    if (!$isDate(date, options: DateOptions(format: 'YYYY/MM/DD'))) {
      return false;
    }
  }
  return true;
}

/*
 * sl-SI validation function
 * (Davčna številka, persons/entities)
 * Verify TIN validity by calculating check (last) digit (variant of MOD 11)
 */
bool slSiCheck(String tin) {
  int checksum = 11 -
      (Algorithms.reverseMultiplyAndSum(
              tin
                  .split('')
                  .sublist(0, 7)
                  .map((a) => int.parse(a, radix: 10))
                  .toList(),
              8) %
          11);
  if (checksum == 10) {
    return int.parse(tin[7], radix: 10) == 0;
  }
  return checksum == int.parse(tin[7], radix: 10);
}

/*
 * sv-SE validation function
 * (Personnummer or samordningsnummer, persons only)
 * Checks validity of birth date and calls luhnCheck() to validate check (last) digit
 */
bool svSeCheck(String tin) {
  // Make copy of TIN and normalize to two-digit year form
  String tinCopy = tin.substring(0);
  if (tin.length > 11) {
    tinCopy = tinCopy.substring(2);
  }

  // Extract date of birth
  String fullYear = '';
  String month = tinCopy.substring(2, 4);
  int day = int.parse(tinCopy.substring(4, 6), radix: 10);
  if (tin.length > 11) {
    fullYear = tin.substring(0, 4);
  } else {
    fullYear = tin.substring(0, 2);
    if (tin.length == 11 && day < 60) {
      // Extract full year from centenarian symbol
      // Should work just fine until year 10000 or so
      String currentYear = DateTime.now().year.toString();
      int currentCentury = int.parse(currentYear.substring(0, 2), radix: 10);
      var currentYearInt = int.parse(currentYear, radix: 10);
      if (tin[6] == '-') {
        if (int.parse('$currentCentury$fullYear', radix: 10) > currentYearInt) {
          fullYear = '${currentCentury - 1}$fullYear';
        } else {
          fullYear = '$currentCentury$fullYear';
        }
      } else {
        fullYear = '${currentCentury - 1}$fullYear';
        if (currentYearInt - int.parse(fullYear, radix: 10) < 100) {
          return false;
        }
      }
    }
  }

  var dayStr = day.toString();

  // Normalize day and check date validity
  if (day > 60) {
    dayStr = (day - 60).toString();
  }
  if (day < 10) {
    dayStr = '0$day';
  }
  String date = '$fullYear/$month/$dayStr';
  if (date.length == 8) {
    if (!$isDate(date, options: DateOptions(format: 'YY/MM/DD'))) {
      return false;
    }
  } else if (!$isDate(date, options: DateOptions(format: 'YYYY/MM/DD'))) {
    return false;
  }

  return Algorithms.luhnCheck(tin.replaceAll(RegExp(r'\W'), ''));
}

// Locale lookup objects

/*
 * Tax id regex formats for various locales
 *
 * Where not explicitly specified in DG-TAXUD document both
 * uppercase and lowercase letters are acceptable.
 */
const frLU = r'^\d{13}$';
const etEE = r'^[1-6]\d{6}(00[1-9]|0[1-9][0-9]|[1-6][0-9]{2}|70[0-9]|710)\d$';
const frBE = r'^\d{11}$';
const enCA = r'^\d{9}$';

final taxIdFormat = {
  'bg-BG': RegExp(r'^\d{10}$'),
  'cs-CZ': RegExp(r'^\d{6}\/{0,1}\d{3,4}$'),
  'de-AT': RegExp(r'^\d{9}$'),
  'de-DE': RegExp(r'^[1-9]\d{10}$'),
  'dk-DK': RegExp(r'^\d{6}-{0,1}\d{4}$'),
  'el-CY': RegExp(r'^[09]\d{7}[A-Z]$'),
  'el-GR': RegExp(r'^([0-4]|[7-9])\d{8}$'),
  'en-CA': RegExp(enCA),
  'en-GB': RegExp(
      r'^\d{10}$|^(?!GB|NK|TN|ZZ)(?![DFIQUV])[A-Z](?![DFIQUVO])[A-Z]\d{6}[ABCD ]$',
      caseSensitive: false),
  'en-IE': RegExp(r'^\d{7}[A-W][A-IW]{0,1}$', caseSensitive: false),
  'en-US': RegExp(r'^\d{2}[- ]{0,1}\d{7}$'),
  'es-ES':
      RegExp(r'^(\d{0,8}|[XYZKLM]\d{7})[A-HJ-NP-TV-Z]$', caseSensitive: false),
  'et-EE': RegExp(etEE),
  'fi-FI': RegExp(r'^\d{6}[-+A]\d{3}[0-9A-FHJ-NPR-Y]$', caseSensitive: false),
  'fr-BE': RegExp(frBE),
  'fr-CA': RegExp(enCA),
  'fr-FR': RegExp(
      r'^[0-3]\d{12}$|^[0-3]\d\s\d{2}(\s\d{3}){3}$'), // Conforms both to official spec and provided example
  'fr-LU': RegExp(frLU),
  'hr-HR': RegExp(r'^\d{11}$'),
  'hu-HU': RegExp(r'^8\d{9}$'),
  'it-IT': RegExp(
      r'^[A-Z]{6}[L-NP-V0-9]{2}[A-EHLMPRST][L-NP-V0-9]{2}[A-ILMZ][L-NP-V0-9]{3}[A-Z]$',
      caseSensitive: false),
  'lb-LU': RegExp(frLU),
  'lt-LT': RegExp(etEE),
  'lv-LV': RegExp(
      r'^\d{6}-{0,1}\d{5}$'), // Conforms both to DG TAXUD spec and original research
  'mt-MT':
      RegExp(r'^\d{3,7}[APMGLHBZ]$|^([1-8])\1\d{7}$', caseSensitive: false),
  'nl-BE': RegExp(frBE),
  'nl-NL': RegExp(r'^\d{9}$'),
  'pl-PL': RegExp(r'^\d{10,11}$'),
  'pt-BR': RegExp(r'(?:^\d{11}$)|(?:^\d{14}$)'),
  'pt-PT': RegExp(r'^\d{9}$'),
  'ro-RO': RegExp(r'^\d{13}$'),
  'sk-SK': RegExp(r'^\d{6}\/{0,1}\d{3,4}$'),
  'sl-SI': RegExp(r'^[1-9]\d{7}$'),
  'sv-SE': RegExp(r'^(\d{6}[-+]{0,1}\d{4}|(18|19|20)\d{6}[-+]{0,1}\d{4})$'),
};

// Algorithmic tax id check functions for various locales
const taxIdCheck = {
  'bg-BG': bgBgCheck,
  'cs-CZ': csCzCheck,
  'de-AT': deAtCheck,
  'de-DE': deDeCheck,
  'dk-DK': dkDkCheck,
  'el-CY': elCyCheck,
  'el-GR': elGrCheck,
  'en-CA': isCanadianSIN,
  'en-IE': enIeCheck,
  'en-US': enUsCheck,
  'es-ES': esEsCheck,
  'et-EE': etEeCheck,
  'fi-FI': fiFiCheck,
  'fr-BE': frBeCheck,
  'fr-CA': isCanadianSIN,
  'fr-FR': frFrCheck,
  'fr-LU': frLuCheck,
  'hr-HR': hrHrCheck,
  'hu-HU': huHuCheck,
  'it-IT': itItCheck,
  'lb-LU': frLuCheck,
  'lt-LT': etEeCheck,
  'lv-LV': lvLvCheck,
  'mt-MT': mtMtCheck,
  'nl-BE': frBeCheck,
  'nl-NL': nlNlCheck,
  'pl-PL': plPlCheck,
  'pt-BR': ptBrCheck,
  'pt-PT': ptPtCheck,
  'ro-RO': roRoCheck,
  'sk-SK': skSkCheck,
  'sl-SI': slSiCheck,
  'sv-SE': svSeCheck,
};

// Regexes for locales where characters should be omitted before checking format
final allsymbols = RegExp(r'[-\\\/!@#$%\^&\*\(\)\+\=\[\]]+');
final sanitizeRegexes = {
  'de-AT': allsymbols,
  'de-DE': RegExp(r'[\/\\]'),
  'fr-BE': allsymbols,
  'nl-BE': allsymbols,
};

/*
 * Validator function
 * Return true if the passed string is a valid tax identification number
 * for the specified locale.
 * Throw an error exception if the locale is not supported.
 */
bool $isTaxID(String str, {String? locale = 'en-US'}) {
  // Copy TIN to avoid replacement if sanitized
  String strcopy = str.substring(0);

  if (taxIdFormat.containsKey(locale)) {
    if (sanitizeRegexes.containsKey(locale)) {
      strcopy = strcopy.replaceAll(sanitizeRegexes[locale]!, '');
    }
    if (!taxIdFormat[locale]!.hasMatch(strcopy)) {
      return false;
    }

    if (taxIdCheck.containsKey(locale)) {
      return taxIdCheck[locale]!(strcopy);
    }
    // Fallthrough; not all locales have algorithmic checks
    return true;
  }
  throw Exception('Invalid locale "$locale"');
}
