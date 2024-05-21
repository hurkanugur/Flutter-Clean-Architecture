import 'package:clean_architecture/app/presentation/settings/widget/settings_list_view.dart';
import 'package:clean_architecture/core/theme/extension/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      color: context.appColors.scaffoldBackgroundColor,
      child: const SettingsListView(),
    );
  }
}
