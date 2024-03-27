import 'package:clean_architecture/core/widgets/advanced_divider_horizontal.dart';
import 'package:clean_architecture/config/app_icons.dart';
import 'package:clean_architecture/core/localization/provider/localization_provider.dart';
import 'package:clean_architecture/core/localization/enum/text_type.dart';
import 'package:clean_architecture/core/widgets/advanced_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsListView extends ConsumerWidget {
  const SettingsListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      separatorBuilder: (context, index) => const AdvancedHorizontalDivider(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return AdvancedListTile(
          title: _getTitle(index: index, ref: ref),
          subtitle: _getSubtitle(index: index, ref: ref),
          leadingIcon: _getLeadingIcon(index: index),
          trailingIcon: AppIcons.nextIcon,
          onTap: null,
          onLongPress: null,
        );
      },
    );
  }

  /// Get the title of the list tile.
  String? _getTitle({required int index, required WidgetRef ref}) {
    final localizationController = ref.read(LocalizationProvider.localizationControllerProvider.notifier);

    return switch (index) {
      0 => localizationController.translateText(textType: TextType.profileSettings),
      1 => localizationController.translateText(textType: TextType.locationSettings),
      2 => localizationController.translateText(textType: TextType.about),
      _ => null,
    };
  }

  /// Get the subtitle of the list tile.
  String? _getSubtitle({required int index, required WidgetRef ref}) {
    final localizationController = ref.read(LocalizationProvider.localizationControllerProvider.notifier);

    return switch (index) {
      0 => localizationController.translateText(textType: TextType.profileSettingsTip),
      1 => localizationController.translateText(textType: TextType.locationSettingsTip),
      2 => localizationController.translateText(textType: TextType.aboutTip),
      _ => null,
    };
  }

  /// Get the leading icon of the list tile.
  IconData? _getLeadingIcon({required int index}) {
    return switch (index) {
      0 => AppIcons.profileIcon,
      1 => AppIcons.locationIcon,
      2 => AppIcons.aboutIcon,
      _ => null,
    };
  }
}
