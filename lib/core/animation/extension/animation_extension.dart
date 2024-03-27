import 'package:clean_architecture/core/animation/constants/animation_constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

extension AnimationExtension on BuildContext {
  /// Get the animation to be used initially loading the lottie animation.
  Widget lottieRenderingAnimation({
    required BuildContext context,
    required Widget child,
    required LottieComposition? composition,
  }) {
    return AnimatedOpacity(
      opacity: composition == null ? 0 : 1,
      duration: const Duration(milliseconds: AnimationConstants.lottieAnimationAppearanceDelayDurationMS),
      curve: AnimationConstants.lottieAnimationAppearanceCurve,
      child: child,
    );
  }

  /// Get the animation to be used switching between widgets from another to lottie.
  FadeTransition lottieSwitchAnimation({
    required Animation<double> animation,
    required Widget child,
  }) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: AnimationConstants.lottieAnimationAppearanceCurve,
      ),
      child: child,
    );
  }
}
