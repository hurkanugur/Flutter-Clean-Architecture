import 'package:clean_architecture/config/app_resources.dart';
import 'package:clean_architecture/core/localization/enum/text_type.dart';
import 'package:clean_architecture/core/localization/provider/localization_provider.dart';
import 'package:clean_architecture/core/theme/extension/color_extension.dart';
import 'package:clean_architecture/core/widgets/advanced_lottie_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedNoResultsAnimation extends ConsumerWidget {
  const AdvancedNoResultsAnimation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizationController = ref.read(LocalizationProvider.localizationControllerProvider.notifier);
    final Orientation orientation = MediaQuery.of(context).orientation;
    final bool isPortrait = (orientation == Orientation.portrait) ? true : false;
    final double lottieHeight = MediaQuery.of(context).size.shortestSide / (isPortrait ? 1.5 : 2);

    return LayoutBuilder(builder: (context, constraints) {
      return Align(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewPadding.bottom,
            ),
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              children: <Widget>[
                AdvancedLottieAnimation(
                  lottieAnimationPath: AppResources.noResultsAnimationPath,
                  animationHeight: lottieHeight,
                  isLottieAnimationVisible: true,
                ),
                const SizedBox(height: 15),
                Text(
                  localizationController.translateText(textType: TextType.noResultsFound),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: context.appColors.transparentWidgetForegroundColor,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
