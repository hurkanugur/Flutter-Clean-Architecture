import 'package:clean_architecture/core/error/model/failure.dart';

class OperationResult<T> {
  final T data;
  final List<Failure>? failures;

  const OperationResult({
    required this.data,
    required this.failures,
  });

  bool get hasData => data != null;
  bool get hasFailures => failures?.isNotEmpty == true;

  OperationResult<T> copyWith({
    T? data,
    List<Failure>? failures,
  }) {
    return OperationResult<T>(
      data: data ?? this.data,
      failures: failures ?? this.failures,
    );
  }
}
