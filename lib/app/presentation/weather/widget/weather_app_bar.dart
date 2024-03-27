import 'package:clean_architecture/app/presentation/home/provider/home_view_provider.dart';
import 'package:clean_architecture/config/app_icons.dart';
import 'package:clean_architecture/core/localization/provider/localization_provider.dart';
import 'package:clean_architecture/core/localization/enum/text_type.dart';
import 'package:clean_architecture/core/widgets/advanced_app_bar.dart';
import 'package:clean_architecture/core/widgets/model/advanced_app_bar_icon_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const WeatherAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizationController = ref.read(LocalizationProvider.localizationControllerProvider.notifier);

    return AdvancedAppBar(
      title: localizationController.translateText(textType: TextType.currentWeather),
      leading: AdvancedAppBarIconModel(
        icon: AppIcons.menuIcon,
        tooltip: localizationController.translateText(textType: TextType.menu),
        onTap: () async => await _onTap(ref: ref),
      ),
      actionList: <AdvancedAppBarIconModel>[
        AdvancedAppBarIconModel(
          icon: AppIcons.moreIcon,
          tooltip: localizationController.translateText(textType: TextType.options),
          onTap: null,
        ),
      ],
    );
  }

  /// Represents app bar the leading button tap event.
  Future<void> _onTap({required WidgetRef ref}) async {
    final homeViewController = ref.read(HomeViewProvider.homeViewControllerProvider.notifier);
    homeViewController.homePageScaffoldKey?.currentState?.openDrawer();
  }
}
