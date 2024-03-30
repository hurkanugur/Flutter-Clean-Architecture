import 'package:clean_architecture/app/data/auth/source/local/db_user_table.dart';
import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';
import 'package:equatable/equatable.dart';

class DBUserTableDTO extends Equatable {
  final String username;
  final int age;

  const DBUserTableDTO({
    required this.username,
    required this.age,
  });

  @override
  List<Object?> get props => [username, age];

  factory DBUserTableDTO.fromJson({required Map<String, Object?> json}) {
    try {
      return DBUserTableDTO(
        username: json[DBUserTable.username] as String,
        age: json[DBUserTable.age] as int,
      );
    } catch (ex) {
      throw ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        exception: ex,
        clientExceptionType: ClientExceptionType.deserializationError,
      );
    }
  }

  Map<String, Object?> toJson() {
    try {
      return {
        DBUserTable.username: username,
        DBUserTable.age: age,
      };
    } catch (ex) {
      throw ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        exception: ex,
        clientExceptionType: ClientExceptionType.serializationError,
      );
    }
  }
}
