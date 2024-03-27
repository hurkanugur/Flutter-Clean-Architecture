import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AdvancedDropdownItemModel extends Equatable {
  final IconData icon;
  final String title;

  const AdvancedDropdownItemModel({
    required this.icon,
    required this.title,
  });

  @override
  List<Object?> get props => [icon, title];

  /// Creates a copy of this class.
  AdvancedDropdownItemModel copyWith({
    IconData? icon,
    String? title,
  }) {
    return AdvancedDropdownItemModel(
      icon: icon ?? this.icon,
      title: title ?? this.title,
    );
  }
}
