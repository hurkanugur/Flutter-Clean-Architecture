import 'package:clean_architecture/config/app_config.dart';
import 'package:clean_architecture/environment/enum/flavor_type.dart';
import 'package:clean_architecture/environment/model/flavor_config_model.dart';
import 'package:clean_architecture/main.dart' as common;

void main() {
  AppConfig.environment = const FlavorConfigModel(
    flavorType: FlavorType.stage,
    appName: 'Clean Architecture (Stage)',
    bundleID: 'com.example.clean_architecture.stg',
    server: 'stage.server.com',
    allowUsingHTTP: false,
  );

  common.main();
}
