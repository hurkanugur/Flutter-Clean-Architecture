import 'package:clean_architecture/core/storage/service/shared_preference_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StorageProvider {
  const StorageProvider._();

  /// Provider for [SharedPreferenceService].
  static final sharedPreferenceServiceProvider = Provider<SharedPreferenceService>((ref) {
    throw UnimplementedError();
  });
}
