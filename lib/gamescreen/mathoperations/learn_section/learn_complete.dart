import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';

class LearnComplete extends StatelessWidget {
  const LearnComplete({super.key});

  @override
  Widget build(BuildContext context) {
    String userPin = Provider.of<UserPinProvider>(context, listen: false).pin;
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth * 0.75; // 75% of screen width
    double cardHeight =
        MediaQuery.of(context).size.height * 0.6; // 60% of screen height
    double padding = screenWidth * 0.01; // 1% of screen width for padding
    double buttonWidth = screenWidth * 0.20; // 15% of screen width for buttons
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        foregroundColor: Colors.black,
        backgroundColor: Colors.lightBlue,
        shape: CircleBorder(),
        child: const Icon(Icons.arrow_back_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Mathoperations/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            margin: EdgeInsets.all(120),
            padding: EdgeInsets.all(30),
            height: 700,
            width: 1800,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.emoji_events,
                  size: screenHeight * 0.1,
                ),
                Container(
                  margin: EdgeInsets.only(top: 80),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    'PIN: ${userPin}',
                    style: TextStyle(
                      fontSize: screenWidth / 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Congratulations !!! You have completed this lesson.',
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: (screenWidth * 0.025).clamp(25.0, 40.0)),
                ),
                SizedBox(height: 50),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: buttonWidth,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.lightBlue,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'Done',
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  (screenWidth * 0.025).clamp(25.0, 40.0)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
