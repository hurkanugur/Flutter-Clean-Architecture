import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  final Connectivity _connectivity;

  List<ConnectivityResult> _connectionList;

  NetworkService({required Connectivity connectivity})
      : _connectivity = connectivity,
        _connectionList = const [] {
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> result) {
      _connectionList = result;
    });
  }

  /// Returns `true` when there is a network connection.
  bool isOnline() {
    return _connectionList.contains(ConnectivityResult.mobile) || _connectionList.contains(ConnectivityResult.ethernet) || _connectionList.contains(ConnectivityResult.vpn) || _connectionList.contains(ConnectivityResult.wifi);
  }

  /// Returns `true` when there is no network connection.
  bool isOffline() {
    return !isOnline();
  }

  /// Returns `true` while using cellular data.
  bool isUsingCellularData() {
    return _connectionList.contains(ConnectivityResult.mobile);
  }
}
