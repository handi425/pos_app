import 'dart:convert';

import 'package:crypto/crypto.dart';

class PinHasher {
  const PinHasher._();

  static String hash(String pin) {
    final bytes = utf8.encode(pin);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static bool verify(String pin, String hashed) {
    return hash(pin) == hashed;
  }
}
