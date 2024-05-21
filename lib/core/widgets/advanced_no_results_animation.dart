import 'package:clean_architecture/config/app_resources.dart';
import 'package:clean_architecture/core/localization/enum/text_type.dart';
import 'package:clean_architecture/core/localization/extension/localization_extension.dart';
import 'package:clean_architecture/core/theme/extension/theme_extension.dart';
import 'package:clean_architecture/core/widgets/advanced_lottie_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedNoResultsAnimation extends ConsumerWidget {
  const AdvancedNoResultsAnimation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Orientation orientation = MediaQuery.orientationOf(context);
    final bool isPortrait = (orientation == Orientation.portrait) ? true : false;
    final double lottieHeight = MediaQuery.sizeOf(context).shortestSide / (isPortrait ? 1.5 : 2);

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
                  lottieAnimationPath: AppResources.lottieNoResultsAnimationPath,
                  animationHeight: lottieHeight,
                  isLottieAnimationVisible: true,
                ),
                const SizedBox(height: 15),
                Text(
                  ref.translateText(textType: TextType.noResultsFound),
                  style: context.appTextStyles.largeTextWithTransparentBackground,
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
