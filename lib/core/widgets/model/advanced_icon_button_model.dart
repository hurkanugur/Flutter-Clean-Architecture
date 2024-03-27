import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AdvancedIconButtonModel extends Equatable {
  final IconData icon;
  final String tooltip;
  final Future<void> Function()? onTap;

  const AdvancedIconButtonModel({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  List<Object?> get props => [icon, tooltip, onTap];

  /// Creates a copy of this class.
  AdvancedIconButtonModel copyWith({
    IconData? icon,
    String? tooltip,
    Future<void> Function()? onTap,
  }) {
    return AdvancedIconButtonModel(
      icon: icon ?? this.icon,
      tooltip: tooltip ?? this.tooltip,
      onTap: onTap ?? this.onTap,
    );
  }
}
