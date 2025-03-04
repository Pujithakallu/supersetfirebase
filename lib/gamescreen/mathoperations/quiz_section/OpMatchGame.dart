import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:supersetfirebase/utils/logout_util.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';

class OperatorsMatchingGamePage extends StatefulWidget {
  const OperatorsMatchingGamePage({Key? key}) : super(key: key);

  @override
  State<OperatorsMatchingGamePage> createState() =>
      _OperatorsMatchingGamePageState();
}

final Color defaultNameColor =
    Colors.lightBlue[100]!; // Default color for names
final Color defaultSymbolColor =
    Colors.lightGreen[50]!; // Default color for symbols

class _OperatorsMatchingGamePageState extends State<OperatorsMatchingGamePage> {
  final List<Map<String, String>> gameItems = [
    {'name': 'Addition', 'symbol': '+'},
    {'name': 'Subtraction', 'symbol': '-'},
    {'name': 'Multiplication', 'symbol': 'x'},
    {'name': 'Division', 'symbol': '÷'},
  ];

  late List<Map<String, String>> shuffledNames;
  late List<Map<String, String>> shuffledSymbols;
  Map<String, Color> itemColors = {};
  final Set<String> matchedNames = {};
  final Set<String> matchedSymbols = {};
  String? selectedName;
  String? selectedSymbol;

  @override
  void initState() {
    super.initState();
    _shuffleGameItems();
  }

  void _shuffleGameItems() {
    shuffledNames = List<Map<String, String>>.from(gameItems)..shuffle();
    shuffledSymbols = List<Map<String, String>>.from(gameItems)
      ..shuffle(math.Random());
  }

  void _handleItemTap(String name, String symbol, bool isName) {
    setState(() {
      // This logic handles the tap, checks for matches, and updates UI accordingly.
      final isSelectedBefore =
          isName ? selectedName != null : selectedSymbol != null;

      if (isName) {
        if (isSelectedBefore || selectedSymbol == null) {
          selectedName = name;
          itemColors[name] = Colors.blue;
        } else {
          selectedName = name;
          _checkAndApplyMatch();
        }
      } else {
        if (isSelectedBefore || selectedName == null) {
          selectedSymbol = symbol;
          itemColors[symbol] = Colors.blue;
        } else {
          selectedSymbol = symbol;
          _checkAndApplyMatch();
        }
      }
    });
  }

  void _checkAndApplyMatch() {
    if (selectedName != null && selectedSymbol != null) {
      bool isMatch = gameItems.any((item) =>
          item['name'] == selectedName && item['symbol'] == selectedSymbol);
      if (isMatch) {
        // Correct match
        itemColors[selectedName!] = Colors.green;
        itemColors[selectedSymbol!] = Colors.green;
        matchedNames.add(selectedName!);
        matchedSymbols.add(selectedSymbol!);
      } else {
        // Incorrect match
        itemColors[selectedName!] = Colors.red;
        itemColors[selectedSymbol!] = Colors.red;
      }
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          if (!isMatch) {
            itemColors.remove(selectedName);
            itemColors.remove(selectedSymbol);
          }
          selectedName = null;
          selectedSymbol = null;
        });

        if (matchedNames.length == gameItems.length) {
          _showCompletionDialog();
        }
      });
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/Mathoperations/despicable-me-minions.gif',
              height: 200,
            ),
            SizedBox(
              width: 190,
              child: AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'Congratulations!',
                    textStyle: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Horizon',
                    ),
                    colors: [
                      Colors.purple,
                      Colors.blue,
                      Colors.yellow,
                      Colors.red,
                    ],
                  ),
                ],
                isRepeatingAnimation: true,
                onTap: () {
                  print("Tap Event");
                },
              ),
            ),
            Text(
              'You got it right!',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          FilledButton(
            onPressed: () {
              _restartGame();
              Navigator.pop(context);
            },
            child: Text(
              'Restart',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('Back to Levels'),
          ),
        ],
      ),
    );
  }

  void _restartGame() {
    setState(() {
      _shuffleGameItems();
      itemColors.clear();
      matchedNames.clear();
      matchedSymbols.clear();
      selectedName = null;
      selectedSymbol = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    String userPin = Provider.of<UserPinProvider>(context, listen: false).pin;
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Mathoperations/home_screen.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            // Add padding around the content
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center vertically
              children: [
                SizedBox(height: 20),
                Text(
                  'Operator Matching',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 50),
                ),
                SizedBox(height: 80),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // Center horizontally
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: shuffledNames.length,
                          itemBuilder: (context, index) {
                            var item = shuffledNames[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 100),
                              // Adjust card spacing
                              color:
                                  itemColors[item['name']] ?? defaultNameColor,
                              child: ListTile(
                                title: Text(
                                  item['name']!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26),
                                ),
                                onTap: () => _handleItemTap(
                                    item['name']!, item['symbol']!, true),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: shuffledSymbols.length,
                          itemBuilder: (context, index) {
                            var item = shuffledSymbols[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 100),
                              // Adjust card spacing
                              color: itemColors[item['symbol']] ??
                                  defaultSymbolColor,
                              child: ListTile(
                                title: Text(
                                  item['symbol']!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 26),
                                ),
                                onTap: () => _handleItemTap(
                                    item['name']!, item['symbol']!, false),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
