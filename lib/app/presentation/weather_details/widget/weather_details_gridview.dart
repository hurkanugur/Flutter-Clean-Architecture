import 'package:clean_architecture/app/domain/weather/model/all_weather_info_dto.dart';
import 'package:clean_architecture/app/presentation/weather/provider/weather_view_provider.dart';
import 'package:clean_architecture/config/app_dimensions.dart';
import 'package:clean_architecture/config/app_icons.dart';
import 'package:clean_architecture/config/app_strings.dart';
import 'package:clean_architecture/core/localization/enum/text_type.dart';
import 'package:clean_architecture/core/localization/extension/localization_extension.dart';
import 'package:clean_architecture/core/widgets/advanced_no_results_animation.dart';
import 'package:clean_architecture/core/widgets/advanced_weather_details_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherDetailsGridView extends ConsumerWidget {
  const WeatherDetailsGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherViewState = ref.watch(WeatherViewProvider.weatherViewControllerProvider);
    final AllWeatherInfoDTO? allWeatherInfoDTO = weatherViewState.allWeatherInfoDTO;
    final bool isPortraitMode = MediaQuery.orientationOf(context) == Orientation.portrait;

    if (allWeatherInfoDTO == null) {
      return const AdvancedNoResultsAnimation();
    }

    return GridView.count(
      crossAxisCount: isPortraitMode ? AppDimensions.weatherDetailGridViewPortraitCellSize : AppDimensions.weatherDetailGridViewLandscapeCellSize,
      children: <Widget>[
        if (allWeatherInfoDTO.name != null)
          AdvancedWeatherDetailsCard(
            icon: AppIcons.locationIcon,
            title: ref.translateText(textType: TextType.location),
            subtitle: allWeatherInfoDTO.name ?? AppStrings.unknownText,
          ),
        if (allWeatherInfoDTO.main?.temp != null && allWeatherInfoDTO.weather?.isNotEmpty == true && allWeatherInfoDTO.weather?.first?.type != null)
          AdvancedWeatherDetailsCard(
            icon: allWeatherInfoDTO.weather!.first!.type!.weatherIcon,
            title: ref.translateText(textType: TextType.temperature),
            subtitle: (allWeatherInfoDTO.main?.temp?.toString() ?? AppStrings.unknownText) + ref.translateText(textType: TextType.celsius),
          ),
        if (allWeatherInfoDTO.main?.feelsLike != null && allWeatherInfoDTO.main?.temp != null && allWeatherInfoDTO.weather?.isNotEmpty == true && allWeatherInfoDTO.weather?.first?.type != null)
          AdvancedWeatherDetailsCard(
            icon: allWeatherInfoDTO.weather!.first!.type!.weatherIcon,
            title: ref.translateText(textType: TextType.temperatureFeelsLike),
            subtitle: (allWeatherInfoDTO.main?.feelsLike?.toString() ?? AppStrings.unknownText) + ref.translateText(textType: TextType.celsius),
          ),
        if (allWeatherInfoDTO.main?.tempMin != null && allWeatherInfoDTO.main?.temp != null && allWeatherInfoDTO.weather?.isNotEmpty == true && allWeatherInfoDTO.weather?.first?.type != null)
          AdvancedWeatherDetailsCard(
            icon: allWeatherInfoDTO.weather!.first!.type!.weatherIcon,
            title: ref.translateText(textType: TextType.temperatureMin),
            subtitle: (allWeatherInfoDTO.main?.tempMin?.toString() ?? AppStrings.unknownText) + ref.translateText(textType: TextType.celsius),
          ),
        if (allWeatherInfoDTO.main?.tempMax != null && allWeatherInfoDTO.main?.temp != null && allWeatherInfoDTO.weather?.isNotEmpty == true && allWeatherInfoDTO.weather?.first?.type != null)
          AdvancedWeatherDetailsCard(
            icon: allWeatherInfoDTO.weather!.first!.type!.weatherIcon,
            title: ref.translateText(textType: TextType.temperatureMax),
            subtitle: (allWeatherInfoDTO.main?.tempMax?.toString() ?? AppStrings.unknownText) + ref.translateText(textType: TextType.celsius),
          ),
        if (allWeatherInfoDTO.wind?.speed != null)
          AdvancedWeatherDetailsCard(
            icon: AppIcons.windSpeedIcon,
            title: ref.translateText(textType: TextType.wind),
            subtitle: '${allWeatherInfoDTO.wind?.speed?.toString() ?? AppStrings.unknownText} (${ref.translateText(textType: TextType.windSpeedMagnitude)})',
          ),
        if (allWeatherInfoDTO.main?.humidity != null)
          AdvancedWeatherDetailsCard(
            icon: AppIcons.humidityIcon,
            title: ref.translateText(textType: TextType.humidity),
            subtitle: '${allWeatherInfoDTO.main?.humidity?.toString() ?? AppStrings.unknownText} (${ref.translateText(textType: TextType.percentage)})',
          ),
        if (allWeatherInfoDTO.main?.pressure != null)
          AdvancedWeatherDetailsCard(
            icon: AppIcons.pressureIcon,
            title: ref.translateText(textType: TextType.pressure),
            subtitle: '${allWeatherInfoDTO.main?.pressure?.toString() ?? AppStrings.unknownText} (${ref.translateText(textType: TextType.pressureMagnitude)})',
          ),
        if (allWeatherInfoDTO.main?.seaLevel != null)
          AdvancedWeatherDetailsCard(
            icon: AppIcons.seaLevelPressureIcon,
            title: ref.translateText(textType: TextType.seaLevelPressure),
            subtitle: '${allWeatherInfoDTO.main?.seaLevel?.toString() ?? AppStrings.unknownText} (${ref.translateText(textType: TextType.pressureMagnitude)})',
          ),
        if (allWeatherInfoDTO.main?.grndLevel != null)
          AdvancedWeatherDetailsCard(
            icon: AppIcons.groundLevelPressureIcon,
            title: ref.translateText(textType: TextType.groundLevelPressure),
            subtitle: '${allWeatherInfoDTO.main?.grndLevel?.toString() ?? AppStrings.unknownText} (${ref.translateText(textType: TextType.pressureMagnitude)})',
          ),
      ],
    );
  }
}
