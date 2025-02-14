import 'package:flutter/material.dart';
import '../screens/login_screen.dart';

void logout(BuildContext context) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => LoginScreen()),
  );
}