import 'package:flutter/material.dart'; // Import the ChangeNotifier class

class UserPinProvider {
  String _pin = '';

  String get pin => _pin;

  void setPin(String pin) {
    _pin = pin;
    // notifyListeners(); // Notify all listeners about the change
  }
}
