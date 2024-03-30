import 'package:clean_architecture/environment/enum/flavor_type.dart';

class FlavorConfigModel {
  final FlavorType flavorType;
  final String appName;
  final String bundleID;
  final String server;
  final bool allowUsingHTTP;

  const FlavorConfigModel({
    required this.flavorType,
    required this.appName,
    required this.bundleID,
    required this.server,
    required this.allowUsingHTTP,
  });

  bool isDevelopment() {
    return (flavorType == FlavorType.dev);
  }

  bool isStage() {
    return (flavorType == FlavorType.stage);
  }

  bool isProduction() {
    return (flavorType == FlavorType.prod);
  }
}
