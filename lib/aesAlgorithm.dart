import 'package:encrypt/encrypt.dart' as encrypt;

class AESAlgorithm {
  static final key = encrypt.Key.fromUtf8('9999988888777776'); // 128-bit key
  static final iv = encrypt.IV.fromUtf8('0123456789abcdef'); // 128-bit IV

  static String encryptData(String plainText) {
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  static String decryptData(String encryptedText) {
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
    return decrypted;
  }
}
