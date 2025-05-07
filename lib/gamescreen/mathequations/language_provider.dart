import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  bool _isSpanish = false;

  bool get isSpanish => _isSpanish;

  void toggleLanguage() {
    _isSpanish = !_isSpanish;
    notifyListeners();
  }

  void setLanguage(bool isSpanish) {
    _isSpanish = isSpanish;
    notifyListeners();
  }
}
