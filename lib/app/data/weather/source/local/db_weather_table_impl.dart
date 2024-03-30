import 'dart:convert';

import 'package:clean_architecture/app/data/auth/source/local/db_user_table.dart';
import 'package:clean_architecture/app/data/weather/model/db_weather_table_dto.dart';
import 'package:clean_architecture/app/data/weather/source/local/db_weather_table.dart';
import 'package:clean_architecture/app/domain/weather/model/all_weather_info_dto.dart';
import 'package:clean_architecture/core/directory/service/directory_service.dart';
import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';
import 'package:clean_architecture/core/localization/enum/text_type.dart';
import 'package:clean_architecture/core/log/extension/log_extension.dart';
import 'package:clean_architecture/core/security/service/data_security_service.dart';
import 'package:clean_architecture/core/storage/service/database_service.dart';
import 'package:clean_architecture/core/storage/service/shared_preference_service.dart';
import 'package:sqflite/sqflite.dart';

class DBWeatherTableImpl implements DBWeatherTable {
  final DatabaseService _databaseService;
  final DBUserTable _dbUserTable;
  final DirectoryService _directoryService;
  final DataSecurityService _dataSecurityService;
  final SharedPreferenceService _sharedPreferenceService;

  const DBWeatherTableImpl({
    required DatabaseService databaseService,
    required DBUserTable dbUserTable,
    required DirectoryService directoryService,
    required DataSecurityService dataSecurityService,
    required SharedPreferenceService sharedPreferenceService,
  })  : _databaseService = databaseService,
        _dbUserTable = dbUserTable,
        _directoryService = directoryService,
        _dataSecurityService = dataSecurityService,
        _sharedPreferenceService = sharedPreferenceService;

  /// This method is used to save [allWeatherInfoDTO] in external storage.
  ///
  /// If succeeds, it returns the saved file name.
  Future<String?> _saveWeatherContentIntoExternalStorage({
    required int userId,
    required AllWeatherInfoDTO allWeatherInfoDTO,
  }) async {
    final String fileName = 'all_weather_info_dto_$userId.txt';
    final String encodedJson = jsonEncode(allWeatherInfoDTO.toJson());
    final String? encryptedWeatherContent = _dataSecurityService.encrypt(plainText: encodedJson);

    if (encryptedWeatherContent == null) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.encryptionError,
      );

