// matching.dart
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:supersetfirebase/utils/logout_util.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';
import 'package:supersetfirebase/gamescreen/mathmingle/memory.dart'; // just for example if needed
import 'score_topbar.dart';

class GameData extends ChangeNotifier {
  int total = 0;

  void setTotal(int value) {
    total += value;
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
  bool isGameStarted = false;
  int? chapter;

  @override
  void initState() {
    super.initState();
    items = [];
    items2 = [];
  }

  @override
  Widget build(BuildContext context) {
    chapter = ModalRoute.of(context)?.settings.arguments as int? ?? 2;
    String userPin = Provider.of<UserPinProvider>(context, listen: false).pin;

    if (chapter == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Error: Chapter not provided.')),
      );
    }

    // If not started, show "Start Game" screen
    if (!isGameStarted) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: TopBarWithScore(
            onBack: () => Navigator.pop(context),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/Mathmingle/forest.gif"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'J U N G L E    M A T C H I N G    S A F A R I',
                  style: TextStyle(fontSize: 45, color: Colors.white),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(32.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () {
                        startGame(chapter!);
                      },
                      child: const Text(
                        'Start Game',
                        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(32.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Exit',
                        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
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
      // Mark the final score
      Future.delayed(Duration.zero, () {
        Provider.of<GameData>(context, listen: false).setTotal(score);
      });
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: TopBarWithScore(
          onBack: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Mathmingle/forest.gif"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                const Text(
                  'J U N G L E    M A T C H I N G    S A F A R I',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text.rich(
                  TextSpan(children: [
                    const TextSpan(
                      text: "S C O R E : ",
                      style: TextStyle(
                          color: Colors.yellowAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    TextSpan(
                      text: "$score",
                      style: const TextStyle(
                        color: Colors.yellowAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    )
                  ]),
                ),
                const SizedBox(height: 20),
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
                              border: Border.all(color: Colors.white70, width: 2.0),
                            ),
                            child: Center(
                                //changed here from
                              child: MouseRegion(
                              cursor: SystemMouseCursors.click, // Changes cursor to pointer over entire area
                                child: Draggable<ItemModel>(  
                                  data: item,
                                  // Ensure the entire area is used when dragging by filling the parent's dimensions:
                                   childWhenDragging: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                   ),
                                   feedback: Material(
                                      color: Colors.transparent,
                                      child: Container(
                                         width: 150,
                                         height: 150,
                                         padding: EdgeInsets.all(8.0),
                                         decoration: BoxDecoration(
                                          color: Colors.white70,
                                          borderRadius: BorderRadius.circular(10.0),
                                          border: Border.all(color: Colors.white70, width: 2.0),
                                         ),
                                        child: Center(
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
                                    child: Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(color: Colors.white70, width: 2.0),
                                       ),
                                        child: Center(
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
                              //changed here from
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click, // Changes cursor to pointer when over drop target
                              child: DragTarget<ItemModel>(
                                onAccept: (receivedItem) {
                                  if (item.value == receivedItem.value) {
                                    setState(() {
                                      items.remove(receivedItem);
                                      items2.remove(item);
                                      score += 2; // Increase score by 2 if correct
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
                                  builder: (context, acceptedItems, rejectedItem) => Container(
                                    decoration: BoxDecoration(
                                      color: item.accepting ? Colors.red : Colors.white70,
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(color: Colors.white, width: 2.0),
                                    ),
                                    height: 150,
                                    width: 150,
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
                              ),
  
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                if (gameOver)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          startGame(chapter!);
                        },
                        child: const Text(
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
                          padding: const EdgeInsets.all(16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
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

  Widget buildDraggable(ItemModel item) {
    return Container(
      width: 150,
      height: 150,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.white70, width: 2.0),
      ),
      child: Center(
        child: Draggable<ItemModel>(
          data: item,
          childWhenDragging: Container(),
          feedback: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.white70, width: 2.0),
            ),
            child: Text(
              item.value,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.white70, width: 2.0),
            ),
            child: Text(
              item.value,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDragTarget(ItemModel item) {
    return Container(
      width: 150,
      height: 150,
      margin: const EdgeInsets.all(8.0),
      child: DragTarget<ItemModel>(
        onAccept: (receivedItem) {
          setState(() {
            if (item.value == receivedItem.value) {
              items.remove(receivedItem);
              items2.remove(item);
              score += 2; // correct
              item.accepting = false;
            } else {
              score -= 1; // wrong
              item.accepting = false;
            }
          });
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
        builder: (context, acceptedItems, rejectedItem) => Container(
          decoration: BoxDecoration(
            color: item.accepting ? Colors.red : Colors.white70,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.white, width: 2.0),
          ),
          height: 150,
          width: 150,
          alignment: Alignment.center,
          child: Text(
            item.name,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
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

  void initGame({required int chapter}) async {
    List<int> randomIndices = List.generate(20, (index) => index)..shuffle();
    final jsonData = await loadJsonData(chapter);

    setState(() {
      items = List.generate(5, (index) {
        int randIndex = randomIndices[index];
        return ItemModel(
          name: jsonData['spanish']![randIndex],
          value: jsonData['english']![randIndex],
        );
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
