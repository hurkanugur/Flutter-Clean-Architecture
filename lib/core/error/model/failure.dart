import 'package:equatable/equatable.dart';

class Failure extends Equatable implements Exception {
  final StackTrace stackTrace;

  final Object? thrownErrorOrException;

  const Failure({
    required this.thrownErrorOrException,
    required this.stackTrace,
  });

  @override
  List<Object?> get props => [stackTrace, thrownErrorOrException];

  /// Creates a copy of this class.
  Failure copyWith({
    StackTrace? stackTrace,
    Object? thrownErrorOrException,
  }) {
    return Failure(
      thrownErrorOrException: thrownErrorOrException ?? this.thrownErrorOrException,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}
