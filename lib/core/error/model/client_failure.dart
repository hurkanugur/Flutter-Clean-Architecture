import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/error/model/failure.dart';
import 'package:clean_architecture/core/log/extension/log_extension.dart';

class ClientFailure extends Failure {
  final ClientExceptionType clientExceptionType;

  const ClientFailure({
    required super.stackTrace,
    super.exception,
    required this.clientExceptionType,
  });

  @override
  List<Object?> get props => [stackTrace, exception, clientExceptionType];

  @override
  ClientFailure copyWith({
    StackTrace? stackTrace,
    Object? exception,
    ClientExceptionType? clientExceptionType,
  }) {
    return ClientFailure(
      stackTrace: stackTrace ?? this.stackTrace,
      exception: exception ?? this.exception,
      clientExceptionType: clientExceptionType ?? this.clientExceptionType,
    );
  }

  /// Creates a [ClientFailure] and logs the failure.
  factory ClientFailure.createAndLog({
    required StackTrace stackTrace,
    required ClientExceptionType clientExceptionType,
    Object? exception,
  }) {
    final ClientFailure clientFailure = ClientFailure(
      stackTrace: stackTrace,
      exception: exception,
      clientExceptionType: clientExceptionType,
    );

    stackTrace.printErrorMessageByFailure(failure: clientFailure);
    return clientFailure;
  }
}
