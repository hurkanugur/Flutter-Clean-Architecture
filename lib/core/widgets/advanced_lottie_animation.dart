import 'package:clean_architecture/core/animation/constants/animation_constants.dart';
import 'package:clean_architecture/core/animation/extension/animation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class AdvancedLottieAnimation extends ConsumerWidget {
  const AdvancedLottieAnimation({
    super.key,
    required this.lottieAnimationPath,
    required this.isLottieAnimationVisible,
    required this.animationHeight,
    this.animationWidth,
    this.containerWidth,
    this.containerHeight,
    this.controller,
    this.lottieOnLoaded,
    this.scale = 1,
    this.blurBackground = false,
  });

  final String lottieAnimationPath;
  final bool isLottieAnimationVisible;
  final AnimationController? controller;
  final Future<void> Function()? lottieOnLoaded;
  final double? animationWidth;
  final double animationHeight;
  final double? containerWidth;
  final double? containerHeight;
  final double scale;
  final bool blurBackground;

  /// Creates a copy of this class.
  AdvancedLottieAnimation copyWith({
    String? lottieAnimationPath,
    bool? isLottieAnimationVisible,
    AnimationController? controller,
    Future<void> Function()? lottieOnLoaded,
    double? animationWidth,
    double? animationHeight,
    double? containerWidth,
    double? containerHeight,
    double? scale,
    bool? blurBackground,
  }) {
    return AdvancedLottieAnimation(
      lottieAnimationPath: lottieAnimationPath ?? this.lottieAnimationPath,
      isLottieAnimationVisible: isLottieAnimationVisible ?? this.isLottieAnimationVisible,
      controller: controller ?? this.controller,
      lottieOnLoaded: lottieOnLoaded ?? this.lottieOnLoaded,
      animationWidth: animationWidth ?? this.animationWidth,
      animationHeight: animationHeight ?? this.animationHeight,
      containerWidth: containerWidth ?? this.containerWidth,
      containerHeight: containerHeight ?? this.containerHeight,
      scale: scale ?? this.scale,
      blurBackground: blurBackground ?? this.blurBackground,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: AnimationConstants.lottieAnimationAppearanceDelayDurationMS),
      switchInCurve: AnimationConstants.lottieAnimationAppearanceCurve,
      switchOutCurve: AnimationConstants.lottieAnimationAppearanceCurve,
      transitionBuilder: (child, animation) => context.lottieSwitchAnimation(animation: animation, child: child),
      child: isLottieAnimationVisible ? _createLottieAnimation() : SizedBox(height: animationHeight),
    );
  }

  /// Creates the lottie animation container.
  Widget _createLottieAnimation() {
    return Container(
      width: containerWidth,
      height: containerHeight,
      alignment: Alignment.center,
      color: blurBackground ? Colors.black.withOpacity(0.6) : null,
      child: Transform.scale(
        scale: scale,
        alignment: Alignment.center,
        child: Lottie.asset(
          lottieAnimationPath,
          controller: controller,
          frameRate: FrameRate.max,
          backgroundLoading: true,
          fit: BoxFit.contain,
          width: animationWidth,
          height: animationHeight,
          frameBuilder: (context, child, composition) => context.lottieRenderingAnimation(context: context, child: child, composition: composition),
          onLoaded: _onLoaded,
        ),
      ),
    );
  }

  /// Represents the lottie on loaded event.
  void _onLoaded(LottieComposition composition) async {
    if (lottieOnLoaded != null) {
      await lottieOnLoaded!();
    }
    controller?.duration = composition.duration;
    controller?.forward();
  }
}
