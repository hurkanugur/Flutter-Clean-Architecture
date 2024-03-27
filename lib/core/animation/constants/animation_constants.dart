import 'package:flutter/material.dart';

class AnimationConstants {
  const AnimationConstants._();

  /// Curve for page view animations.
  static const Curve pageViewAnimationCurve = Curves.easeOut;

  /// Curve for list scroll animations.
  static const Curve listScrollAnimationCurve = Curves.easeInOut;

  /// Curve for Lottie animation appearances.
  static const Curve lottieAnimationAppearanceCurve = Curves.easeOut;

  /// Duration in milliseconds for page view animations.
  static const int pageViewAnimationDurationMS = 500;

  /// Duration in milliseconds for loading animation extra delay duration.
  static const int loadingAnimationExtraDelayDurationMS = 400;

  /// Duration in milliseconds for list scroll animations.
  static const int listScrollAnimationDurationMS = 1000;

  /// Delay duration in milliseconds for Lottie animation appearances.
  static const int lottieAnimationAppearanceDelayDurationMS = 500;
}
