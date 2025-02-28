import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flip_card/flip_card.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/languageconverter.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/learn_section/learn_complete.dart';
import 'flash_card_info.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/operator_data/op_data.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/comm_functions.dart';
import 'dart:developer';
import 'package:supersetfirebase/gamescreen/mathoperations/common/global.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/translate/translate.dart';
import 'package:supersetfirebase/utils/logout_util.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/analytics_engine.dart';

class FlashCard extends StatefulWidget {
  final String opSign;
  const FlashCard({super.key, required this.opSign});

  @override
  _FlashCardState createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  FlutterTts flutterTts = FlutterTts();
  int currentCardIndex = 0;
  int currentLanguage = 0;
  List<String> languageNames = ["English", "Spanish"];
  List<String> LangKeys = [
    getSpeakLangKey(GlobalVariables.priLang),
    getSpeakLangKey(GlobalVariables.secLang)
  ];
  late List<Map<String, dynamic>> flashCards;

  Future<void> ReadOut(String text) async {
    dynamic languages = await flutterTts.getLanguages;
    await flutterTts.setLanguage(LangKeys[currentLanguage]); // : 'es-ES'
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }

  @override
  void initState() {
    super.initState();
    flashCards = get_op_data(widget.opSign);
    log("current lang : $flashCards");
  }

  void changeLang() async {
    setState(() {
      currentLanguage = currentLanguage == 0 ? 1 : 0;
    });
    print('Button clicked');
    String newLanguage = languageNames[currentLanguage];
    await AnalyticsEngine.logTranslateButtonClickLearn(newLanguage);
    print('Language changed to: $newLanguage');
  }

