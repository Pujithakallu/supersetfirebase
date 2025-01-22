import 'package:flutter/material.dart';

class InstructionsWidget extends StatelessWidget {
  final String instructions;

  const InstructionsWidget({Key? key, required this.instructions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.info_outline),
      color: Colors.black, // Set icon color
      iconSize: 34, // Increase icon size
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              titlePadding: const EdgeInsets.all(0),
              title: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20.0),
                  ),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.lightbulb, color: Colors.white, size: 28),
                    SizedBox(width: 10),
                    Text(
                      'Instructions',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              content: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  instructions,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Got it'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
