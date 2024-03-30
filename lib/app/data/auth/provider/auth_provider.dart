import 'package:clean_architecture/app/data/auth/source/local/db_user_table.dart';
import 'package:clean_architecture/app/data/auth/source/local/db_user_table_impl.dart';
import 'package:clean_architecture/core/storage/provider/storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthProvider {
  const AuthProvider._();

  // Local Data Source Providers

  /// Provider for [DBUserTable].
  static final dbUserTableProvider = Provider<DBUserTable>((ref) {
    return DBUserTableImpl(
      databaseService: ref.watch(StorageProvider.databaseServiceProvider),
    );
  });
}
