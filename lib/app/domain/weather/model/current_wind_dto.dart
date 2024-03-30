import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';
import 'package:equatable/equatable.dart';

class CurrentWindDTO extends Equatable {
  final double? speed;
  final double? deg;
  final double? gust;

  const CurrentWindDTO({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  @override
  List<Object?> get props => [speed, deg, gust];

  /// Creates a [CurrentWindDTO] from [json].
  ///
  /// Throws a [ClientFailure] when an error occurs.
  factory CurrentWindDTO.fromJson({required Map<String, dynamic> json}) {
    try {
      return CurrentWindDTO(
        speed: json['speed'] == null ? null : double.tryParse(json['speed'].toString()),
        deg: json['deg'] == null ? null : double.tryParse(json['deg'].toString()),
        gust: json['gust'] == null ? null : double.tryParse(json['gust'].toString()),
      );
    } on ClientFailure {
      rethrow;
    } catch (ex) {
      throw ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        exception: ex,
        clientExceptionType: ClientExceptionType.deserializationError,
      );
    }
  }

  /// Converts the DTO to JSON.
  ///
  /// Throws a [ClientFailure] when an error occurs.
  Map<String, dynamic> toJson() {
    try {
      return {
        'speed': speed,
        'deg': deg,
        'gust': gust,
      };
    } on ClientFailure {
      rethrow;
    } catch (ex) {
      throw ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        exception: ex,
        clientExceptionType: ClientExceptionType.serializationError,
      );
    }
  }
}
