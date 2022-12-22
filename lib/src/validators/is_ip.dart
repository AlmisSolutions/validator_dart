import 'package:validator_dart/src/util/assert_string.dart';

/*
11.3.  Examples
   The following addresses
             fe80::1234 (on the 1st link of the node)
             ff02::5678 (on the 5th link of the node)
             ff08::9abc (on the 10th organization of the node)
   would be represented as follows:
             fe80::1234%1
             ff02::5678%5
             ff08::9abc%10
   (Here we assume a natural translation from a zone index to the
   <zone_id> part, where the Nth zone of any scope is translated into
   "N".)
   If we use interface names as <zone_id>, those addresses could also be
   represented as follows:
            fe80::1234%ne0
            ff02::5678%pvc1.3
            ff08::9abc%interface10
   where the interface "ne0" belongs to the 1st link, "pvc1.3" belongs
   to the 5th link, and "interface10" belongs to the 10th organization.
 */

const iPv4SegmentFormat =
    r'(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])';
final iPv4AddressFormat = '($iPv4SegmentFormat[.]){3}$iPv4SegmentFormat';
final iPv4AddressRegExp = RegExp('^$iPv4AddressFormat\$');

const iPv6SegmentFormat = r'(?:[0-9a-fA-F]{1,4})';
final iPv6AddressRegExp = RegExp(
    '^((?:$iPv6SegmentFormat:){7}(?:$iPv6SegmentFormat|:)|(?:$iPv6SegmentFormat:){6}(?:$iPv4AddressFormat|:$iPv6SegmentFormat|:)|(?:$iPv6SegmentFormat:){5}(?::$iPv4AddressFormat|(:$iPv6SegmentFormat){1,2}|:)|(?:$iPv6SegmentFormat:){4}(?:(:$iPv6SegmentFormat){0,1}:$iPv4AddressFormat|(:$iPv6SegmentFormat){1,3}|:)|(?:$iPv6SegmentFormat:){3}(?:(:$iPv6SegmentFormat){0,2}:$iPv4AddressFormat|(:$iPv6SegmentFormat){1,4}|:)|(?:$iPv6SegmentFormat:){2}(?:(:$iPv6SegmentFormat){0,3}:$iPv4AddressFormat|(:$iPv6SegmentFormat){1,5}|:)|(?:$iPv6SegmentFormat:){1}(?:(:$iPv6SegmentFormat){0,4}:$iPv4AddressFormat|(:$iPv6SegmentFormat){1,6}|:)|(?::((?::$iPv6SegmentFormat){0,5}:$iPv4AddressFormat|(?::$iPv6SegmentFormat){1,7}|:)))(%[0-9a-zA-Z-.:]{1,})?\$');

bool $isIP(String str, {int? version}) {
  assertString(str);
  if (version == null) {
    return $isIP(str, version: 4) || $isIP(str, version: 6);
  }
  if (version == 4) {
    return iPv4AddressRegExp.hasMatch(str);
  }
  if (version == 6) {
    return iPv6AddressRegExp.hasMatch(str);
  }
  return false;
}
