import 'package:clean_architecture/app/domain/weather/model/all_weather_info_dto.dart';
import 'package:clean_architecture/app/presentation/weather/provider/weather_view_provider.dart';
import 'package:clean_architecture/config/app_dimensions.dart';
import 'package:clean_architecture/config/app_icons.dart';
import 'package:clean_architecture/config/app_strings.dart';
import 'package:clean_architecture/core/localization/provider/localization_provider.dart';
import 'package:clean_architecture/core/localization/enum/text_type.dart';
import 'package:clean_architecture/core/widgets/advanced_weather_details_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherDetailsGridView extends ConsumerWidget {
  const WeatherDetailsGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizationController = ref.read(LocalizationProvider.localizationControllerProvider.notifier);
    final weatherViewState = ref.watch(WeatherViewProvider.weatherViewControllerProvider);
    final AllWeatherInfoDTO? allWeatherInfoDTO = weatherViewState.allWeatherInfoDTO;
    final bool isPortraitMode = MediaQuery.orientationOf(context) == Orientation.portrait;

    return GridView.count(
      crossAxisCount: isPortraitMode ? AppDimensions.weatherDetailGridViewPortraitCellSize : AppDimensions.weatherDetailGridViewLandscapeCellSize,
      children: <Widget>[
        if (allWeatherInfoDTO?.name != null)
          AdvancedWeatherDetailsCard(
            icon: AppIcons.locationIcon,
            title: localizationController.translateText(textType: TextType.location),
            subtitle: allWeatherInfoDTO?.name ?? AppStrings.unknownText,
          ),
        if (allWeatherInfoDTO?.main?.temp != null && allWeatherInfoDTO?.weather?.isNotEmpty == true && allWeatherInfoDTO?.weather?.first?.type != null)
          AdvancedWeatherDetailsCard(
            icon: allWeatherInfoDTO!.weather!.first!.type!.weatherIcon,
            title: localizationController.translateText(textType: TextType.temperature),
            subtitle: (allWeatherInfoDTO.main?.temp?.toString() ?? AppStrings.unknownText) + localizationController.translateText(textType: TextType.celsius),
          ),
        if (allWeatherInfoDTO?.main?.feelsLike != null && allWeatherInfoDTO?.main?.temp != null && allWeatherInfoDTO?.weather?.isNotEmpty == true && allWeatherInfoDTO?.weather?.first?.type != null)
          AdvancedWeatherDetailsCard(
            icon: allWeatherInfoDTO!.weather!.first!.type!.weatherIcon,
            title: localizationController.translateText(textType: TextType.temperatureFeelsLike),
            subtitle: (allWeatherInfoDTO.main?.feelsLike?.toString() ?? AppStrings.unknownText) + localizationController.translateText(textType: TextType.celsius),
          ),
        if (allWeatherInfoDTO?.main?.tempMin != null && allWeatherInfoDTO?.main?.temp != null && allWeatherInfoDTO?.weather?.isNotEmpty == true && allWeatherInfoDTO?.weather?.first?.type != null)
          AdvancedWeatherDetailsCard(
            icon: allWeatherInfoDTO!.weather!.first!.type!.weatherIcon,
            title: localizationController.translateText(textType: TextType.temperatureMin),
            subtitle: (allWeatherInfoDTO.main?.tempMin?.toString() ?? AppStrings.unknownText) + localizationController.translateText(textType: TextType.celsius),
          ),
        if (allWeatherInfoDTO?.main?.tempMax != null && allWeatherInfoDTO?.main?.temp != null && allWeatherInfoDTO?.weather?.isNotEmpty == true && allWeatherInfoDTO?.weather?.first?.type != null)
          AdvancedWeatherDetailsCard(
            icon: allWeatherInfoDTO!.weather!.first!.type!.weatherIcon,
            title: localizationController.translateText(textType: TextType.temperatureMax),
            subtitle: (allWeatherInfoDTO.main?.tempMax?.toString() ?? AppStrings.unknownText) + localizationController.translateText(textType: TextType.celsius),
          ),
        if (allWeatherInfoDTO?.wind?.speed != null)
          AdvancedWeatherDetailsCard(
            icon: AppIcons.windSpeedIcon,
            title: localizationController.translateText(textType: TextType.wind),
            subtitle: '${allWeatherInfoDTO?.wind?.speed?.toString() ?? AppStrings.unknownText} (${localizationController.translateText(textType: TextType.windSpeedMagnitude)})',
          ),
        if (allWeatherInfoDTO?.main?.humidity != null)
          AdvancedWeatherDetailsCard(
            icon: AppIcons.humidityIcon,
            title: localizationController.translateText(textType: TextType.humidity),
            subtitle: '${allWeatherInfoDTO?.main?.humidity?.toString() ?? AppStrings.unknownText} (${localizationController.translateText(textType: TextType.percentage)})',
          ),
        if (allWeatherInfoDTO?.main?.pressure != null)
          AdvancedWeatherDetailsCard(
            icon: AppIcons.pressureIcon,
            title: localizationController.translateText(textType: TextType.pressure),
            subtitle: '${allWeatherInfoDTO?.main?.pressure?.toString() ?? AppStrings.unknownText} (${localizationController.translateText(textType: TextType.pressureMagnitude)})',
          ),
        if (allWeatherInfoDTO?.main?.seaLevel != null)
          AdvancedWeatherDetailsCard(
            icon: AppIcons.seaLevelPressureIcon,
            title: localizationController.translateText(textType: TextType.seaLevelPressure),
            subtitle: '${allWeatherInfoDTO?.main?.seaLevel?.toString() ?? AppStrings.unknownText} (${localizationController.translateText(textType: TextType.pressureMagnitude)})',
          ),
        if (allWeatherInfoDTO?.main?.grndLevel != null)
          AdvancedWeatherDetailsCard(
            icon: AppIcons.groundLevelPressureIcon,
            title: localizationController.translateText(textType: TextType.groundLevelPressure),
            subtitle: '${allWeatherInfoDTO?.main?.grndLevel?.toString() ?? AppStrings.unknownText} (${localizationController.translateText(textType: TextType.pressureMagnitude)})',
          ),
      ],
    );
  }
}
