import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clean_architecture/core/platform_channel/service/platform_channel_downloader_service.dart';

class PlatformChannelProvider {
  const PlatformChannelProvider._();

  /// Provider for [PlatformChannelDownloaderService].
  static final platformChannelDownloaderServiceProvider = Provider<PlatformChannelDownloaderService>((ref) {
    return const PlatformChannelDownloaderService();
  });
}
