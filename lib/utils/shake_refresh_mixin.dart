import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:assingment/utils/shake_detector.dart';

mixin ShakeRefreshMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  ShakeDetector? _shakeDetector;

  void startShakeDetection(WidgetRef ref, VoidCallback onRefresh) {
    _shakeDetector = ShakeDetector(
      onShake: () {
        onRefresh();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Products refreshed')),
        );
      },
      shakeThreshold: 15.0,
      shakeSlopTimeMs: 500,
    );
    _shakeDetector!.startListening();
  }

  @override
  void dispose() {
    _shakeDetector?.stopListening();
    super.dispose();
  }
}
