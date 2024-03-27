import 'package:clean_architecture/core/api/provider/api_provider.dart';
import 'package:clean_architecture/core/api/service/http_service.dart';
import 'package:clean_architecture/core/loading/provider/loading_provider.dart';
import 'package:clean_architecture/core/loading/widget/loading_lottie_animation.dart';
import 'package:clean_architecture/core/localization/enum/language_type.dart';
import 'package:clean_architecture/core/localization/provider/localization_provider.dart';
import 'package:clean_architecture/core/router/extension/router_extension.dart';
import 'package:clean_architecture/core/storage/provider/storage_provider.dart';
import 'package:clean_architecture/core/storage/service/shared_preference_service.dart';
import 'package:clean_architecture/core/theme/constants/dark_theme_constants.dart';
import 'package:clean_architecture/core/theme/constants/light_theme_constants.dart';
import 'package:clean_architecture/core/theme/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final ProviderContainer providerContainer = ProviderContainer();

  final SharedPreferenceService sharedPreferenceService = await SharedPreferenceService.createInstance();

  final localizationController = providerContainer.read(LocalizationProvider.localizationControllerProvider.notifier);
  await localizationController.changeLanguage(languageType: sharedPreferenceService.getLanguage());

  final themeController = providerContainer.read(ThemeProvider.themeControllerProvider.notifier);
  themeController.themeMode = sharedPreferenceService.getTheme();

  final HttpService httpService = await HttpService.createInstance();

  runApp(
    ProviderScope(
      overrides: [
        StorageProvider.sharedPreferenceServiceProvider.overrideWithValue(sharedPreferenceService),
        LocalizationProvider.localizationControllerProvider.overrideWith((ref) => localizationController),
        ThemeProvider.themeControllerProvider.overrideWith((ref) => themeController),
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

    return LoadingLottieAnimation(
      isLoading: loadingState.isLoading,
      child: MaterialApp.router(
        title: 'Clean Architecture',
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
}
