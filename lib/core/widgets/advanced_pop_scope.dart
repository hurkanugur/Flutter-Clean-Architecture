import 'dart:io';
import 'package:flutter/cupertino.dart';

class AdvancedPopScope extends StatelessWidget {
  final Future<void> Function() onPopScope;
  final Widget child;

  const AdvancedPopScope({
    super.key,
    required this.onPopScope,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx > 0) {
          onPopScope();
        }
      },
      child: PopScope(
        onPopInvoked: onPopInvoked,
        canPop: false,
        child: child,
      ),
    );
  }

  void onPopInvoked(bool didPop) {
    if (Platform.isIOS) {
      return;
    } else {
      if (!didPop) {
        onPopScope();
      }
    }
  }
}
