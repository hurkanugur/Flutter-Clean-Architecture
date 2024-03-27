import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AdvancedNavigationBarItemModel extends Equatable {
  final IconData unselectedIcon;
  final IconData selectedIcon;
  final String tooltip;
  final String title;

  const AdvancedNavigationBarItemModel({
    required this.unselectedIcon,
    required this.selectedIcon,
    required this.tooltip,
    required this.title,
  });

  @override
  List<Object?> get props => [unselectedIcon, selectedIcon, tooltip, title];

  /// Creates a copy of this class.
  AdvancedNavigationBarItemModel copyWith({
    IconData? unselectedIcon,
    IconData? selectedIcon,
    String? tooltip,
    String? title,
  }) {
    return AdvancedNavigationBarItemModel(
      unselectedIcon: unselectedIcon ?? this.unselectedIcon,
      selectedIcon: selectedIcon ?? this.selectedIcon,
      tooltip: tooltip ?? this.tooltip,
      title: title ?? this.title,
    );
  }
}
