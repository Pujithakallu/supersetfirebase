import 'package:flutter/material.dart';
import '../analytics_engine.dart';

class MultipageContainer extends StatefulWidget {
  final List<Widget Function(bool isEnglish)> pages;
  final bool initialLanguageEnglish;
  final String lessonType;

  MultipageContainer({
    Key? key,
    required this.pages,
    this.initialLanguageEnglish = true,
    required this.lessonType,
  }) : super(key: key);

  @override
  _MultipageContainerState createState() => _MultipageContainerState();
}

class _MultipageContainerState extends State<MultipageContainer> {
  bool _isEnglish = true;

  @override
  void initState() {
    super.initState();
    _isEnglish = widget.initialLanguageEnglish;
  }

  void _onTranslatePressed() {
    setState(() {
      _isEnglish = !_isEnglish;
    });
    
    // Log translate button click
    String language = AnalyticsEngine.getLanguageString(_isEnglish);
    AnalyticsEngine.logTranslateButtonClickLessons(language, widget.lessonType);
    print('Translate button is logged');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEnglish ? 'Lessons' : 'lecciones'),
      ),
      body: PageView(
        children: widget.pages.map((pageBuilder) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/MathNumQuest/word_problem.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: _onTranslatePressed,
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        _isEnglish ? 'Translate' : 'Traducir',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: pageBuilder(_isEnglish),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
