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
import '../../../../utils/util.dart';

class FlashCard extends StatefulWidget {
  final String opSign;
  const FlashCard({super.key,required this.opSign});

  @override
  _FlashCardState createState() => _FlashCardState();
}



class _FlashCardState extends State<FlashCard> {
  FlutterTts flutterTts = FlutterTts();
  int currentCardIndex = 0;
  int currentLanguage = 0;
  List<String> LangKeys = [getSpeakLangKey(GlobalVariables.priLang), getSpeakLangKey(GlobalVariables.secLang)];
  late List<Map<String, dynamic>> flashCards;

  Future<void> ReadOut(String text) async {
    dynamic languages = await flutterTts.getLanguages ;
    await flutterTts.setLanguage(LangKeys[currentLanguage] ); // : 'es-ES'
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }


  @override
  void initState() {
    super.initState();
    flashCards  = get_op_data(widget.opSign);
    log("current lang : $flashCards");
  }

  void changeLang(){
    setState(() {
      currentLanguage = currentLanguage == 0 ? 1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth * 0.75;  // 75% of screen width
    double cardHeight = MediaQuery.of(context).size.height * 0.6; // 60% of screen height
    double padding = screenWidth * 0.01; // 1% of screen width for padding
    double buttonWidth = screenWidth * 0.15; // 15% of screen width for buttons
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.opSign),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout_rounded,
              color: Color(0xFF6C63FF),
              size: 26,
            ),
            onPressed: () => logout(context),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Mathoperations/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
                width: cardWidth,
                height: 600,
                child: _renderFlashCard(flashCards[currentCardIndex]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //SizedBox(width: 150),
                  InkWell(
                    onTap: () {
                      _navigateToCard(-1);
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: buttonWidth,
                      padding:  EdgeInsets.all(padding),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.lightBlue,
                      ),
                      child:  Center(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        child:Text(
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
                  //SizedBox(width: 600),
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
                      child:  Center(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        child:Text(
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderFlashCard(data ) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth * 0.75;  // 75% of screen width
    double cardHeight = MediaQuery.of(context).size.height * 0.6; // 60% of screen height
    double padding = screenWidth * 0.01; // 1% of screen width for padding
    double buttonWidth = screenWidth * 0.15; // 15% of screen width for buttons
    String rem = 'and remainder = ';
    if (data["op_sign"] == '÷'){
      rem +=  '${data['fst_num'] % data['snd_num']}.';
    }
    String signPron = '';
    if (data["op_sign"] == '-'){
      signPron = 'minus';
    }
    else if (data["op_sign"] == 'x'){
      signPron = 'multiplied by ';
    }
    else {
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
                        child:
                          Icon(
                            Icons.translate,
                            size: (screenWidth * 0.025).clamp(25.0, 50.0),
                          ),
                      ),
                    ),
                  ),
                  //SizedBox(width: 200),
                  InkWell(
                    onTap: () {
                      ReadOut(data['op_def'][currentLanguage] + "; " + data['op_name'][currentLanguage]);
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: (screenWidth / 8).clamp(50.0, 100.0),
                      padding: EdgeInsets.all(padding),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.lightGreen,
                      ),
                      child:  Center(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        child: 
                          Icon(
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
              FlashCardInfo(data["op_sign"], data['fst_num'], data['snd_num'],currentLanguage,fontSize: MediaQuery.of(context).size.width * 0.15,),
              const SizedBox(height: 20),              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //SizedBox(width: 350),
                  InkWell(
                    onTap: () {
                      changeLang();// Navigator.push(context, MaterialPageRoute(builder: (context) => LearnPage()));
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: (screenWidth / 8).clamp(50.0, 100.0),
                      padding:  EdgeInsets.all(padding),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.lightGreen,
                      ),
                      child:  Center(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        child:
                          Icon(
                            Icons.translate,
                            size: (screenWidth * 0.025).clamp(25.0, 50.0),
                          ),
                        
                      ),
                    ),
                  ),
                  //SizedBox(width: 200),
                  InkWell(
                    onTap: () {
                      ReadOut('${data["fst_num"]} $signPron ${data["snd_num"]}  = ${get_op_result(data["op_sign"], data["fst_num"], data["snd_num"])} ${data["op_sign"] == "÷" ? rem : "."}');
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: (screenWidth / 8).clamp(50.0, 100.0),
                      padding:  EdgeInsets.all(padding),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.lightGreen,
                      ),
                      child: Center(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        child: 
                          Icon(
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
    }
    else if (newIndex < 0 ){
      Navigator.pop(context);
    }
    else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LearnComplete()));
    }
  }
}

