/*
options for isURL method
require_protocol - if set as true isURL will return false if protocol is not present in the URL
require_valid_protocol - isURL will check if the URL's protocol is present in the protocols option
protocols - valid protocols can be modified with this option
require_host - if set as false isURL will not check if host is present in the URL
require_port - if set as true isURL will check if port is present in the URL
allow_protocol_relative_urls - if set as true protocol relative URLs will be allowed
validate_length - if set as false isURL will skip string length validation (IE maximum is 2083)
*/

import 'package:validator_dart/extensions/list_extensions.dart';
import 'package:validator_dart/extensions/string_extensions.dart';
import 'package:validator_dart/src/validators/is_fqdn.dart';
import 'package:validator_dart/src/validators/is_ip.dart';

class UrlOptions {
  final List<String> protocols;
  final bool requireTld;
  final bool requireProtocol;
  final bool requireHost;
  final bool requirePort;
  final bool requireValidProtocol;
  final bool allowUnderscores;
  final bool allowTrailingDot;
  final bool allowProtocolRelativeUrls;
  final bool allowFragments;
  final bool allowQueryComponents;
  final bool validateLength;
  final bool disallowAuth;
  final List<dynamic> hostWhitelist;
  final List<dynamic> hostBlacklist;

  UrlOptions({
    this.protocols = const ['http', 'https', 'ftp'],
    this.requireTld = true,
    this.requireProtocol = false,
    this.requireHost = true,
    this.requirePort = false,
    this.requireValidProtocol = true,
    this.allowUnderscores = false,
    this.allowTrailingDot = false,
    this.allowProtocolRelativeUrls = false,
    this.allowFragments = true,
    this.allowQueryComponents = true,
    this.validateLength = true,
    this.disallowAuth = false,
    this.hostWhitelist = const [],
    this.hostBlacklist = const [],
  });
}

final wrappedIpv6 = RegExp(r'^\[([^\]]+)\](?::([0-9]+))?$');

bool isRegExp(dynamic obj) {
  return obj is RegExp;
}

bool checkHost(String host, List<dynamic> matches) {
  for (int i = 0; i < matches.length; i++) {
    dynamic match = matches[i];
    if (host == match || (isRegExp(match) && match.hasMatch(host))) {
      return true;
    }
  }
  return false;
}

bool $isURL(String? url, {UrlOptions? options}) {
  if (url == null || url.isEmpty || RegExp(r'[\s<>]').hasMatch(url)) {
    return false;
  }
  if (url.indexOf('mailto:') == 0) {
    return false;
  }
  options = options ?? UrlOptions();

  if (options.validateLength && url.length >= 2083) {
    return false;
  }

  if (!options.allowFragments && url.contains('#')) {
    return false;
  }

  if (!options.allowQueryComponents &&
      (url.contains('?') || url.contains('&'))) {
    return false;
  }

  String? portStr, ipv6, host;
  int port;
  String protocol, auth, hostname;

  var split = url.split('#');
  url = split.removeAt(0);

  split = url.split('?');
  url = split.removeAt(0);

  split = url.split('://');

  if (split.length > 1) {
    protocol = split.removeAt(0).toLowerCase();
    if (options.requireValidProtocol && !options.protocols.contains(protocol)) {
      return false;
    }
  } else if (options.requireProtocol) {
    return false;
  } else if (url.substring(0, 2) == '//') {
    if (!options.allowProtocolRelativeUrls) {
      return false;
    }
    split[0] = url.substring(2);
  }
  url = split.join('://');

  if (url == '') {
    return false;
  }

  split = url.split('/');
  url = split.removeAt(0);

  if (url == '' && !options.requireHost) {
    return true;
  }

  split = url.split('@');

  if (split.length > 1) {
    if (options.disallowAuth) {
      return false;
    }
    if (split[0] == '') {
      return false;
    }
    auth = split.removeAt(0);
    if (auth.contains(':') && auth.split(':').length > 2) {
      return false;
    }

    var authSplit = auth.split(':');
    var user = authSplit.get(0);
    var password = authSplit.get(1);
    if (user.isNullOrEmpty && password.isNullOrEmpty) {
      return false;
    }
  }
  hostname = split.join('@');

  var ipv6Match = wrappedIpv6.matchAsPrefix(hostname);

  if (ipv6Match != null) {
    host = '';
    ipv6 = ipv6Match.group(1)!;
    portStr = ipv6Match.group(2);
  } else {
    split = hostname.split(':');
    host = split.removeAt(0);
    if (split.isNotEmpty) {
      portStr = split.join(':');
    }
  }

  if (portStr != null && portStr.isNotEmpty) {
    port = int.tryParse(portStr) ?? 0;
    if (!RegExp(r'^[0-9]+$').hasMatch(portStr) || port <= 0 || port > 65535) {
      return false;
    }
  } else if (options.requirePort) {
    return false;
  }

  if (options.hostWhitelist.isNotEmpty) {
    return checkHost(host, options.hostWhitelist);
  }

  if (host == '' && !options.requireHost) {
    return true;
  }

  if (!$isIP(host) &&
      !$isFQDN(host,
          options: FqdnOptions(
            requireTld: options.requireTld,
            allowTrailingDot: options.allowTrailingDot,
            allowUnderscores: options.allowUnderscores,
          )) &&
      (ipv6 == null || !$isIP(ipv6, version: 6))) {
    return false;
  }

  // host = host ?? ipv6;

  if (options.hostBlacklist.isNotEmpty &&
      checkHost(host, options.hostBlacklist)) {
    return false;
  }

  return true;
}
