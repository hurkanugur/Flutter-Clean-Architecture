import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clean_architecture/core/api/service/http_service.dart';

class ApiProvider {
  const ApiProvider._();

  /// Provider for [HttpService].
  static final httpServiceProvider = Provider<HttpService>((ref) {
    throw UnimplementedError();
  });
}
