import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clean_architecture/core/directory/service/directory_service.dart';
import 'package:clean_architecture/core/platform_channel/provider/platform_channel_provider.dart';
import 'package:clean_architecture/core/platform_channel/service/platform_channel_downloader_service.dart';

class DirectoryProvider {
  const DirectoryProvider._();

  /// Provider for [PlatformChannelDownloaderService].
  static final directoryServiceProvider = Provider<DirectoryService>((ref) {
    return DirectoryService(
      platformChannelDownloaderService: ref.watch(PlatformChannelProvider.platformChannelDownloaderServiceProvider),
    );
  });
}
