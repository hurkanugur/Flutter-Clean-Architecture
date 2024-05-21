import 'package:clean_architecture/app/domain/weather/model/all_weather_info_dto.dart';
import 'package:clean_architecture/app/presentation/weather/provider/weather_view_provider.dart';
import 'package:clean_architecture/config/app_strings.dart';
import 'package:clean_architecture/core/localization/enum/text_type.dart';
import 'package:clean_architecture/core/localization/extension/localization_extension.dart';
import 'package:clean_architecture/core/theme/extension/theme_extension.dart';
import 'package:clean_architecture/config/app_icons.dart';
import 'package:clean_architecture/core/widgets/advanced_no_results_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherInformation extends ConsumerWidget {
  const WeatherInformation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherViewState = ref.watch(WeatherViewProvider.weatherViewControllerProvider);
    final AllWeatherInfoDTO? allWeatherInfoDTO = weatherViewState.allWeatherInfoDTO;

    if (allWeatherInfoDTO == null) {
      return const AdvancedNoResultsAnimation();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          allWeatherInfoDTO.name ?? AppStrings.unknownText,
          style: Theme.of(ref.context).textTheme.headlineLarge?.copyWith(color: context.appColors.transparentWidgetForegroundColor),
        ),
        const SizedBox(height: 16.0),
        Icon(
          allWeatherInfoDTO.weather?.first?.type?.weatherIcon ?? AppIcons.unknownWeatherIcon,
          size: 64.0,
          color: context.appColors.transparentWidgetForegroundColor,
        ),
        const SizedBox(height: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              allWeatherInfoDTO.weather?.first?.description ?? AppStrings.unknownText,
              style: Theme.of(ref.context).textTheme.headlineSmall?.copyWith(color: context.appColors.transparentWidgetForegroundColor),
            ),
            Text(
              '${allWeatherInfoDTO.main?.temp?.toStringAsFixed(1)}${ref.translateText(textType: TextType.celsius)}',
              style: Theme.of(ref.context).textTheme.headlineMedium?.copyWith(color: context.appColors.transparentWidgetForegroundColor),
            ),
          ],
        ),
      ],
    );
  }
}
