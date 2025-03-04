import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/learn_section/operator.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/operator_data/op_data.dart';
import 'package:supersetfirebase/utils/logout_util.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';

class LearnPage extends StatelessWidget {
  const LearnPage({super.key});

  @override
  Widget build(BuildContext context) {
    String userPin = Provider.of<UserPinProvider>(context, listen: false).pin;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60), // Adjust AppBar height
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Transparent AppBar Layer
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false, // Prevents default back button
            ),

            // Back Button (Styled as FloatingActionButton)
            Positioned(
              left: 16,
              top: 12,
              child: FloatingActionButton(
                heroTag: "backButton",
                onPressed: () => Navigator.pop(context),
                foregroundColor: Colors.black,
                backgroundColor: Colors.lightBlue,
                shape: const CircleBorder(),
                mini: true, // Smaller button
                child: const Icon(Icons.arrow_back_rounded, size: 32),
              ),
            ),

            // PIN Display (Smaller Width, Centered)
            Positioned(
              top: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6), // Reduced padding
                constraints: const BoxConstraints(
                  maxWidth:
                      120, // Limits the width to prevent it from being too wide
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(12), // Slightly rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'PIN: $userPin',
                    style: const TextStyle(
                      fontSize: 14, // Slightly smaller font for better fit
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),

            // Logout Button (Styled as FloatingActionButton)
            Positioned(
              right: 16,
              top: 12,
              child: FloatingActionButton(
                heroTag: "logoutButton",
                onPressed: () => logout(context),
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                shape: const CircleBorder(),
                mini: true, // Smaller button
                child: const Icon(Icons.logout_rounded, size: 32),
              ),
            ),
          ],
        ),
      ),
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Mathoperations/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Spacer(flex: 1),
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
              Text(
                'Operator List',
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth / 15),
              ),
              Spacer(flex: 1),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Spacer(flex: 2),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OperatorPage(
                                  operatorData: data['+']!,
                                )));
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: screenWidth / 7,
                    height: screenWidth / 7,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white70,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '+',
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth / 10),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(flex: 1),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OperatorPage(
                                  operatorData: data['-']!,
                                )));
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: screenWidth / 7,
                    height: screenWidth / 7,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white70,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '-',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth / 10),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(flex: 1),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OperatorPage(
                                  operatorData: data['x']!,
                                )));
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: screenWidth / 7,
                    height: screenWidth / 7,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white70,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'X',
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth / 13),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(flex: 1),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OperatorPage(
                                  operatorData: data['÷']!,
                                )));
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: screenWidth / 7,
                    height: screenWidth / 7,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white70,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '÷',
                          style: TextStyle(
                              color: Colors.yellow,
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth / 10),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(flex: 2),
              ]),
              Spacer(flex: 2),
            ],
          ))),
    );
  }
}
