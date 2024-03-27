import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AdvancedAppBarIconModel extends Equatable {
  final IconData icon;
  final String tooltip;
  final Future<void> Function()? onTap;

  const AdvancedAppBarIconModel({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  List<Object?> get props => [icon, tooltip, onTap];

  /// Creates a copy of this class.
  AdvancedAppBarIconModel copyWith({
    IconData? icon,
    String? tooltip,
    Future<void> Function()? onTap,
  }) {
    return AdvancedAppBarIconModel(
      icon: icon ?? this.icon,
      tooltip: tooltip ?? this.tooltip,
      onTap: onTap ?? this.onTap,
    );
  }
}
