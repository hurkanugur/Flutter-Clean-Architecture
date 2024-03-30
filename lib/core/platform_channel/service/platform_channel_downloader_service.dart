import 'package:flutter/services.dart';
import 'package:clean_architecture/config/app_config.dart';

class PlatformChannelDownloaderService {
  static final MethodChannel _platformChannel = MethodChannel(AppConfig.environment.bundleID);
  static const String _savePlatformFileMethodName = 'download';

  const PlatformChannelDownloaderService();

  /// Downloads the file.
  ///
  /// Returns `true` when the operation is fulfilled.
  Future<bool> download({
    required String fileName,
    required Uint8List data,
    required String mimeType,
  }) async {
    final Map<String, dynamic> fileStorageMap = {
      "fileName": fileName,
      "data": data,
      'mimeType': mimeType,
    };
    final bool boolResult = await _platformChannel.invokeMethod(
      _savePlatformFileMethodName,
      fileStorageMap,
    );
    return boolResult;
  }
}