      return null;
    }

    final String? savedFileName = await _directoryService.savePrivateTextFile(
      fileName: fileName,
      content: encryptedWeatherContent,
    );

    return savedFileName;
  }

  /// Gets the [AllWeatherInfoDTO] from external storage by [weatherContentExternalFileName].
  Future<AllWeatherInfoDTO?> _fetchWeatherContentFromExternalStorage({required String weatherContentExternalFileName}) async {
    final String? encryptedWeatherContent = await _directoryService.readPrivateTextFile(fileName: weatherContentExternalFileName);

    if (encryptedWeatherContent == null) {
      return null;
    }

    final String? encodedJson = _dataSecurityService.decrypt(chiperText: encryptedWeatherContent);

    if (encodedJson == null) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.decryptionError,
      );

      return null;
    }

    try {
      final AllWeatherInfoDTO allWeatherInfoDTO = AllWeatherInfoDTO.fromJson(json: jsonDecode(encodedJson));
      return allWeatherInfoDTO;
    } catch (ex) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.deserializationError,
      );
    }

    return null;
  }

  /// Deletes the [AllWeatherInfoDTO] from external storage.
  Future<void> _deleteWeatherContentFromExternalStorage({required int userId}) async {
    final String fileName = 'all_weather_info_dto_$userId.txt';
    await _directoryService.deletePrivateFile(fileName: fileName);
  }

  Future<int?> _getIdByUserId({required int? userId}) async {
    if (userId == null) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.nullPointerError,
      );

      return null;
    }

    final results = await _databaseService.database?.query(
      DBWeatherTable.tableName,
      columns: [
        DBWeatherTable.id,
        DBWeatherTable.userId,
      ],
      where: '${DBWeatherTable.userId} = ?',
      whereArgs: [
        userId,
      ],
    );

    if (results == null || results.isEmpty) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.databaseReadRowOperationError,
      );

      return null;
    }

    return results.first[DBWeatherTable.id] as int?;
  }

  Future<void> _insertRow({required DBWeatherTableDTO item}) async {
    final int? result = await _databaseService.database?.insert(
      DBWeatherTable.tableName,
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

  Future<void> _updateRow({required DBWeatherTableDTO item, required int rowId}) async {
    final int? result = await _databaseService.database?.update(
      DBWeatherTable.tableName,
      {
        ...item.toJson(),
        DBWeatherTable.id: rowId,
      },
      where: '${DBWeatherTable.id} = ?',
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
  Future<void> saveWeather({required AllWeatherInfoDTO? allWeatherInfoDTO}) async {
    if (allWeatherInfoDTO == null) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.nullPointerError,
      );

      return;
    }

    final String username = _sharedPreferenceService.getPlaintextUsername();
    final int? userId = await _dbUserTable.getIdByUsername(username: username);

    if (userId == null) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.databaseUserNotFound,
      );

      return;
    }

    final int? rowId = await _getIdByUserId(userId: userId);
    final String? filePath = await _saveWeatherContentIntoExternalStorage(
      userId: userId,
      allWeatherInfoDTO: allWeatherInfoDTO,
    );

    if (filePath == null) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.nullPointerError,
      );

      return;
    }

    final DBWeatherTableDTO item = DBWeatherTableDTO(
      userId: userId,
      weatherContentExternalFileName: filePath,
    );

    if (rowId == null) {
      await _insertRow(item: item);
    } else {
      await _updateRow(item: item, rowId: rowId);
    }
  }

  @override
  Future<AllWeatherInfoDTO?> getAllWeatherInfo() async {
    final String username = _sharedPreferenceService.getPlaintextUsername();
    final int? userId = await _dbUserTable.getIdByUsername(username: username);

    if (userId == null) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.nullPointerError,
      );

      return null;
    }

    final results = await _databaseService.database?.query(
      DBWeatherTable.tableName,
      columns: [
        DBWeatherTable.userId,
        DBWeatherTable.weatherContentExternalFileName,
      ],
      where: '${DBWeatherTable.userId} = ?',
      whereArgs: [
        userId,
      ],
    );

    if (results == null || results.isEmpty) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.databaseReadRowOperationError,
      );

      return null;
    }

    final String weatherContentExternalFileName = results.first[DBWeatherTable.weatherContentExternalFileName] as String;
    return await _fetchWeatherContentFromExternalStorage(weatherContentExternalFileName: weatherContentExternalFileName);
  }

  @override
  Future<void> printAll() async {
    final results = await _databaseService.database?.query(
      DBWeatherTable.tableName,
      columns: [
        DBWeatherTable.id,
        DBWeatherTable.weatherContentExternalFileName,
        DBWeatherTable.userId,
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
      data: results.map((e) => '${DBWeatherTable.id}: ${e[DBWeatherTable.id]}, ${DBWeatherTable.weatherContentExternalFileName}: ${e[DBWeatherTable.weatherContentExternalFileName]}, ${DBWeatherTable.userId}: ${e[DBWeatherTable.userId]}'),
    );
  }

  @override
  Future<void> deleteWeather({required String username}) async {
    final String username = _sharedPreferenceService.getPlaintextUsername();
    final int? userId = await _dbUserTable.getIdByUsername(username: username);

    if (userId == null) {
      ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        clientExceptionType: ClientExceptionType.databaseUserNotFound,
      );
      return;
    }

    /************************************* WARNING *******************************************
    * If you have some data saved in external storage, firstly, you must delete them manually.
    * Since they are save in external storage, CASCADE will not delete them automatically.
    *****************************************************************************************/

    await _deleteWeatherContentFromExternalStorage(userId: userId);

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
