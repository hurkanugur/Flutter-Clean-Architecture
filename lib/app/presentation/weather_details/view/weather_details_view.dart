import 'package:clean_architecture/app/presentation/weather_details/widget/weather_details_gridview.dart';
import 'package:clean_architecture/core/theme/extension/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherDetailsView extends ConsumerWidget {
  const WeatherDetailsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      color: context.appColors.scaffoldBackgroundColor,
      child: const WeatherDetailsGridView(),
    );
  }
}
