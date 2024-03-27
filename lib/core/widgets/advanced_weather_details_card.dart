import 'package:clean_architecture/config/app_dimensions.dart';
import 'package:clean_architecture/core/theme/extension/theme_extension.dart';
import 'package:clean_architecture/core/widgets/enum/widget_style_type.dart';
import 'package:clean_architecture/core/widgets/model/advanced_border_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedWeatherDetailsCard extends ConsumerWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const AdvancedWeatherDetailsCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  /// Creates a copy of this class.
  AdvancedWeatherDetailsCard copyWith({
    IconData? icon,
    String? title,
    String? subtitle,
  }) {
    return AdvancedWeatherDetailsCard(
      icon: icon ?? this.icon,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shape: const AdvancedBorderModel().getRoundedRectangleBorder(
        context: context,
        widgetStyleType: WidgetStyleType.transparent,
      ),
      surfaceTintColor: context.appColors.transparentWidgetBackgroundColor,
      color: context.appColors.scaffoldBackgroundColor,
      margin: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _createIconWidget(context: context),
          const SizedBox(height: 8.0),
          _createTitleWidget(context: context),
          _createSubtitleWidget(context: context),
        ],
      ),
    );
  }

  /// Creates the icon widget.
  Widget _createIconWidget({required BuildContext context}) {
    return Icon(
      icon,
      size: AppDimensions.cardIconSize,
      color: context.appColors.transparentWidgetForegroundColor,
    );
  }

  /// Creates the title widget.
  Widget _createTitleWidget({required BuildContext context}) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: context.appColors.transparentWidgetForegroundColor),
    );
  }

  /// Creates the subtitle widget.
  Widget _createSubtitleWidget({required BuildContext context}) {
    return Text(
      subtitle,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: context.appColors.transparentWidgetForegroundColor),
    );
  }
}
