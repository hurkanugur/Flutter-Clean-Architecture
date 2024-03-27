import 'package:clean_architecture/core/theme/extension/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedHorizontalDivider extends ConsumerWidget {
  const AdvancedHorizontalDivider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Divider(
      height: 1,
      color: context.appColors.dividerColor,
    );
  }
}
