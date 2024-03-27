import 'package:clean_architecture/core/widgets/advanced_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherDetailsDrawer extends ConsumerWidget {
  const WeatherDetailsDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AdvancedDrawer(child: null);
  }
}
