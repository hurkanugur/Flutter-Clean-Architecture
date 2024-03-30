import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';

class EncryptionDTO {
  final String cipherText;
  final String base64Key;
  final String base64IV;

  const EncryptionDTO({
    required this.cipherText,
    required this.base64Key,
    required this.base64IV,
  });

  /// Creates a [EncryptionDTO] from [json].
  ///
  /// Throws [ClientFailure] when an error occurs.
  factory EncryptionDTO.fromJson({required Map<String, dynamic> json}) {
    try {
      return EncryptionDTO(
        cipherText: json['cipherText'],
        base64Key: json['base64Key'],
        base64IV: json['base64IV'],
      );
    } catch (ex) {
      throw ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.deserializationError,
        exception: ex,
      );
    }
  }

  /// Converts the [EncryptionDTO] to a [Map].
  ///
  /// Throws [ClientFailure] when an error occurs.
  Map<String, dynamic> toJson() {
    try {
      return {
        'cipherText': cipherText,
        'base64Key': base64Key,
        'base64IV': base64IV,
      };
    } catch (ex) {
      throw ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.serializationError,
        exception: ex,
      );
    }
  }
}
