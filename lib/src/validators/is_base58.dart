// Accepted chars - 123456789ABCDEFGH JKLMN PQRSTUVWXYZabcdefghijk mnopqrstuvwxyz
final base58Reg = RegExp(r'^[A-HJ-NP-Za-km-z1-9]*$');

bool $isBase58(String str) {
  return base58Reg.hasMatch(str);
}
