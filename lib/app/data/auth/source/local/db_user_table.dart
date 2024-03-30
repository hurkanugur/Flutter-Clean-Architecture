abstract class DBUserTable {
  // Table Name
  static const String tableName = 'user';

  // Table Column
  static const String id = 'id';
  static const String username = 'username';
  static const String age = 'age';

  /// Returns the query for creating table.
  static String createTableQuery() {
    String query = 'CREATE TABLE $tableName (';
    query += '$id INTEGER PRIMARY KEY AUTOINCREMENT, ';
    query += '$username VARCHAR(4000) NOT NULL, ';
    query += '$age INTEGER NOT NULL)';
    return query;
  }

  /// Adds or updates a user.
  Future<void> saveUser({required String username, required int age});

  /// Returns the user id by [username].
  ///
  /// Returns `null` when the operation fails.
  Future<int?> getIdByUsername({required String? username});

  /// Prints the all table records.
  Future<void> printAll();

  /// Deletes all of the users.
  Future<void> deleteAllUsers();

  /// This method is used to delete a user by [username].
  Future<void> deleteUser({required String username});
}
