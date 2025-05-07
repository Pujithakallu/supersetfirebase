import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flip_card/flip_card.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/languageconverter.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/learn_section/learn_complete.dart';
import 'flash_card_info.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/operator_data/op_data.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/comm_functions.dart';
import 'dart:developer' as dev;
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
    await flutterTts.setLanguage(LangKeys[currentLanguage]);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }

  @override
  void initState() {
    super.initState();
    flashCards = get_op_data(widget.opSign);
    dev.log("current lang : \$flashCards");
  }

  void changeLang() async {
    setState(() {
      currentLanguage = currentLanguage == 0 ? 1 : 0;
    });
    String newLanguage = languageNames[currentLanguage];
    await AnalyticsEngine.logTranslateButtonClickLearn(newLanguage);
  }

  @override
  Widget build(BuildContext context) {
    String userPin = Provider.of<UserPinProvider>(context, listen: false).pin;
    double screenWidth = MediaQuery.of(context).size.width;
    double baseScale = (MediaQuery.of(context).size.shortestSide) / 100;

    double cardWidth = screenWidth * 0.75;
    double cardHeight = MediaQuery.of(context).size.height * 0.6;
    double padding = baseScale * 2;
    double buttonWidth = screenWidth * 0.15;
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
            ),
            Positioned(
              left: 16,
              top: 12,
              child: FloatingActionButton(
                heroTag: "backButton",
                onPressed: () => Navigator.pop(context),
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                shape: const CircleBorder(),
                mini: true,
                child: const Icon(Icons.arrow_back_rounded, size: 32, color: Colors.black),
              ),
            ),
            Positioned(
              top: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                constraints: const BoxConstraints(maxWidth: 120),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
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
                    'PIN: ${userPin}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
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
                    child: Container(
                      padding:  EdgeInsets.fromLTRB((baseScale * 2).clamp(12.0, 24.0), (MediaQuery.of(context).padding.top + baseScale * 0.8).clamp(8.0, 40.0),(baseScale * 2).clamp(12.0, 24.0), (baseScale * 5).clamp(30.0, 60.0),),
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: _renderFlashCard(flashCards[currentCardIndex]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: (baseScale * 1.5).clamp(6.0, 16.0),bottom: (baseScale * 2).clamp(10.0, 30.0),),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _navigationButton("Back", -1),
                        _navigationButton("Next", 1),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 12,
            child: FloatingActionButton(
              heroTag: "logoutButton",
              onPressed: () => logout(context),
              foregroundColor: Colors.white,
              backgroundColor: Colors.white,
              shape: const CircleBorder(),
              mini: true,
              child: const Icon(Icons.logout_rounded, size: 32, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navigationButton(String label, int direction) {
    double baseScale = MediaQuery.of(context).size.shortestSide / 100;
    return InkWell(
      onTap: () => _navigateToCard(direction),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.15,
        padding: EdgeInsets.all((baseScale * 1.5).clamp(6.0, 16.0)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.lightBlue,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: ((baseScale * 2.2).clamp(14.0, 24.0)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderFlashCard(data) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double baseScale = min(screenWidth, screenHeight);
    double padding = screenWidth * 0.01;
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
      margin: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.6,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data["op_sign"],
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: (baseScale * 0.1).clamp(20.0, 60.0),
                        height: 0.8,
                      ),
                    ),
                    Text(
                      data["op_name"][currentLanguage],
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: (baseScale * 0.05).clamp(12.0, 32.0),
                      ),
                    ),
                    Text(
                      data["op_def"][currentLanguage],
                      style: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                        fontSize: (baseScale * 0.04).clamp(10.0, 30.0),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            changeLang();
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            width: (screenWidth / 8).clamp(100.0, 150.0),
                            padding: EdgeInsets.all(padding),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.lightGreen,
                            ),
                            child: Center(
                              child: Text(
                                currentLanguage == 0 ? 'Español' : 'English',
                                style: TextStyle(
                                  fontSize: (baseScale * 0.02).clamp(16.0, 28.0),
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            ReadOut(data['op_def'][currentLanguage] + "; " + data['op_name'][currentLanguage]);
                            await AnalyticsEngine.logAudioButtonClick(currentLanguage);
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            width: (screenWidth / 8).clamp(100.0, 150.0),
                            padding: EdgeInsets.all(padding),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.lightGreen,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.volume_up,
                                size: (baseScale * 0.015).clamp(25.0, 50.0),
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
          ),
        ),
        back: Container(
          decoration: const BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.6,
              ),
              child: IntrinsicHeight(
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
                    SizedBox(height: screenHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            changeLang();
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            width: (screenWidth / 8).clamp(100.0, 150.0),
                            padding: EdgeInsets.all(padding),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.lightGreen,
                            ),
                            child: Center(
                              child: Text(
                                currentLanguage == 0 ? 'Español' : 'English',
                                style: TextStyle(
                                  fontSize: (baseScale * 0.02).clamp(16.0, 28.0),
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            ReadOut('${data["fst_num"]} \$signPron ${data["snd_num"]} = \${get_op_result(data["op_sign"], data["fst_num"], data["snd_num"])} \${data["op_sign"] == "÷" ? rem : "."}');
                            await AnalyticsEngine.logAudioButtonClick(currentLanguage);
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            width: (screenWidth / 8).clamp(100.0, 150.0),
                            padding: EdgeInsets.all(padding),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.lightGreen,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.volume_up,
                                size: (baseScale * 0.015).clamp(25.0, 50.0),
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
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LearnComplete()));
    }
  }
}

