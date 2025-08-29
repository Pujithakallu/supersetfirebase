import 'package:flutter/material.dart';
import '../screens/home.dart';
class ExitButton extends StatelessWidget {
  final BuildContext context;

  const ExitButton({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        ); // This will go back to the previous screen
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple,
        padding: const EdgeInsets.symmetric(horizontal: 140, vertical: 20),
      ),
      child: const Text(
        'EXIT',
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}