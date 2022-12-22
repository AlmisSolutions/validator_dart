class EmailNormalizationOptions {
  final bool allLowercase;
  final bool gmailLowercase;
  final bool gmailRemoveDots;
  final bool gmailRemoveSubaddress;
  final bool gmailConvertGooglemaildotcom;
  final bool outlookdotcomLowercase;
  final bool outlookdotcomRemoveSubaddress;
  final bool yahooLowercase;
  final bool yahooRemoveSubaddress;
  final bool yandexLowercase;
  final bool icloudLowercase;
  final bool icloudRemoveSubaddress;

  const EmailNormalizationOptions({
    this.allLowercase = true,
    this.gmailLowercase = true,
    this.gmailRemoveDots = true,
    this.gmailRemoveSubaddress = true,
    this.gmailConvertGooglemaildotcom = true,
    this.outlookdotcomLowercase = true,
    this.outlookdotcomRemoveSubaddress = true,
    this.yahooLowercase = true,
    this.yahooRemoveSubaddress = true,
    this.yandexLowercase = true,
    this.icloudLowercase = true,
    this.icloudRemoveSubaddress = true,
  });
}

// List of domains used by iCloud
const icloudDomains = [
  'icloud.com',
  'me.com',
];

// List of domains used by Outlook.com and its predecessors
// This list is likely incomplete.
// Partial reference:
// https://blogs.office.com/2013/04/17/outlook-com-gets-two-step-verification-sign-in-by-alias-and-new-international-domains/
const outlookdotcomDomains = [
  'hotmail.at',
  'hotmail.be',
  'hotmail.ca',
  'hotmail.cl',
  'hotmail.co.il',
  'hotmail.co.nz',
  'hotmail.co.th',
  'hotmail.co.uk',
  'hotmail.com',
  'hotmail.com.ar',
  'hotmail.com.au',
  'hotmail.com.br',
  'hotmail.com.gr',
  'hotmail.com.mx',
  'hotmail.com.pe',
  'hotmail.com.tr',
  'hotmail.com.vn',
  'hotmail.cz',
  'hotmail.de',
  'hotmail.dk',
  'hotmail.es',
  'hotmail.fr',
  'hotmail.hu',
  'hotmail.id',
  'hotmail.ie',
  'hotmail.in',
  'hotmail.it',
  'hotmail.jp',
  'hotmail.kr',
  'hotmail.lv',
  'hotmail.my',
  'hotmail.ph',
  'hotmail.pt',
  'hotmail.sa',
  'hotmail.sg',
  'hotmail.sk',
  'live.be',
  'live.co.uk',
  'live.com',
  'live.com.ar',
  'live.com.mx',
  'live.de',
  'live.es',
  'live.eu',
  'live.fr',
  'live.it',
  'live.nl',
  'msn.com',
  'outlook.at',
  'outlook.be',
  'outlook.cl',
  'outlook.co.il',
  'outlook.co.nz',
  'outlook.co.th',
  'outlook.com',
  'outlook.com.ar',
  'outlook.com.au',
  'outlook.com.br',
  'outlook.com.gr',
  'outlook.com.pe',
  'outlook.com.tr',
  'outlook.com.vn',
  'outlook.cz',
  'outlook.de',
  'outlook.dk',
  'outlook.es',
  'outlook.fr',
  'outlook.hu',
  'outlook.id',
  'outlook.ie',
  'outlook.in',
  'outlook.it',
  'outlook.jp',
  'outlook.kr',
  'outlook.lv',
  'outlook.my',
  'outlook.ph',
  'outlook.pt',
  'outlook.sa',
  'outlook.sg',
  'outlook.sk',
  'passport.com',
];

// List of domains used by Yahoo Mail
// This list is likely incomplete
const yahooDomains = [
  'rocketmail.com',
  'yahoo.ca',
  'yahoo.co.uk',
  'yahoo.com',
  'yahoo.de',
  'yahoo.fr',
  'yahoo.in',
  'yahoo.it',
  'ymail.com',
];

// List of domains used by yandex.ru
const yandexDomains = [
  'yandex.ru',
  'yandex.ua',
  'yandex.kz',
  'yandex.com',
  'yandex.by',
  'ya.ru',
];

String dotsReplacer(Match match) {
  var group = match.group(0);
  if (group != null && group.length > 1) {
    return group;
  }
  return '';
}

String $normalizeEmail(String email, {EmailNormalizationOptions? options}) {
  options = options ?? EmailNormalizationOptions();

  List<String> rawParts = email.split('@');
  String domain = rawParts.removeLast();
  String user = rawParts.join('@');
  List<String> parts = [user, domain];

  // The domain is always lowercased, as it's case-insensitive per RFC 1035
  parts[1] = parts[1].toLowerCase();

  if (parts[1] == 'gmail.com' || parts[1] == 'googlemail.com') {
    // Address is GMail
    if (options.gmailRemoveSubaddress) {
      parts[0] = parts[0].split('+')[0];
    }
    if (options.gmailRemoveDots) {
      // this does not replace consecutive dots like example..email@gmail.com
      parts[0] = parts[0].replaceAllMapped(RegExp(r'\.+'), dotsReplacer);
    }
    if (parts[0].isEmpty) {
      return '';
    }
    if (options.allLowercase || options.gmailLowercase) {
      parts[0] = parts[0].toLowerCase();
    }
    parts[1] = options.gmailConvertGooglemaildotcom ? 'gmail.com' : parts[1];
  } else if (icloudDomains.contains(parts[1])) {
    // Address is iCloud
    if (options.icloudRemoveSubaddress) {
      parts[0] = parts[0].split('+')[0];
    }
    if (parts[0].isEmpty) {
      return '';
    }
    if (options.allLowercase || options.icloudLowercase) {
      parts[0] = parts[0].toLowerCase();
    }
  } else if (outlookdotcomDomains.contains(parts[1])) {
    // Address is Outlook.com
    if (options.outlookdotcomRemoveSubaddress) {
      parts[0] = parts[0].split('+')[0];
    }
    if (parts[0].isEmpty) {
      return '';
    }
    if (options.allLowercase || options.outlookdotcomLowercase) {
      parts[0] = parts[0].toLowerCase();
    }
  } else if (yahooDomains.contains(parts[1])) {
    // Address is Yahoo
    if (options.yahooRemoveSubaddress) {
      List<String> components = parts[0].split('-');
      parts[0] = (components.length > 1)
          ? components.getRange(0, components.length - 1).join('-')
          : components[0];
    }
    if (parts[0].isEmpty) {
      return '';
    }
    if (options.allLowercase || options.yahooLowercase) {
      parts[0] = parts[0].toLowerCase();
    }
  } else if (yandexDomains.contains(parts[1])) {
    if (options.allLowercase || options.yandexLowercase) {
      parts[0] = parts[0].toLowerCase();
    }
    parts[1] = 'yandex.ru'; // all yandex domains are equal, 1st preferred
  } else if (options.allLowercase) {
    // Any other address
    parts[0] = parts[0].toLowerCase();
  }
  return parts.join('@');
}
