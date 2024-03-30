import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clean_architecture/core/network/service/network_service.dart';

class NetworkProvider {
  const NetworkProvider._();

  /// Provider for [NetworkService].
  static final networkServiceProvider = Provider<NetworkService>((ref) {
    return NetworkService(connectivity: Connectivity());
  });
}
