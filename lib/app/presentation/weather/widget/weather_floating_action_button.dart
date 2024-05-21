import 'package:clean_architecture/core/localization/extension/localization_extension.dart';
import 'package:clean_architecture/core/localization/enum/text_type.dart';
import 'package:clean_architecture/core/widgets/advanced_floating_action_button.dart';
import 'package:clean_architecture/core/widgets/enum/floating_action_button_type.dart';
import 'package:clean_architecture/app/presentation/weather/provider/weather_view_provider.dart';
import 'package:clean_architecture/config/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherFloatingActionButton extends ConsumerWidget {
  const WeatherFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdvancedFloatingActionButton(
      icon: AppIcons.refreshIcon,
      title: ref.translateText(textType: TextType.refresh),
      onTap: () async => await _onTap(ref: ref),
      tooltip: ref.translateText(textType: TextType.refresh),
      type: FloatingActionButtonType.extended,
    );
  }

  /// Floating action button on tap event.
  Future<void> _onTap({required WidgetRef ref}) async {
    final weatherViewController = ref.read(WeatherViewProvider.weatherViewControllerProvider.notifier);
    weatherViewController.fetchAllWeatherInfo(ref: ref);
  }
}
