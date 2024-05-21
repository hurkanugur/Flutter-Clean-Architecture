import 'package:clean_architecture/core/storage/extension/shared_preference_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeState {
  final ThemeMode themeMode;

  const ThemeState({
    required this.themeMode,
  });

  /// Creates a copy of this class.
  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}

class ThemeController extends StateNotifier<ThemeState> {
  ThemeController() : super(const ThemeState(themeMode: ThemeMode.system));

  /// Getter for [themeMode].
  ThemeMode get themeMode => state.themeMode;

  /// Setter for [themeMode].
  Future<void> changeTheme({required ThemeMode themeMode, required WidgetRef? ref}) async {
    if (ref != null) {
      await ref.sharedPreference.setThemeMode(themeMode: themeMode);
    }

    state = state.copyWith(themeMode: themeMode);
  }
}
