import 'package:flutter/material.dart';
import 'main_menu.dart';
import 'play_menu.dart';
import 'learn_menu.dart';
import 'equation_drag_drop.dart';
import 'what_are_equations.dart';
import 'parts_of_equations.dart';
import 'equation_to_words.dart';
import 'what_are_equations_detail.dart';
import 'importance_of_equations.dart';
import 'real_world_applications.dart';
import 'analytics_engine.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'language_provider.dart';
import 'total_xp_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AnalyticsEngine.init();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => TotalXpProvider()),
      ],
      child: const MathEquationsApp(),
    )
  );
}

class MathEquationsApp extends StatelessWidget {
  const MathEquationsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => TotalXpProvider()),
      ],
      child: MaterialApp(
        title: 'Math Equations',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const MainMenu(),
          '/learn': (context) => const LearnMenu(),
          '/play': (context) => const PlayMenu(),
          '/partsOfEquation': (context) => const EquationDragDrop(),
          '/equationToWords': (context) => const EquationToWordsScreen(),
          '/whatAreEquations': (context) => const WhatAreEquations(),
          '/partsOfEquations': (context) => PartsOfEquations(),
          '/whatAreEquationsDetail': (context) => const WhatAreEquationsDetail(),
          '/importanceOfEquations': (context) => const ImportanceOfEquations(),
          '/realWorldApplications': (context) => const RealWorldApplications(),
        },
      ),
    );
  }
}