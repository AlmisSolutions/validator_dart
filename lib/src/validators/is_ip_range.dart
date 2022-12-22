import 'package:validator_dart/src/validators/is_ip.dart';

final subnetMaybe = RegExp(r'^\d{1,3}$');
const v4Subnet = 32;
const v6Subnet = 128;

bool $isIPRange(String str, {int? version}) {
  final parts = str.split('/');

  // parts[0] -> ip, parts[1] -> subnet
  if (parts.length != 2) {
    return false;
  }

  if (!subnetMaybe.hasMatch(parts[1])) {
    return false;
  }

  // Disallow preceding 0 i.e. 01, 02, ...
  if (parts[1].length > 1 && parts[1].startsWith('0')) {
    return false;
  }

  final isValidIP = $isIP(parts[0], version: version);
  if (!isValidIP) {
    return false;
  }

  // Define valid subnet according to IP's version
  int expectedSubnet;
  switch (version) {
    case 4:
      expectedSubnet = v4Subnet;
      break;
    case 6:
      expectedSubnet = v6Subnet;
      break;
    default:
      expectedSubnet = $isIP(parts[0], version: 6) ? v6Subnet : v4Subnet;
  }

  return int.parse(parts[1]) <= expectedSubnet && int.parse(parts[1]) >= 0;
}
