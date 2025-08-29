import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/gamescreen/mathcountingandsequence/utils/language_controller.dart';
import 'package:supersetfirebase/gamescreen/mathcountingandsequence/analytics_engine.dart';

class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageController>(
      builder: (context, languageController, child) {
        // Determine button text and icon based on the current language
        bool isSpanish = languageController.currentLanguage == 'es';
        return ElevatedButton.icon(
          onPressed: () {
            languageController.toggleLanguage();
            AnalyticsEngine.logLanguageToggle(
                languageController.currentLanguage);
          },
          icon: Icon(
            isSpanish ? Icons.language : Icons.translate,
            color: Colors.white,
          ),
          label: Text(
            isSpanish ? 'English' : 'Español',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            backgroundColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ), // Button background color
          ),
        );
      },
    );
  }
}
