import 'dart:io';

import 'package:clean_architecture/app/data/auth/source/local/db_user_table.dart';
import 'package:clean_architecture/app/data/weather/source/local/db_weather_table.dart';
import 'package:clean_architecture/config/app_config.dart';
import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';
import 'package:clean_architecture/core/localization/enum/text_type.dart';
import 'package:clean_architecture/core/log/extension/log_extension.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final String _databaseName = '${AppConfig.environment.bundleID}.db';

  Database? database;

  DatabaseService({required this.database});

  /// This method initializes and opens the [database].
  Future<void> createAndOpenDatabase() async {
    try {
      await _createDatabaseFolderIfNotExist();
      await _closeDatabase();

      database = await openDatabase(
        await _getDatabaseFullPath(),
        version: 1,
        onConfigure: (Database db) async {
          await db.execute('PRAGMA foreign_keys = ON');
        },
        onCreate: (Database db, int version) async {
          await db.execute(DBUserTable.createTableQuery());
          await db.execute(DBWeatherTable.createTableQuery());
        },
      );

      if (database?.isOpen == true) {
        StackTrace.current.printSuccessMessage(textType: TextType.databaseOpenOperationSuccess);
      } else {
        ClientFailure.createAndLog(
          stackTrace: StackTrace.current,
          clientExceptionType: ClientExceptionType.databaseCouldNotBeOpenedError,
        );
      }
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        exception: ex,
        clientExceptionType: ClientExceptionType.databaseCouldNotBeOpenedError,
      );
    }
  }

  /// This method returns the full path of the database.
  Future<String> _getDatabaseFullPath() async {
    final String databasePath = await getDatabasesPath();

    return '$databasePath/$_databaseName';
  }

  /// This method creates the database folder if already not exists.
  Future<void> _createDatabaseFolderIfNotExist() async {
    final String databasePath = await getDatabasesPath();

    try {
      await Directory(databasePath).create(recursive: true);
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        exception: ex,
        clientExceptionType: ClientExceptionType.databaseFolderNotFoundError,
      );
    }
  }

  /// This method returns the size of the database.
  Future<int> getDatabaseSize() async {
    try {
      await _createDatabaseFolderIfNotExist();
      final Directory tempDir = Directory(await getDatabasesPath());
      final List<FileSystemEntity> systemEntities = tempDir.listSync(recursive: true, followLinks: false);

      int size = 0;

      for (FileSystemEntity entity in systemEntities) {
        if (entity is File) {
          size += await entity.length();
        }
      }

      return size;
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        exception: ex,
        clientExceptionType: ClientExceptionType.fileReadOperationError,
      );
    }

    return 0;
  }

  /// This method is used to delete the [database].
  ///
  /// Note that this doesn't delete externally stored data.
  Future<void> deleteDatabaseFromExternalStorage() async {
    final String databaseFullPath = await _getDatabaseFullPath();
    final bool dbExists = await databaseExists(databaseFullPath);

    await _closeDatabase();

    if (dbExists) {
      await deleteDatabase(databaseFullPath);
      StackTrace.current.printSuccessMessage(textType: TextType.databaseDeleteOperationSuccess);
    }
  }

  /// This method closes the database.
  Future<void> _closeDatabase() async {
    if (database?.isOpen == true) {
      await database?.close();
      database = null;
      StackTrace.current.printSuccessMessage(textType: TextType.databaseCloseOperationSuccess);
    }
  }
}
