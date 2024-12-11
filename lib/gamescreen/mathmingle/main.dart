import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'homescreen.dart';
import 'menu.dart';
import 'studymaterial.dart';
import 'matching.dart';
import 'memory.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/widgets/appbarwelcomepage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();


 runApp(
   MultiProvider(
     providers: [
       ChangeNotifierProvider(create: (_) => GameData()),
       ChangeNotifierProvider(create: (_) => GameData1()),
     ],
     child: MaterialApp(
       debugShowCheckedModeBanner: false,
       theme: ThemeData(
         primarySwatch: Colors.blue,
         visualDensity: VisualDensity.adaptivePlatformDensity,
       ),
       initialRoute: '/',
       routes: {
         '/': (context) =>  WelcomeScreen(userPin: ''),
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
 final String userPin;
  const WelcomeScreen({required this.userPin, Key? key}) : super(key: key);


 @override
 Widget build(BuildContext context) {
   // Get screen size for responsive design
   final Size screenSize = MediaQuery.of(context).size;
  
   // Calculate responsive values
   final double titleFontSize = screenSize.width * 0.1;
   final double buttonWidth = screenSize.width * 0.8;
   final double buttonHeight = screenSize.height * 0.12;
   final double verticalSpacing = screenSize.height * 0.15;


   return Scaffold(
     appBar: CustomGameAppBar(userPin:userPin,title: 'Mathmingle',showHomeButton: true,),
     body: Container(
       decoration: BoxDecoration(
         image: const DecorationImage(
           image: AssetImage('assets/Mathmingle/gif1.gif'),
           fit: BoxFit.cover,
         ),
         gradient: LinearGradient(
           colors: [Colors.lightBlue, Colors.white],
           begin: Alignment.topCenter,
           end: Alignment.bottomCenter,
         ),
       ),
       child: SafeArea(
         child: Center(
           child: SingleChildScrollView(
             child: Padding(
               padding: EdgeInsets.symmetric(
                 horizontal: screenSize.width * 0.05,
               ),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   FittedBox(
                     fit: BoxFit.scaleDown,
                     child: Text(
                       'W E L C O M E',
                       style: TextStyle(
                         fontSize: titleFontSize,
                         fontWeight: FontWeight.bold,
                         color: Colors.white,
                         shadows: [
                           Shadow(
                             offset: const Offset(2.0, 2.0),
                             blurRadius: 3.0,
                             color: Colors.black.withOpacity(0.3),
                           ),
                         ],
                       ),
                     ),
                   ),
                   SizedBox(height: verticalSpacing),
                   SizedBox(
                     width: buttonWidth,
                     height: buttonHeight,
                     child: ElevatedButton(
                       onPressed: () {
                         Navigator.pushReplacement(
                           context,
                           PageRouteBuilder(
                             pageBuilder: (context, animation1, animation2) => Menu(),
                             transitionsBuilder: (context, animation1, animation2, child) {
                               const begin = Offset(1.0, 0.0);
                               const end = Offset.zero;
                               const curve = Curves.easeInOut;
                               var tween = Tween(begin: begin, end: end)
                                   .chain(CurveTween(curve: curve));
                               var offsetAnimation = animation1.drive(tween);
                               return SlideTransition(
                                 position: offsetAnimation,
                                 child: child,
                               );
                             },
                             fullscreenDialog: true,
                           ),
                         );
                       },
                       style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.white.withOpacity(0.8),
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(10),
                           side: const BorderSide(color: Colors.black, width: 2),
                         ),
                       ),
                       child: FittedBox(
                         fit: BoxFit.scaleDown,
                         child: Text(
                           'LET\'S DIVE IN !!!!!!',
                           style: TextStyle(
                             fontSize: screenSize.width * 0.025,
                             color: Colors.black,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                       ),
                     ),
                   ),
                 ],
               ),
             ),
           ),
         ),
       ),
     ),
   );
 }
}



