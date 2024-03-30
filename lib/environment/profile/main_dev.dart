import 'package:clean_architecture/config/app_config.dart';
import 'package:clean_architecture/environment/enum/flavor_type.dart';
import 'package:clean_architecture/environment/model/flavor_config_model.dart';
import 'package:clean_architecture/main.dart' as common;

void main() {
  AppConfig.environment = const FlavorConfigModel(
    flavorType: FlavorType.dev,
    appName: 'Clean Architecture (Dev)',
    bundleID: 'com.example.clean_architecture.dev',
    server: 'localhost:4000',
    allowUsingHTTP: true,
  );

  common.main();
}
