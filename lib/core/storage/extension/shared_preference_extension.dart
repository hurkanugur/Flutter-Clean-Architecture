import 'package:clean_architecture/core/storage/provider/storage_provider.dart';
import 'package:clean_architecture/core/storage/service/shared_preference_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension SharedPreferenceExtension on WidgetRef {
  /// A getter for [SharedPreferenceService].
  SharedPreferenceService get sharedPreference => read(StorageProvider.sharedPreferenceServiceProvider);
}
