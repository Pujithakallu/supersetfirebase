import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'dart:async';
import 'dart:math';
import 'package:provider/provider.dart';
import '../../utils/util.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameData1()),
      ],
      child: MaterialApp(
        home: HomeScreen(),
      ),
    ),
  );
}

class GameData1 extends ChangeNotifier {
  int total = 0; // Initialize total

  void setTotal(int value) {
    total += value; // Update total by adding the current game score
    notifyListeners();
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memory Game Home'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF4A4A4A)),
          onPressed: () => logout(context),
        ),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MemoryGame(),
                  ),
                );
              },
              child: Text('Start Game'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Exit'),
            ),
          ],
        ),
      ),
    );
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
  bool _start = false;
  bool _wait = false;
  List<String> _data = [];
  List<bool> _cardFlips = [];
  List<GlobalKey<FlipCardState>> _cardStateKeys = [];
  Map<String, String> _translations = {};
  int _matchedPairs = 0;
  int? chapter;
  late Timer _timer;
  int _seconds = 60; // 60 seconds timer

  @override
  void initState() {
    super.initState();
    _initializeTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeChapter();
  }

  void _initializeTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
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
          title: Text(
            "Times up! Try again.",
            style: TextStyle(fontSize: 25),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Restart Game'),
              onPressed: () {
                Navigator.pop(context);
                restart();
                setState(() {
                  _start = true;
                  _seconds = 60; // Reset the timer
                  _initializeTimer(); // Start the timer again
                });
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _initializeChapter() async {
    chapter = ModalRoute.of(context)?.settings.arguments as int?;
    _translations = getTranslations(chapter);
    restart();
    setState(() {
      _start = true;
    });
  }

  Widget getQuestionMarkCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 3,
            spreadRadius: 0.8,
            offset: Offset(2.0, 1),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset("assets/Mathmingle/question_mark.png"),
      ),
    );
  }

  void restart() {
    setState(() {
      _data = getSourceArray();
      _cardFlips = getInitialItemState();
      _cardStateKeys = getCardStateKeys();
      _start = false;
      _matchedPairs = 0;
      _wait = false;
    });
  }


  void showEndGameDialog(int score) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "C O N G R A T U L A T I O N S ! ! !",
            style: TextStyle(fontSize: 33),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "You've Matched All Cards!",
                style: TextStyle(fontSize: 29),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                "Score: $score/10",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: Text(
                      "N E W  G A M E",
                      style: TextStyle(fontSize: 25),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      restart();
                      setState(() {
                        _start = true;
                        _seconds = 60; // Reset the timer
                        _initializeTimer(); // Start the timer again
                      });
                    },
                  ),
                  TextButton(
                    child: Text(
                      "E X I T",
                      style: TextStyle(fontSize: 25),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
          contentPadding: EdgeInsets.all(30),
        );
      },
    );
  }

  @override
  void checkMatch(int currentIndex) {
    if (!_flip) {
      _flip = true;
      _previousIndex = currentIndex;
    } else {
      _flip = false;
      if (_previousIndex != currentIndex) {
        String englishText = _data[_previousIndex];
        String spanishText = _data[currentIndex];

        if (isMatch(englishText, spanishText)) {
          _cardFlips[_previousIndex] = false;
          _cardFlips[currentIndex] = false;
          _matchedPairs++;

          if (_matchedPairs == _data.length ~/ 2) {
            _timer.cancel();
            int score = (_seconds / 60 * 10).toInt(); // Calculate score based on time remaining
            showEndGameDialog(score);
            Future.delayed(Duration.zero, () {
              Provider.of<GameData1>(context, listen: false).setTotal(score);
            });
          }
        } else {
          _wait = true;

          Future.delayed(
            const Duration(milliseconds: 1500),
                () {
              _cardStateKeys[_previousIndex]?.currentState?.toggleCard();
              _cardStateKeys[currentIndex]?.currentState?.toggleCard();

              Future.delayed(
                const Duration(milliseconds: 160),
                    () {
                  setState(() {
                    _wait = false;
                  });
                },
              );
            },
          );
        }
      }
    }
    setState(() {});
  }

  bool isMatch(String englishText, String spanishText) {
    return _translations[englishText] == spanishText ||
        _translations[spanishText] == englishText;
  }

  @override
  Widget build(BuildContext context) {
    final int? chapter = ModalRoute.of(context)?.settings.arguments as int?;

    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    int crossAxisCount = isPortrait ? 4 : 5;

    if (!isPortrait && MediaQuery.of(context).size.shortestSide >= 600) {
      crossAxisCount = 5;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'R E M E M B E R  &  W I N ',
          style: TextStyle(fontSize: 45),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF4A4A4A)),
          onPressed: () => logout(context),
        ),
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            ClockDisplay(seconds: _seconds),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                  itemBuilder: (context, index) {
                    if (_start) {
                      return FlipCard(
                        key: _cardStateKeys[index],
                        onFlip: () {
                          if (!_wait) {
                            checkMatch(index);
                          }
                        },
                        flipOnTouch: _wait ? false : _cardFlips[index],
                        direction: FlipDirection.HORIZONTAL,
                        front: getQuestionMarkCard(),
                        back: Container(
                          decoration: BoxDecoration(
                            color: _cardFlips[index] ? Colors.grey[100] : Colors.green,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black45,
                                blurRadius: 3,
                                spreadRadius: 0.8,
                                offset: Offset(2.0, 1),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _data[index],
                                style: TextStyle(
                                  fontSize: isPortrait ? 30 : 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return getQuestionMarkCard();
                    }
                  },
                  itemCount: _data.length,
                  shrinkWrap: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<List<String>> fillSourceArray() {
    List<String> englishWords = [];
    List<String> spanishWords = [];

    switch (chapter) {
      case 1:
        englishWords = [
          'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten',"Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen", "Twenty"
        ];
        spanishWords = [
          'uno', 'dos', 'tres', 'cuatro', 'cinco', 'seis', 'siete', 'ocho', 'nueve', 'diez',"Once","Doce", "Trece", "Catorce", "Quince", "Dieciséis", "Diecisiete", "Dieciocho", "Diecinueve", "Veinte"
        ];
        break;
      case 2:
        englishWords = [
          'Numbers','Addition', 'Subtraction', 'Multiplication', 'Division', 'Equal',
          'Greater than', 'Less than', 'Plus', 'Minus', 'Times','Divided by',
          'Sum', 'Difference', 'Product', 'Quotient', 'Fraction',
          'Decimal', 'Ratio', 'Equation'];
        spanishWords = [
          'Número','Adición', 'Resta', 'Multiplicación', 'División', 'Igual',
          'Mayor que', 'Menor que', 'Más', 'Menos', 'Por','Dividido por',
          'Suma', 'Diferencia', 'Producto', 'Cociente', 'Fracción',
          'Decimal', 'Proporción', 'Ecuación'
        ];
        break;
      case 3:
        englishWords = [
          'Circle', 'Triangle', 'Square', 'Rectangle', 'Rhombus',
          'Parallelogram', 'Trapezium', 'Oval', 'Ellipse', 'Sphere',
          'Cube', 'Cylinder', 'Cone', 'Pentagonal prism', 'Hexagonal prism',
          'Pyramid', 'Cuboid', 'Triangular prism', 'Hemisphere', 'Torus',];
        spanishWords = [
          'Círculo', 'Triángulo', 'Cuadrado', 'Rectángulo', 'Rombus',
          'Paralelogramo', 'Trapecio', 'Óvalo', 'Elipse', 'Esfera',
          'Cubo', 'Cilindro', 'Cono', 'Prisma pentagonal', 'Prisma hexagonal',
          'Pirámide', 'Cuboide', 'Prisma triangular', 'Hemisferio', 'Toro',
        ];
        break;
      case 4:
        englishWords = ['+', '-', '=', '>', '<', '×', '÷', '√', '/', '%', '^', '∑', '∫', 'd/dx', '∞', '≠', '≥', '≤', '≈', 'lim'];
        spanishWords = [
          'Más', 'Menos', 'Igual', 'Mayor que', 'Menor que', 'Por', 'Dividido por', 'Raíz cuadrada',
          'Fracción', 'Porcentaje', 'Exponenciación', 'Sumatoria', 'Integral', 'Derivada', 'Infinito',
          'No igual a', 'Mayor o igual que', 'Menor o igual que', 'Aproximadamente igual a', 'Límite',
        ];
        break;
      case 5:
        englishWords = ["Length", "Width", "Height", "Diameter", "Radius", "Perimeter", "Circumference",
          "Area", "Volume", "Angle", "Slope", "Intersection", "Symmetry", "Perpendicular", "Parallel",
          "Coordinate", "Vertex", "Axis", "Hypotenuse", "Gradient",];
        spanishWords =[
          "Longitud", "Ancho", "Altura", "Diámetro", "Radio", "Perímetro", "Circunferencia", "Superficie",
          "Volumen", "Ángulo", "Pendiente", "Intersección", "Simetría", "Perpendicular",
          "Paralelo", "Coordenada", "Vértice", "Eje", "Hipotenusa", "Gradiente",
        ];
        break;
      default:
        englishWords = [];
        spanishWords = [];
    }

    return [englishWords, spanishWords];
  }

  List<String> getSourceArray() {
    List<String> levelAndKindList = [];
    List<List<String>> sourceArrays = fillSourceArray();

    List<int> uniqueRandomIndices = [];
    while (uniqueRandomIndices.length < 5) {
      int randomIndex = Random().nextInt(20);
      if (!uniqueRandomIndices.contains(randomIndex)) {
        uniqueRandomIndices.add(randomIndex);
      }
    }

    for (int i = 0; i < 5; i++) {
      int randomIndex = uniqueRandomIndices[i];
      if (sourceArrays[0].length > randomIndex &&
          sourceArrays[1].length > randomIndex) {
        levelAndKindList.add(sourceArrays[0][randomIndex]);
        levelAndKindList.add(sourceArrays[1][randomIndex]);
      }
    }

    levelAndKindList.shuffle();
    return levelAndKindList;
  }

  List<bool> getInitialItemState() {
    List<bool> initialItemState = [];

    for (int i = 0; i < _data.length; i++) {
      initialItemState.add(true);
    }

    return initialItemState;
  }

  List<GlobalKey<FlipCardState>> getCardStateKeys() {
    List<GlobalKey<FlipCardState>> cardStateKeys = [];

    for (int i = 0; i < _data.length; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }

    return cardStateKeys;
  }

  Map<String, String> getTranslations(int? chapter) {
    switch (chapter) {
      case 1:
        return {
          'one': 'uno',
          'two': 'dos',
          'three': 'tres',
          'four': 'cuatro',
          'five': 'cinco',
          'six': 'seis',
          'seven': 'siete',
          'eight': 'ocho',
          'nine': 'nueve',
          'ten': 'diez',
          "Eleven": "Once",
          "Twelve": "Doce",
          "Thirteen":"Trece",
          "Fourteen" : "Catorce",
          "Fifteen" : "Quince",
          "Sixteen" : "Dieciséis",
          "Seventeen": "Diecisiete",
          "Eighteen" : "Dieciocho",
          "Nineteen" : "Diecinueve",
          "Twenty" : "Veinte",

        };
      case 2:
        return {
          'Numbers': 'Número',
          'Addition': 'Adición',
          'Subtraction': 'Resta',
          'Multiplication': 'Multiplicación',
          'Division': 'División',
          'Equal': 'Igual',
          'Greater than': 'Mayor que',
          'Less than': 'Menor que',
          'Plus': 'Más',
          'Minus': 'Menos',
          'Times': 'Por',
          'Divided by': 'Dividido por',
          'Sum': 'Suma',
          'Difference': 'Diferencia',
          'Product': 'Producto',
          'Quotient': 'Cociente',
          'Fraction': 'Fracción',
          'Decimal': 'Decimal',
          'Ratio': 'Proporción',
          'Equation': 'Ecuación',
        };
      case 3:
        return {
          'Circle': 'Círculo',
          'Triangle': 'Triángulo',
          'Square': 'Cuadrado',
          'Rectangle': 'Rectángulo',
          'Rhombus': 'Rombus',
          'Parallelogram': 'Paralelogramo',
          'Trapezium': 'Trapecio',
          'Oval': 'Óvalo',
          'Ellipse': 'Elipse',
          'Sphere': 'Esfera',
          'Cube': 'Cubo',
          'Cylinder': 'Cilindro',
          'Cone': 'Cono',
          'Pentagonal prism': 'Prisma pentagonal',
          'Hexagonal prism': 'Prisma hexagonal',
          'Pyramid': 'Pirámide',
          'Cuboid': 'Cuboide',
          'Triangular prism': 'Prisma triangular',
          'Hemisphere': 'Hemisferio',
          'Torus': 'Toro',
        };
      case 4:
        return {
          '+': 'Más',
          '-': 'Menos',
          '=': 'Igual',
          '>': 'Mayor que',
          '<': 'Menor que',
          '×': 'Por',
          '÷': 'Dividido por',
          '√': 'Raíz cuadrada',
          '/': 'Fracción',
          '%': 'Porcentaje',
          '^': 'Exponenciación',
          '∑': 'Sumatoria',
          '∫': 'Integral',
          'd/dx': 'Derivada',
          '∞': 'Infinito',
          '≠': 'No igual a',
          '≥': 'Mayor o igual que',
          '≤': 'Menor o igual que',
          '≈': 'Aproximadamente igual a',
          'lim': 'Límite',
        };
      case 5:
        return {
          'Length': 'Longitud',
          'Width': 'Ancho',
          'Height': 'Altura',
          'Diameter': 'Diámetro',
          'Radius': 'Radio',
          'Perimeter': 'Perímetro',
          'Circumference': 'Circunferencia',
          'Area': 'Superficie',
          'Volume': 'Volumen',
          'Angle': 'Ángulo',
          'Slope': 'Pendiente',
          'Intersection': 'Intersección',
          'Symmetry': 'Simetría',
          'Perpendicular': 'Perpendicular',
          'Parallel': 'Paralelo',
          'Coordinate': 'Coordenada',
          'Vertex': 'Vértice',
          'Axis': 'Eje',
          'Hypotenuse': 'Hipotenusa',
          'Gradient': 'Gradiente',
        };
      default:
        return {};
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
    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white70.withOpacity(0.5),
        ),
        child: Text(
          '$minutes:${remainingSeconds.toString().padLeft(2, '0')}',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}