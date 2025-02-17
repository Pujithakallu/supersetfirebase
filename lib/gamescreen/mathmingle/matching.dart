import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:supersetfirebase/utils/logout_util.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';

class GameData extends ChangeNotifier {
  int total = 0; // Initialize total

  void setTotal(int value) {
    total += value; // Update total by adding the current game score
    notifyListeners();
  }
}

class MatchGame extends StatefulWidget {
  const MatchGame({Key? key}) : super(key: key);
  @override
  _MatchGameState createState() => _MatchGameState();
}

class _MatchGameState extends State<MatchGame> {
  late List<ItemModel> items;
  late List<ItemModel> items2;

  int score = 0;
  bool gameOver = false;
  bool isGameStarted = false; // Added variable to track if the game has started
  int? chapter;
  late GameData gameData;

  @override
  Widget build(BuildContext context) {
    chapter = ModalRoute.of(context)?.settings.arguments as int? ?? 2;
    String userPin = Provider.of<UserPinProvider>(context, listen: false).pin;
    if (chapter == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Error: Chapter not provided.'),
        ),
      );
    }

    if (!isGameStarted) {
      // Display a loading indicator or a start button until the game starts
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
                child: const Icon(Icons.arrow_back_ios, size: 24),
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
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/Mathmingle/forest.gif"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'J U N G L E    M A T C H I N G    S A F A R I',
                  style: TextStyle(fontSize: 45, color: Colors.white),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        //primary: Colors.greenAccent, // Set an inviting color
                        padding:
                            EdgeInsets.all(32.0), // Increase button padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () {
                        startGame(chapter!);
                      },
                      child: Text(
                        'Start Game',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        //primary: Colors.blue, // Set an inviting color
                        padding:
                            EdgeInsets.all(32.0), // Increase button padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context); // Exit the screen
                      },
                      child: Text(
                        'Exit',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (items.isEmpty) gameOver = true;
    if (gameOver) {
      Future.delayed(Duration.zero, () {
        Provider.of<GameData>(context, listen: false).setTotal(score);
      });
    }
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
              child: const Icon(Icons.arrow_back_ios, size: 24),
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Mathmingle/forest.gif"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Game Title (Now Outside AppBar)
                Text(
                  'J U N G L E    M A T C H I N G    S A F A R I',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Adjust as needed
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),

                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "S C O R E : ",
                      style: TextStyle(
                          color: Colors.yellowAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 30)),
                  TextSpan(
                    text: "$score",
                    style: TextStyle(
                      color: Colors.yellowAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  )
                ])),
                if (!gameOver)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: items.map((item) {
                          return Container(
                            width: 150, // Adjusted width
                            height: 150, // Adjusted height
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              border:
                                  Border.all(color: Colors.white70, width: 2.0),
                            ),
                            child: Center(
                              child: Draggable<ItemModel>(
                                data: item,
                                childWhenDragging: Container(),
                                feedback: Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                        color: Colors.white70, width: 2.0),
                                  ),
                                  child: Text(
                                    item.value,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                        color: Colors.white70, width: 2.0),
                                  ),
                                  child: Text(
                                    item.value,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      Spacer(),
                      Column(
                        children: items2.map((item) {
                          return Container(
                            width: 150, // Adjusted width
                            height: 150, // Adjusted height
                            child: DragTarget<ItemModel>(
                              onAccept: (receivedItem) {
                                if (item.value == receivedItem.value) {
                                  setState(() {
                                    items.remove(receivedItem);
                                    items2.remove(item);
                                    score +=
                                        2; // Increase score by 2 if correct
                                    item.accepting = false;
                                  });
                                } else {
                                  setState(() {
                                    score -= 1; // Reduce score by 1 if wrong
                                    item.accepting = false;
                                  });
                                }
                              },
                              onLeave: (receivedItem) {
                                setState(() {
                                  item.accepting = false;
                                });
                              },
                              onWillAccept: (receivedItem) {
                                setState(() {
                                  item.accepting = true;
                                });
                                return true;
                              },
                              builder: (context, acceptedItems, rejectedItem) =>
                                  Container(
                                decoration: BoxDecoration(
                                  color: item.accepting
                                      ? Colors.red
                                      : Colors.white70,
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      color: Colors.white, width: 2.0),
                                ),
                                height: 150, // Adjusted height
                                width: 150, // Adjusted width
                                alignment: Alignment.center,
                                margin: const EdgeInsets.all(8.0),
                                child: Text(
                                  item.name,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                if (gameOver)
                  Text(
                    "G a m e  O v e r",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                if (gameOver)
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly, // Adjusted spacing
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          //primary: Colors.pink,
                          padding:
                              EdgeInsets.all(16.0), // Increased button padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          startGame(chapter!);
                        },
                        child: Text(
                          "New Game",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          //primary: Colors.blue,
                          padding:
                              EdgeInsets.all(16.0), // Increased button padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Exit",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    items = [];
    items2 = [];
  }

  void startGame(int chapter) {
    setState(() {
      isGameStarted = true;
      gameOver = false;
      score = 0;
      initGame(chapter: chapter);
    });
  }

  Future<Map<String, List<String>>> loadJsonData(int chapter) async {
    String jsonString = await rootBundle
        .loadString('assets/Mathmingle/matchGame/chapter$chapter.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    List<String> spanish = List<String>.from(jsonMap['spanish']);
    List<String> english = List<String>.from(jsonMap['english']);
    return {'spanish': english, 'english': spanish};
  }

  bool initialized = false; // Add this variable at the top of your State class

  void initGame({required int chapter}) async {
    List<int> randomIndices = List.generate(20, (index) => index)..shuffle();

    final jsonData = await loadJsonData(chapter);

    setState(() {
      items = List.generate(5, (index) {
        int randomIndex = randomIndices[index];
        return ItemModel(
            name: jsonData['spanish']![randomIndex],
            value: jsonData['english']![randomIndex]);
      });

      items2 = List<ItemModel>.from(items);
      items.shuffle();
      items2.shuffle();
    });
  }
}

class ItemModel {
  final String name;
  final String value;
  bool accepting;

  ItemModel({required this.name, required this.value, this.accepting = false});
}
