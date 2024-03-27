import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/error/model/failure.dart';
import 'package:clean_architecture/core/log/extension/log_extension.dart';

class ClientFailure extends Failure {
  final ClientExceptionType clientExceptionType;

  ClientFailure({
    required super.stackTrace,
    required super.thrownErrorOrException,
    required this.clientExceptionType,
  }) {
    super.stackTrace.printErrorMessage(failure: this);
  }

  @override
  List<Object?> get props => [stackTrace, thrownErrorOrException, clientExceptionType];

  @override
  ClientFailure copyWith({
    StackTrace? stackTrace,
    Object? thrownErrorOrException,
    ClientExceptionType? clientExceptionType,
  }) {
    return ClientFailure(
      stackTrace: stackTrace ?? this.stackTrace,
      thrownErrorOrException: thrownErrorOrException ?? this.thrownErrorOrException,
      clientExceptionType: clientExceptionType ?? this.clientExceptionType,
    );
  }
}
