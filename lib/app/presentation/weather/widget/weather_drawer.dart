import 'package:clean_architecture/core/widgets/advanced_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherDrawer extends ConsumerWidget {
  const WeatherDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AdvancedDrawer(
      child: Column(
        children: <Widget>[],
      ),
    );
  }
}
