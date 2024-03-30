import 'package:clean_architecture/app/data/auth/model/db_user_table_dto.dart';
import 'package:clean_architecture/app/data/auth/source/local/db_user_table.dart';
import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';
import 'package:clean_architecture/core/localization/enum/text_type.dart';
import 'package:clean_architecture/core/log/extension/log_extension.dart';
import 'package:clean_architecture/core/storage/service/database_service.dart';
import 'package:sqflite/sqflite.dart';

class DBUserTableImpl implements DBUserTable {
  final DatabaseService _databaseService;

  const DBUserTableImpl({
    required DatabaseService databaseService,
  }) : _databaseService = databaseService;

  Future<void> _insertRow({required DBUserTableDTO item}) async {
    final int? result = await _databaseService.database?.insert(
      DBUserTable.tableName,
      item.toJson(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );

    if (result == null || result == 0) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.databaseInsertRowOperationError,
      );
    } else {
      StackTrace.current.printSuccessMessage(textType: TextType.databaseInsertRowOperationSuccess);
    }
  }

  Future<void> _updateRow({required DBUserTableDTO item, required int rowId}) async {
    final int? result = await _databaseService.database?.update(
      DBUserTable.tableName,
      {
        ...item.toJson(),
        DBUserTable.id: rowId,
      },
      where: '${DBUserTable.id} = ?',
      whereArgs: [rowId],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (result == null || result == 0) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.databaseUpdateRowOperationError,
      );
    } else {
      StackTrace.current.printSuccessMessage(textType: TextType.databaseUpdateRowOperationSuccess);
    }
  }

  @override
  Future<void> saveUser({required String username, required int age}) async {
    final int? rowId = await getIdByUsername(username: username.toLowerCase());

    final DBUserTableDTO item = DBUserTableDTO(
      username: username.toLowerCase(),
      age: age,
    );

    if (rowId == null) {
      await _insertRow(item: item);
    } else {
      await _updateRow(item: item, rowId: rowId);
    }
  }

  @override
  Future<int?> getIdByUsername({required String? username}) async {
    if (username == null) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.nullPointerError,
      );

      return null;
    }

    final results = await _databaseService.database?.query(
      DBUserTable.tableName,
      columns: [
        DBUserTable.id,
        DBUserTable.username,
      ],
      where: '${DBUserTable.username} = ?',
      whereArgs: [
        username.toLowerCase(),
      ],
    );

    if (results == null || results.isEmpty) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.databaseUserNotFound,
      );

      return null;
    }

    return results.first[DBUserTable.id] as int?;
  }

  @override
  Future<void> printAll() async {
    final results = await _databaseService.database?.query(
      DBUserTable.tableName,
      columns: [
        DBUserTable.id,
        DBUserTable.username,
        DBUserTable.age,
      ],
    );

    if (results == null || results.isEmpty) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.databaseEmptyTableError,
      );

      return;
    }

    StackTrace.current.printSuccessMessage(
      textType: TextType.databaseTable,
      data: results.map((e) => '${DBUserTable.id}: ${e[DBUserTable.id]}, ${DBUserTable.username}: ${e[DBUserTable.username]}, ${DBUserTable.age}: ${e[DBUserTable.age]}'),
    );
  }

  @override
  Future<void> deleteAllUsers() async {
    final results = await _databaseService.database?.query(
      DBUserTable.tableName,
      columns: [
        DBUserTable.username,
      ],
    );

    if (results == null || results.isEmpty) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.databaseDeleteRowOperationError,
      );

      return;
    }

    for (Map<String, Object?> searchMap in results) {
      await deleteUser(username: searchMap[DBUserTable.username] as String);
    }

    StackTrace.current.printSuccessMessage(
      textType: TextType.databaseDeleteOperationSuccess,
      data: results.length,
    );
  }

  @override
  Future<void> deleteUser({required String username}) async {
    /************************************* WARNING *******************************************
    * If you have some data saved in external storage, firstly, you must delete them manually.
    * Since they are save in external storage, CASCADE will not delete them automatically.
    *****************************************************************************************/

    final result = await _databaseService.database?.delete(
      DBUserTable.tableName,
      where: '${DBUserTable.username} = ?',
      whereArgs: [
        username.toLowerCase(),
      ],
    );

    if (result == null || result == 0) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.databaseDeleteRowOperationError,
      );
    } else {
      StackTrace.current.printSuccessMessage(textType: TextType.databaseDeleteOperationSuccess);
    }
  }
}
