import 'package:flutter/material.dart';
import 'package:pip_view/pip_view.dart';

class FloatingManager {
  static final ValueNotifier<bool> _isFloatingShown = ValueNotifier(false);

  static bool get isShown => _isFloatingShown.value;

  static void showFull() {
    _isFloatingShown.value = true;
  }

  static void minimize(BuildContext context) {
    PIPView.of(context)?.present();
  }

  static void close() {
    _isFloatingShown.value = false;
  }

  static void listen(VoidCallback callback) {
    _isFloatingShown.addListener(callback);
  }
}