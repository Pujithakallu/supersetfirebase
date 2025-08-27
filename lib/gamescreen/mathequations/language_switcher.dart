import 'package:flutter/material.dart';

class LanguageSwitcher extends StatelessWidget {
  final bool isSpanish;
  final ValueChanged<bool> onLanguageChanged;

  const LanguageSwitcher({
    super.key,
    required this.isSpanish,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: [!isSpanish, isSpanish],
      onPressed: (int index) {
        onLanguageChanged(index == 1);
      },
      color: Colors.grey, // Color for unselected text
      selectedColor: Colors.blue, // Color for selected text
      fillColor:
          Colors.blue.withOpacity(0.1), // Background color for selected button
      borderRadius: BorderRadius.circular(8.0),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'English',
            style: TextStyle(
              color: !isSpanish ? Colors.blue : Colors.grey,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Español',
            style: TextStyle(
              color: isSpanish ? Colors.blue : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
