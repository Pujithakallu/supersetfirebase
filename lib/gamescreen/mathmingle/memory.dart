// lib/gamescreen/mathmingle/memory.dart
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'dart:async';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';
import 'score_topbar.dart';
import 'package:supersetfirebase/utils/logout_util.dart';

class GameData1 extends ChangeNotifier {
  int total = 0;
  void setTotal(int value) {
    total += value;
    notifyListeners();
  }
}

class MemoryGame extends StatefulWidget {
  const MemoryGame({Key? key}) : super(key: key);

  @override
  _MemoryGameState createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  int _previousIndex = -1;
  bool _flip = false;
  bool _wait = false;
  List<String> _data = [];
  List<bool> _cardFlips = [];
  List<GlobalKey<FlipCardState>> _cardStateKeys = [];
  Map<String, String> _translations = {};
  int _matchedPairs = 0;
  int? chapter;
  late Timer _timer;
  int _seconds = 60;

  @override
  void initState() {
    super.initState();
    _initializeTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chapter = ModalRoute.of(context)?.settings.arguments as int? ?? 1;
      _translations = getTranslations(chapter!);
      restart();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _initializeTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer.cancel();
          _handleTimeUp();
        }
      });
    });
  }

  void _handleTimeUp() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Times up! Try again.", style: TextStyle(fontSize: 25)),
          actions: <Widget>[
            TextButton(
              child: const Text('Restart Game'),
              onPressed: () {
                Navigator.pop(context);
                restart();
                setState(() {
                  _seconds = 60;
                  _initializeTimer();
                });
              },
            ),
          ],
        );
      },
    );
  }

  void restart() {
    setState(() {
      _data = getSourceArray(chapter!);
      _cardFlips = List<bool>.filled(_data.length, true);
      _cardStateKeys = List.generate(_data.length, (_) => GlobalKey<FlipCardState>());
      _matchedPairs = 0;
      _flip = false;
      _wait = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    int crossAxisCount = isPortrait ? 4 : 5;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: TopBarWithScore(
        onBack: () => Navigator.pop(context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => logout(context),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.logout_rounded, size: 28, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: <Widget>[
            const Text(
              'R E M E M B E R  &  W I N',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, letterSpacing: 2.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ClockDisplay(seconds: _seconds),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                  itemCount: _data.length,
                  itemBuilder: (context, index) {
                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 70,
                          height: 80,
                          child: FlipCard(
                            key: _cardStateKeys[index],
                            onFlip: () {
                              if (!_wait) {
                                checkMatch(index);
                              }
                            },
                            flipOnTouch: !_wait && _cardFlips[index],
                            direction: FlipDirection.HORIZONTAL,
                            front: getQuestionMarkCard(),
                            back: Container(
                              decoration: BoxDecoration(
                                color: _cardFlips[index] ? Colors.grey[100] : Colors.green,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: Text(
                                _data[index],
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).orientation == Orientation.portrait ? 30 : 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkMatch(int currentIndex) {
    if (!_flip) {
      _flip = true;
      _previousIndex = currentIndex;
    } else {
      _flip = false;
      if (_previousIndex != currentIndex) {
        String text1 = _data[_previousIndex];
        String text2 = _data[currentIndex];
        if (isMatch(text1, text2)) {
          setState(() {
            _cardFlips[_previousIndex] = false;
            _cardFlips[currentIndex] = false;
            _matchedPairs++;
          });
          if (_matchedPairs == _data.length ~/ 2) {
            _timer.cancel();
            int score = ((_seconds / 60) * 10).toInt();
            showEndGameDialog(score);
            Future.delayed(Duration.zero, () {
              Provider.of<GameData1>(context, listen: false).setTotal(score);
            });
          }
        } else {
          _wait = true;
          Future.delayed(const Duration(milliseconds: 1500), () {
            if (!mounted) return;
            _cardStateKeys[_previousIndex].currentState?.toggleCard();
            _cardStateKeys[currentIndex].currentState?.toggleCard();
            Future.delayed(const Duration(milliseconds: 160), () {
              if (!mounted) return;
              setState(() {
                _wait = false;
              });
            });
          });
        }
      }
    }
  }

  void showEndGameDialog(int score) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("C O N G R A T U L A T I O N S ! ! !", style: TextStyle(fontSize: 33)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("You've Matched All Cards!", style: TextStyle(fontSize: 29), textAlign: TextAlign.center),
              const SizedBox(height: 20),
              Text("Score: $score/10", style: const TextStyle(fontSize: 25)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: const Text("N E W  G A M E", style: TextStyle(fontSize: 25)),
                    onPressed: () {
                      Navigator.pop(context);
                      restart();
                      setState(() {
                        _seconds = 60;
                        _initializeTimer();
                      });
                    },
                  ),
                  TextButton(
                    child: const Text("E X I T", style: TextStyle(fontSize: 25)),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
          contentPadding: const EdgeInsets.all(30),
        );
      },
    );
  }

  bool isMatch(String t1, String t2) {
    return _translations[t1] == t2 || _translations[t2] == t1;
  }

  Widget getQuestionMarkCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 3,
            spreadRadius: 0.8,
            offset: Offset(2.0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset("assets/Mathmingle/question_mark.png"),
      ),
    );
  }

  List<String> getSourceArray(int chapter) {
    List<List<String>> sourceArrays = fillSourceArray(chapter);
    List<int> uniqueRandomIndices = [];
    while (uniqueRandomIndices.length < 5) {
      int r = Random().nextInt(20);
      if (!uniqueRandomIndices.contains(r)) {
        uniqueRandomIndices.add(r);
      }
    }
    List<String> levelAndKindList = [];
    for (int i = 0; i < 5; i++) {
      int index = uniqueRandomIndices[i];
      levelAndKindList.add(sourceArrays[0][index]);
      levelAndKindList.add(sourceArrays[1][index]);
    }
    levelAndKindList.shuffle();
    return levelAndKindList;
  }

  List<List<String>> fillSourceArray(int chapter) {
    List<String> englishWords = [];
    List<String> spanishWords = [];
    switch (chapter) {
      case 1:
        englishWords = [
          'one','two','three','four','five','six','seven','eight','nine','ten',
          "Eleven","Twelve","Thirteen","Fourteen","Fifteen",
          "Sixteen","Seventeen","Eighteen","Nineteen","Twenty"
        ];
        spanishWords = [
          'uno','dos','tres','cuatro','cinco','seis','siete','ocho','nueve','diez',
          "Once","Doce","Trece","Catorce","Quince","Dieciséis","Diecisiete",
          "Dieciocho","Diecinueve","Veinte"
        ];
        break;
      case 2:
        englishWords = [
          'Numbers','Addition','Subtraction','Multiplication','Division','Equal','Greater than',
          'Less than','Plus','Minus','Times','Divided by','Sum','Difference','Product',
          'Quotient','Fraction','Decimal','Ratio','Equation'
        ];
        spanishWords = [
          'Número','Adición','Resta','Multiplicación','División','Igual','Mayor que','Menor que',
          'Más','Menos','Por','Dividido por','Suma','Diferencia','Producto','Cociente','Fracción',
          'Decimal','Proporción','Ecuación'
        ];
        break;
      case 3:
        englishWords = [
          'Circle','Triangle','Square','Rectangle','Rhombus','Parallelogram','Trapezium','Oval',
          'Ellipse','Sphere','Cube','Cylinder','Cone','Pentagonal prism','Hexagonal prism',
          'Pyramid','Cuboid','Triangular prism','Hemisphere','Torus'
        ];
        spanishWords = [
          'Círculo','Triángulo','Cuadrado','Rectángulo','Rombus','Paralelogramo','Trapecio','Óvalo',
          'Elipse','Esfera','Cubo','Cilindro','Cono','Prisma pentagonal','Prisma hexagonal','Pirámide',
          'Cuboide','Prisma triangular','Hemisferio','Toro'
        ];
        break;
      case 4:
        englishWords = [
          '+','-','=','>','<','×','÷','√','/','%','^','∑','∫','d/dx','∞','≠','≥','≤','≈','lim'
        ];
        spanishWords = [
          'Más','Menos','Igual','Mayor que','Menor que','Por','Dividido por','Raíz cuadrada','Fracción',
          'Porcentaje','Exponenciación','Sumatoria','Integral','Derivada','Infinito','No igual a',
          'Mayor o igual que','Menor o igual que','Aproximadamente igual a','Límite'
        ];
        break;
      case 5:
        englishWords = [
          "Length","Width","Height","Diameter","Radius","Perimeter","Circumference","Area","Volume","Angle",
          "Slope","Intersection","Symmetry","Perpendicular","Parallel","Coordinate","Vertex","Axis","Hypotenuse",
          "Gradient"
        ];
        spanishWords = [
          "Longitud","Ancho","Altura","Diámetro","Radio","Perímetro","Circunferencia","Superficie","Volumen","Ángulo",
          "Pendiente","Intersección","Simetría","Perpendicular","Paralelo","Coordenada","Vértice","Eje","Hipotenusa",
          "Gradiente"
        ];
        break;
      default:
        englishWords = ['one','two'];
        spanishWords = ['uno','dos'];
    }
    return [englishWords, spanishWords];
  }

  Map<String, String> getTranslations(int chapter) {
    switch (chapter) {
      case 1:
        return {
          'one': 'uno','two': 'dos','three': 'tres','four': 'cuatro','five': 'cinco','six': 'seis',
          'seven': 'siete','eight': 'ocho','nine': 'nueve','ten': 'diez','Eleven': 'Once','Twelve': 'Doce',
          'Thirteen': 'Trece','Fourteen': 'Catorce','Fifteen': 'Quince','Sixteen': 'Dieciséis',
          'Seventeen': 'Diecisiete','Eighteen': 'Dieciocho','Nineteen': 'Diecinueve','Twenty': 'Veinte'
        };
      case 2:
        return {
          'Numbers': 'Número','Addition': 'Adición','Subtraction': 'Resta','Multiplication': 'Multiplicación',
          'Division': 'División','Equal': 'Igual','Greater than': 'Mayor que','Less than': 'Menor que',
          'Plus': 'Más','Minus': 'Menos','Times': 'Por','Divided by': 'Dividido por','Sum': 'Suma',
          'Difference': 'Diferencia','Product': 'Producto','Quotient': 'Cociente','Fraction': 'Fracción',
          'Decimal': 'Decimal','Ratio': 'Proporción','Equation': 'Ecuación'
        };
      case 3:
        return {
          'Circle': 'Círculo','Triangle': 'Triángulo','Square': 'Cuadrado','Rectangle': 'Rectángulo',
          'Rhombus': 'Rombus','Parallelogram': 'Paralelogramo','Trapezium': 'Trapecio','Oval': 'Óvalo',
          'Ellipse': 'Elipse','Sphere': 'Esfera','Cube': 'Cubo','Cylinder': 'Cilindro','Cone': 'Cono',
          'Pentagonal prism': 'Prisma pentagonal','Hexagonal prism': 'Prisma hexagonal','Pyramid': 'Pirámide',
          'Cuboid': 'Cuboide','Triangular prism': 'Prisma triangular','Hemisphere': 'Hemisferio','Torus': 'Toro'
        };
      case 4:
        return {
          '+': 'Más','-': 'Menos','=': 'Igual','>': 'Mayor que','<': 'Menor que','×': 'Por','÷': 'Dividido por',
          '√': 'Raíz cuadrada','/': 'Fracción','%': 'Porcentaje','^': 'Exponenciación','∑': 'Sumatoria',
          '∫': 'Integral','d/dx': 'Derivada','∞': 'Infinito','≠': 'No igual a','≥': 'Mayor o igual que',
          '≤': 'Menor o igual que','≈': 'Aproximadamente igual a','lim': 'Límite'
        };
      case 5:
        return {
          "Length": "Longitud","Width": "Ancho","Height": "Altura","Diameter": "Diámetro","Radius": "Radio",
          "Perimeter": "Perímetro","Circumference": "Circunferencia","Area": "Superficie","Volume": "Volumen",
          "Angle": "Ángulo","Slope": "Pendiente","Intersection": "Intersección","Symmetry": "Simetría",
          "Perpendicular": "Perpendicular","Parallel": "Paralelo","Coordinate": "Coordenada","Vertex": "Vértice",
          "Axis": "Eje","Hypotenuse": "Hipotenusa","Gradient": "Gradiente"
        };
      default:
        return {
          'one': 'uno','two': 'dos'
        };
    }
  }
}

class ClockDisplay extends StatelessWidget {
  final int seconds;
  const ClockDisplay({Key? key, required this.seconds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white70.withOpacity(0.5),
          ),
          alignment: Alignment.center,
          child: Text(
            '$minutes:${remainingSeconds.toString().padLeft(2, '0')}',
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
