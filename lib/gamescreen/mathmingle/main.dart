// //import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// //import 'package:cloud_firestore/cloud_firestore.dart';
// //import 'package:minglemath/firebase_options.dart';
// import 'homescreen.dart';
// import 'menu.dart';
// import 'studymaterial.dart';
// import 'matching.dart';
// import 'memory.dart';
// import 'package:provider/provider.dart';
// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => GameData()),
//         ChangeNotifierProvider(create: (_) => GameData1()),
//       ],
//       child: MaterialApp(
//         initialRoute: '/',
//         routes: {
//           '/': (context) => WelcomeScreen(),
//           '/menu':(context) => Menu(),
//           '/home': (context) => MyHomePage(),
//           '/studymaterial': (context) => StudyMaterialScreen(),
//           '/matching':(context) => MatchGame(),
//           '/memory':(context) => MemoryGame(),
//         },
//       ),
//     ),
//   );
// }
//
// class WelcomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/gif1.gif'),
//             fit: BoxFit.cover,
//           ),
//           gradient: LinearGradient(
//             colors: [Colors.lightBlue, Colors.white],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'W E L C O M E',
//                 style: TextStyle(
//                   fontSize: 140,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(height: 300),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pushReplacement(
//                     context,
//                     PageRouteBuilder(
//                       pageBuilder: (context, animation1, animation2) => Menu(),
//                       transitionsBuilder: (context, animation1, animation2, child) {
//                         const begin = Offset(1.0, 0.0);
//                         const end = Offset.zero;
//                         const curve = Curves.easeInOut;
//                         var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//                         var offsetAnimation = animation1.drive(tween);
//                         return SlideTransition(position: offsetAnimation, child: child);
//                       },
//                       fullscreenDialog: true,
//                     ),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   //primary: Colors.blue,
//                   //onPrimary: Colors.white,
//                   minimumSize: Size(600, 100),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     side: BorderSide(color: Colors.white, width: 2),
//                   ),
//                 ),
//                 child: Text(
//                   'LET\'S DIVE IN !!!!!!',
//                   style: TextStyle(fontSize: 35),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// Uncomment Firebase imports
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'homescreen.dart';
import 'menu.dart';
import 'studymaterial.dart';
import 'matching.dart';
import 'memory.dart';
import 'firebase_options.dart'; // Make sure you have this file from FlutterFire CLI
import 'package:provider/provider.dart';

void main() async {
  // Ensure Firebase is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameData()),
        ChangeNotifierProvider(create: (_) => GameData1()),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => WelcomeScreen(),
          '/menu': (context) => Menu(),
          '/home': (context) => MyHomePage(),
          '/studymaterial': (context) => StudyMaterialScreen(),
          '/matching': (context) => MatchGame(),
          '/memory': (context) => MemoryGame(),
        },
      ),
    ),
  );
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/gif1.gif'),
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
            colors: [Colors.lightBlue, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'W E L C O M E',
                style: TextStyle(
                  fontSize: 140,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 300),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) => Menu(),
                      transitionsBuilder: (context, animation1, animation2, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                        var offsetAnimation = animation1.drive(tween);
                        return SlideTransition(position: offsetAnimation, child: child);
                      },
                      fullscreenDialog: true,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(600, 100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                child: Text(
                  'LET\'S DIVE IN !!!!!!',
                  style: TextStyle(fontSize: 35),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

