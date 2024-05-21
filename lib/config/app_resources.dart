class AppResources {
  const AppResources._();

  /// Base URL for the OpenWeatherMap API.
  static const String baseUrl = 'http://api.openweathermap.org/data/2.5';

  /// Web certificate paths.
  static const List<String> webCertificatePaths = [
    'assets/certs/google.com.cer',
  ];

  /// The file path for the English translation file.
  static const String englishTranslationFilePath = 'assets/translations/en.json';

  /// The file path for the Turkish translation file.
  static const String turkishTranslationFilePath = 'assets/translations/tr.json';

  /// https://lottiefiles.com/animations/little-sun-AwD33kTUJR?from=search
  static const String lottieLoadingAnimationPath = 'assets/lottie/loading_animation.json';

  /// URL: https://lottiefiles.com/animations/wind-icon-wdUwYp3r2m?from=search
  static const String lottieNoResultsAnimationPath = 'assets/lottie/no_results_animation.json';
}
