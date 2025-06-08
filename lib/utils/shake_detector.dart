import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

class ShakeDetector {
  final VoidCallback onShake;
  final double shakeThreshold;
  final int shakeSlopTimeMs;
  StreamSubscription? _accelerometerSubscription;
  DateTime? _lastShakeTime;

  ShakeDetector({
    required this.onShake,
    this.shakeThreshold = 15.0, 
    this.shakeSlopTimeMs = 500, 
  });

  void startListening() {
    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      final magnitude =
          sqrt(event.x * event.x + event.y * event.y + event.z * event.z);

      if (magnitude > shakeThreshold) {
        final now = DateTime.now();
        if (_lastShakeTime == null ||
            now.difference(_lastShakeTime!).inMilliseconds > shakeSlopTimeMs) {
          _lastShakeTime = now;
          onShake();
        }
      }
    });
  }

  void stopListening() {
    _accelerometerSubscription?.cancel();
    _accelerometerSubscription = null;
  }
}
