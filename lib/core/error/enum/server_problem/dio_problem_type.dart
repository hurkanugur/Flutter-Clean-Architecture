import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';
import 'package:dio/dio.dart';

enum DioProblemType {
  connectionTimeout('CONNECTION_TIMEOUT'),
  sendTimeout('SEND_TIMEOUT'),
  receiveTimeout('RECEIVE_TIMEOUT'),
  badCertificate('BAD_CERTIFICATE'),
  badResponse('BAD_RESPONSE'),
  cancel('CANCEL'),
  connectionError('CONNECTION'),
  unknown('UNKNOWN');

  final String name;

  const DioProblemType(this.name);

  /// Creates a [DioProblemType] from [dioExceptionType].
  ///
  /// Throws a [ClientFailure] when an error occurs.
  DioProblemType findByDioException({required DioExceptionType dioExceptionType}) {
    try {
      return values.firstWhere((element) => element.name == dioExceptionType.name);
    } catch (errorOrException) {
      throw ClientFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: errorOrException,
        clientExceptionType: ClientExceptionType.enumNotFoundError,
      );
    }
  }
}