  @override
  Widget build(BuildContext context) {
    String userPin = Provider.of<UserPinProvider>(context, listen: false).pin;
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth * 0.75; // 75% of screen width
    double cardHeight =
        MediaQuery.of(context).size.height * 0.6; // 60% of screen height
    double padding = screenWidth * 0.01; // 1% of screen width for padding
    double buttonWidth = screenWidth * 0.15; // 15% of screen width for buttons
    return Scaffold(
      floatingActionButton: Positioned(
        top: 16,
        left: 0,
        right: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Back Button (Left)
            FloatingActionButton(
              heroTag: "backButton",
              onPressed: () => Navigator.pop(context),
              foregroundColor: Colors.black,
              backgroundColor: Colors.lightBlue,
              shape: const CircleBorder(),
              child: const Icon(Icons.arrow_back_rounded, size: 24),
            ),

            // PIN Display (Center)
            Container(
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
                'PIN: $userPin',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            // Logout Button (Right)
            Padding(
              padding: EdgeInsets.only(
                  right: 30), // Moves logout button slightly left
              child: FloatingActionButton(
                heroTag: "logoutButton",
                onPressed: () => logout(context),
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                shape: const CircleBorder(),
                child:
                    const Icon(Icons.logout_rounded, size: 28), // Larger icon
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Mathoperations/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                // Allow the card to take available space without overflowing
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
                  width: cardWidth,
                  child: _renderFlashCard(flashCards[currentCardIndex]),
                ),
              ),
              Padding(
                // Add padding to ensure buttons don't overflow
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        _navigateToCard(-1);
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        width: buttonWidth,
                        padding: EdgeInsets.all(padding),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.lightBlue,
                        ),
                        child: Center(
                          child: Text(
                            "Back",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: (screenWidth * 0.025).clamp(16.0, 24.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _navigateToCard(1);
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        width: buttonWidth,
                        padding: EdgeInsets.all(padding),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.lightBlue,
                        ),
                        child: Center(
                          child: Text(
                            "Next",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: (screenWidth * 0.025).clamp(16.0, 24.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderFlashCard(data) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth * 0.75; // 75% of screen width
    double cardHeight =
        MediaQuery.of(context).size.height * 0.6; // 60% of screen height
    double padding = screenWidth * 0.01; // 1% of screen width for padding
    double buttonWidth = screenWidth * 0.15; // 15% of screen width for buttons
    String rem = 'and remainder = ';
    if (data["op_sign"] == '÷') {
      rem += '${data['fst_num'] % data['snd_num']}.';
    }
    String signPron = '';
    if (data["op_sign"] == '-') {
      signPron = 'minus';
    } else if (data["op_sign"] == 'x') {
      signPron = 'multiplied by ';
    } else {
      signPron = data["op_sign"];
    }

    return Card(
      elevation: 0.0,
      margin: const EdgeInsets.only(
        left: 32.0,
        right: 32.0,
        top: 20.0,
        bottom: 0.0,
      ),
      color: const Color(0x00000000),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        side: CardSide.FRONT,
        speed: 1000,
        onFlipDone: (status) {
          print(status);
        },
        front: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                data["op_sign"],
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.1,
                  height: 0.8,
                ),
              ),
              Text(
                data["op_name"][currentLanguage],
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.05,
                ),
              ),
              Text(
                data["op_def"][currentLanguage],
                style: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.bold,
                  fontSize: (screenWidth * 0.04).clamp(10.0, 30.0),
                ),
              ),
              const SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //SizedBox(width: 350),
                  InkWell(
                    onTap: () {
                      changeLang();
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: (screenWidth / 8).clamp(50.0, 100.0),
                      padding: EdgeInsets.all(padding),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.lightGreen,
                      ),
                      child: Center(
                        //mainAxisAlignment: MainAxisAlignment.center,
                         child: Text(
                            currentLanguage == 0 ? 'Español' : 'English',
                            style: TextStyle(fontSize: screenWidth / 60, color: Colors.black, fontWeight: FontWeight.bold),
                        )
                        // Icon(
                        //   Icons.translate,
                        //   size: (screenWidth * 0.025).clamp(25.0, 50.0),
                        // ),
                      ),
                    ),
                  ),
                  //SizedBox(width: 200),
                  InkWell(
                    onTap: () async {
                      ReadOut(data['op_def'][currentLanguage] + "; " + data['op_name'][currentLanguage]);
                      await AnalyticsEngine.logAudioButtonClick(currentLanguage);
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: (screenWidth / 8).clamp(50.0, 100.0),
                      padding: EdgeInsets.all(padding),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.lightGreen,
                      ),
                      child: Center(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        child: Icon(
                          Icons.volume_up,
                          size: (screenWidth * 0.025).clamp(25.0, 50.0),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        back: Container(
          //padding: EdgeInsets.all(50),
          decoration: const BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlashCardInfo(
                data["op_sign"],
                data['fst_num'],
                data['snd_num'],
                currentLanguage,
                fontSize: MediaQuery.of(context).size.width * 0.15,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //SizedBox(width: 350),
                  InkWell(
                    onTap: () {
                      changeLang(); // Navigator.push(context, MaterialPageRoute(builder: (context) => LearnPage()));
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: (screenWidth / 8).clamp(50.0, 100.0),
                      padding: EdgeInsets.all(padding),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.lightGreen,
                      ),
                      child: Center(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        child: Text(
                            currentLanguage == 0 ? 'Español' : 'English',
                            style: TextStyle(fontSize: screenWidth / 60, color: Colors.black, fontWeight: FontWeight.bold),
                        )
                        // Icon(
                        //   Icons.translate,
                        //   size: (screenWidth * 0.025).clamp(25.0, 50.0),
                        // ),
                      ),
                    ),
                  ),
                  //SizedBox(width: 200),
                  InkWell(
                    onTap: () async {
                      ReadOut('${data["fst_num"]} $signPron ${data["snd_num"]}  = ${get_op_result(data["op_sign"], data["fst_num"], data["snd_num"])} ${data["op_sign"] == "÷" ? rem : "."}');
                      await AnalyticsEngine.logAudioButtonClick(currentLanguage);
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: (screenWidth / 8).clamp(50.0, 100.0),
                      padding: EdgeInsets.all(padding),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.lightGreen,
                      ),
                      child: Center(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        child: Icon(
                          Icons.volume_up,
                          size: (screenWidth * 0.025).clamp(25.0, 50.0),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToCard(int direction) {
    int newIndex = currentCardIndex + direction;
    if (newIndex >= 0 && newIndex < flashCards.length) {
      setState(() {
        currentCardIndex = newIndex;
      });
    } else if (newIndex < 0) {
      Navigator.pop(context);
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LearnComplete()));
    }
  }
}
