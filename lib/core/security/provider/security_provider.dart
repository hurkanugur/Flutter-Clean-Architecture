import 'package:clean_architecture/core/security/service/data_security_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecurityProvider {
  const SecurityProvider._();

  /// Provider for [DataSecurityService].
  static final dataSecurityServiceProvider = Provider<DataSecurityService>((ref) {
    return const DataSecurityService();
  });
}
