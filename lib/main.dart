import 'package:clean_architecture/app/data/auth/provider/auth_provider.dart';
import 'package:clean_architecture/config/app_config.dart';
import 'package:clean_architecture/core/api/provider/api_provider.dart';
import 'package:clean_architecture/core/api/service/http_service.dart';
import 'package:clean_architecture/core/loading/provider/loading_provider.dart';
import 'package:clean_architecture/core/loading/widget/loading_lottie_animation.dart';
import 'package:clean_architecture/core/localization/enum/language_type.dart';
import 'package:clean_architecture/core/localization/provider/localization_provider.dart';
import 'package:clean_architecture/core/router/extension/router_extension.dart';
import 'package:clean_architecture/core/security/provider/security_provider.dart';
import 'package:clean_architecture/core/storage/provider/storage_provider.dart';
import 'package:clean_architecture/core/storage/service/database_service.dart';
import 'package:clean_architecture/core/storage/service/shared_preference_service.dart';
import 'package:clean_architecture/core/theme/constants/dark_theme_constants.dart';
import 'package:clean_architecture/core/theme/constants/light_theme_constants.dart';
import 'package:clean_architecture/core/theme/provider/theme_provider.dart';
import 'package:clean_architecture/environment/enum/flavor_type.dart';
import 'package:clean_architecture/environment/model/flavor_config_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  // TODO: Delete this manually set environment variable in the future.
  AppConfig.environment = const FlavorConfigModel(
    flavorType: FlavorType.dev,
    appName: 'Clean Architecture (Dev)',
    bundleID: 'com.example.clean_architecture.dev',
    server: 'localhost:4000',
    allowUsingHTTP: true,
  );

  WidgetsFlutterBinding.ensureInitialized();

  final ProviderContainer providerContainer = ProviderContainer();

  final SharedPreferenceService sharedPreferenceService = SharedPreferenceService(
    sharedPreferences: await SharedPreferences.getInstance(),
    dataSecurityService: providerContainer.read(SecurityProvider.dataSecurityServiceProvider),
  );

  final localizationController = providerContainer.read(LocalizationProvider.localizationControllerProvider.notifier);
  await localizationController.changeLanguage(
    languageType: sharedPreferenceService.getLanguageType(),
    ref: null,
  );

  final themeController = providerContainer.read(ThemeProvider.themeControllerProvider.notifier);
  themeController.changeTheme(
    themeMode: sharedPreferenceService.getThemeMode(),
    ref: null,
  );

  final DatabaseService databaseService = providerContainer.read(StorageProvider.databaseServiceProvider);
  await databaseService.createAndOpenDatabase();

  final HttpService httpService = await HttpService.createInstance();

  runApp(
    ProviderScope(
      overrides: [
        StorageProvider.sharedPreferenceServiceProvider.overrideWithValue(sharedPreferenceService),
        LocalizationProvider.localizationControllerProvider.overrideWith((ref) => localizationController),
        ThemeProvider.themeControllerProvider.overrideWith((ref) => themeController),
        StorageProvider.databaseServiceProvider.overrideWith((ref) => databaseService),
        ApiProvider.httpServiceProvider.overrideWithValue(httpService),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loadingState = ref.watch(LoadingProvider.loadingControllerProvider);
    final localizationState = ref.watch(LocalizationProvider.localizationControllerProvider);
    final themeState = ref.watch(ThemeProvider.themeControllerProvider);
    _dummyUserAuth(ref: ref);

    return LoadingLottieAnimation(
      isLoading: loadingState.isLoading,
      child: MaterialApp.router(
        title: AppConfig.environment.appName,
        themeMode: themeState.themeMode,
        theme: LightThemeConstants.themeData,
        darkTheme: DarkThemeConstants.themeData,
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        builder: (BuildContext context, Widget? child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: Localizations.override(
            context: context,
            locale: localizationState.languageType.getLocale(),
            child: child,
          ),
        ),
        supportedLocales: LanguageType.values.map((e) => e.getLocale()),
        locale: localizationState.languageType.getLocale(),
        debugShowCheckedModeBanner: false,
        routerConfig: RouterExtension.goRouter,
      ),
    );
  }

  Future<void> _dummyUserAuth({required WidgetRef ref}) async {
    ref.read(AuthProvider.dbUserTableProvider).saveUser(username: AppConfig.defaultUsername, age: 18);
  }
}
