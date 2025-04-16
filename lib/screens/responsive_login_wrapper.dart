import 'package:flutter/material.dart';
import 'login_screen.dart'; // Verify that the path is correct!
import 'package:supersetfirebase/gamescreen/mathoperations/analytics_engine.dart';


class ResponsiveLoginWrapper extends StatelessWidget {
  const ResponsiveLoginWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Add a debug print to make sure this widget builds.
    debugPrint('ResponsiveLoginWrapper build() called');
    return LayoutBuilder(
      builder: (context, constraints) {
        // Debug print to show constraints
        debugPrint('Max width: ${constraints.maxWidth}');
        double maxWidth = constraints.maxWidth;
        if (maxWidth > 600) {
          maxWidth = 600; // Cap the width for larger screens
        }
        return Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: maxWidth,
            child: SingleChildScrollView(
              // Optionally, wrap in padding if needed
              child: LoginScreen(),
            ),
          ),
        );
      },
    );
  }
}

