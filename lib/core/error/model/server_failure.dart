import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/error/enum/server/server_exception_type.dart';
import 'package:clean_architecture/core/error/enum/server_problem/unknown_problem_type.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';
import 'package:clean_architecture/core/error/model/failure.dart';
import 'package:clean_architecture/core/log/extension/log_extension.dart';
import 'package:dio/dio.dart';

class ServerFailure extends Failure {
  final ServerExceptionType serverExceptionType;
  final Enum serverProblemType;
  final int? statusCode;

  const ServerFailure({
    required super.stackTrace,
    required super.exception,
    required this.serverExceptionType,
    required this.serverProblemType,
    required this.statusCode,
  });

  @override
  List<Object?> get props => [stackTrace, exception, serverExceptionType, serverProblemType, statusCode];

  @override
  ServerFailure copyWith({
    StackTrace? stackTrace,
    Object? exception,
    ServerExceptionType? serverExceptionType,
    Enum? serverProblemType,
    int? statusCode,
  }) {
    return ServerFailure(
      stackTrace: stackTrace ?? this.stackTrace,
      exception: exception ?? this.exception,
      serverExceptionType: serverExceptionType ?? this.serverExceptionType,
      serverProblemType: serverProblemType ?? this.serverProblemType,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  /// Creates a [ServerFailure] and logs the failure.
  factory ServerFailure.createAndLog({
    required StackTrace stackTrace,
    required Object? exception,
    required ServerExceptionType serverExceptionType,
    required Enum serverProblemType,
    required int? statusCode,
  }) {
    final ServerFailure serverFailure = ServerFailure(
      stackTrace: stackTrace,
      exception: exception,
      serverExceptionType: serverExceptionType,
      serverProblemType: serverProblemType,
      statusCode: statusCode,
    );

    stackTrace.printErrorMessageByFailure(failure: serverFailure);
    return serverFailure;
  }

  /// Creates a [ServerFailure] from [response] and logs the failure.
  factory ServerFailure.createAndLogFromResponseData({
    required StackTrace stackTrace,
    required Response<dynamic>? response,
  }) {
    final ServerFailure serverFailure;

    if (response?.data == null) {
      serverFailure = ServerFailure(
        exception: null,
        stackTrace: stackTrace,
        serverExceptionType: ServerExceptionType.unknownException,
        serverProblemType: UnknownProblemType.nullResponseValueError,
        statusCode: response?.statusCode,
      );
    } else if (response?.data is! Map<String, dynamic>) {
      serverFailure = ServerFailure(
        stackTrace: stackTrace,
        exception: response?.data,
        serverExceptionType: ServerExceptionType.unknownException,
        serverProblemType: UnknownProblemType.unknownException,
        statusCode: response?.statusCode,
      );
    } else {
      serverFailure = _extractException(
        json: response?.data,
        stackTrace: stackTrace,
        statusCode: response?.statusCode,
      );
    }

    stackTrace.printErrorMessageByFailure(failure: serverFailure);
    return serverFailure;
  }

  /// Creates a [ServerFailure] from [dioException] and logs the failure.
  factory ServerFailure.createAndLogFromDioException({
    required StackTrace stackTrace,
    required DioException dioException,
  }) {
    final ServerFailure serverFailure = ServerFailure(
      stackTrace: stackTrace,
      exception: dioException,
      serverExceptionType: ServerExceptionType.dioException,
      serverProblemType: dioException.type,
      statusCode: null,
    );

    stackTrace.printErrorMessageByFailure(failure: serverFailure);
    return serverFailure;
  }

  /// Creates a [ServerFailure] from [json].
  static ServerFailure _extractException({
    required Map<String, dynamic> json,
    required StackTrace stackTrace,
    required int? statusCode,
  }) {
    final ServerFailure? errorFromErrorData = _getErrorFromErrorData(
      errorData: json['error'],
      stackTrace: stackTrace,
      statusCode: statusCode,
    );

    if (errorFromErrorData != null) {
      return errorFromErrorData;
    }

    final ServerFailure? errorFromString = _createErrorDTOFromString(
      errorString: json['message'],
      stackTrace: stackTrace,
      statusCode: statusCode,
    );

    if (errorFromString != null) {
      return errorFromString;
    }

    return ServerFailure(
      stackTrace: stackTrace,
      exception: json,
      serverExceptionType: ServerExceptionType.unknownException,
      serverProblemType: UnknownProblemType.unknownException,
      statusCode: statusCode,
    );
  }

  /// Creates a [ServerFailure] from [errorData].
  static ServerFailure? _getErrorFromErrorData({
    required dynamic errorData,
    required StackTrace stackTrace,
    required int? statusCode,
  }) {
    if (errorData == null) {
      return null;
    }

    if (errorData is Map<String, dynamic>) {
      final ServerExceptionType? serverExceptionType = ServerExceptionType.getServerExceptionByName(serverExceptionName: errorData['type']);
      final Enum? serverProblemType = serverExceptionType?.getProblemByName(serverProblemName: errorData['problem']);

      if (serverExceptionType != null && serverProblemType != null) {
        return ServerFailure(
          stackTrace: stackTrace,
          exception: null,
          serverExceptionType: serverExceptionType,
          serverProblemType: serverProblemType,
          statusCode: statusCode,
        );
      }
    } else if (errorData is String) {
      return _createErrorDTOFromString(
        errorString: errorData,
        stackTrace: stackTrace,
        statusCode: statusCode,
      );
    }

    return null;
  }

  /// Creates a [ServerFailure] from [errorString].
  static ServerFailure? _createErrorDTOFromString({
    required dynamic errorString,
    required StackTrace stackTrace,
    required int? statusCode,
  }) {
    if (errorString == null || errorString is! String || errorString.isEmpty || !errorString.contains('Type=') || !errorString.contains('Problem=')) {
      return null;
    }

    try {
      final String serverSideExceptionName = errorString.substring(errorString.indexOf('Type=') + 5, errorString.indexOf(',')).trim().replaceAll(' ', '_').toUpperCase();
      final String serverSideProblemName = errorString.substring(errorString.indexOf('Problem=') + 8, errorString.indexOf(']')).trim().replaceAll(' ', '_').toUpperCase();

      final ServerExceptionType? serverExceptionType = ServerExceptionType.getServerExceptionByName(serverExceptionName: serverSideExceptionName);
      final Enum? serverProblemType = serverExceptionType?.getProblemByName(serverProblemName: serverSideProblemName);

      if (serverExceptionType != null && serverProblemType != null) {
        return ServerFailure(
          stackTrace: stackTrace,
          exception: null,
          serverExceptionType: serverExceptionType,
          serverProblemType: serverProblemType,
          statusCode: statusCode,
        );
      }
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        exception: ex,
        clientExceptionType: ClientExceptionType.stringOperationError,
      );
    }
    return null;
  }
}
