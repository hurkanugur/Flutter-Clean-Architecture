import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';

class DataSecurityService {
  const DataSecurityService();

  /// Hashes the [text] using SHA-256.
  ///
  /// Returns `null` when the hashing algorithm fails.
  String? hash({required String text}) {
    try {
      final Digest computedHash = sha256.convert(utf8.encode(text));
      return computedHash.toString().toUpperCase();
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.hashError,
        exception: ex,
      );
    }

    return null;
  }

  /// Encrypts the given [plainText] using AES-256.
  ///
  /// Returns `null` when the encryption fails.
  String? encrypt({required String plainText}) {
    try {
      final Key key = Key.fromLength(16);
      final IV iv = IV.fromLength(16);
      final Encrypter encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
      final Encrypted encrypted = encrypter.encrypt(plainText, iv: iv);
      return encrypted.base64;
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.encryptionError,
        exception: ex,
      );
    }

    return null;
  }

  /// Decrypts the given [chiperText] using AES-256.
  ///
  /// Returns `null` when the decryption fails.
  String? decrypt({required String chiperText}) {
    try {
      final Key key = Key.fromLength(16);
      final IV iv = IV.fromLength(16);
      final Encrypted encrypted = Encrypted.from64(chiperText);
      final Encrypter encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));

      final String plainText = encrypter.decrypt(encrypted, iv: iv);
      return plainText;
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.decryptionError,
        exception: ex,
      );
    }

    return null;
  }
}
