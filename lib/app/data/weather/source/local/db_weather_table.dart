import 'package:clean_architecture/app/data/auth/source/local/db_user_table.dart';
import 'package:clean_architecture/app/domain/weather/model/all_weather_info_dto.dart';

abstract class DBWeatherTable {
  // Table Name
  static const String tableName = 'weather';

  // Table Column
  static const String id = 'id';
  static const String weatherContentExternalFileName = 'weather_content_external_file_name';
  static const String userId = 'user_id';

  /// Returns the query for creating table.
  static String createTableQuery() {
    String query = 'CREATE TABLE $tableName (';
    query += '$id INTEGER PRIMARY KEY AUTOINCREMENT, ';
    query += '$weatherContentExternalFileName VARCHAR(4000) NOT NULL, ';
    query += '$userId INTEGER NOT NULL, ';
    query += 'FOREIGN KEY ($userId) REFERENCES ${DBUserTable.tableName} (${DBUserTable.id}) ON DELETE CASCADE ON UPDATE CASCADE)';
    return query;
  }

  /// Adds or updates a weather data.
  Future<void> saveWeather({required AllWeatherInfoDTO? allWeatherInfoDTO});

  /// Returns the weather data.
  ///
  /// Returns `null` when the operation fails.
  Future<AllWeatherInfoDTO?> getAllWeatherInfo();

  /// Prints the all table records.
  Future<void> printAll();

  /// Deletes the weather by [username].
  Future<void> deleteWeather({required String username});
}
