import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'shapes_data.dart';
import 'theme_state.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


class GenericIntroductionPage extends StatefulWidget {
  final String shapeName;
  const GenericIntroductionPage({super.key, required this.shapeName});

  @override
  _GenericIntroductionPageState createState() => _GenericIntroductionPageState();
}

class _GenericIntroductionPageState extends State<GenericIntroductionPage> {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  bool _isEnglish = true;
  FlutterTts flutterTts = FlutterTts();
  bool _isSpeaking = false;
  int _voiceButtonClickCount = 0;
  String _pageContent = '';

  Map<String, dynamic> get shapeData =>
      shapes.firstWhere((element) => element['name'] == widget.shapeName);
  Map<String, dynamic> get introData => shapeData['intro'];

  Color _getShapeCardColor(bool isDark) {
    final Color shapeColor = shapeData['color'];
    final Color shapeDarkColor = shapeData['darkcolor'];
    return isDark ? shapeDarkColor : shapeColor;
  }

  @override
  void initState() {
    super.initState();
    _updatePageContent();
  }

  @override
  void dispose() {
    flutterTts.stop(); // Ensures narration stops on leaving the page
    super.dispose();
  }

  void _toggleLanguage() {
    setState(() {
      _isEnglish = !_isEnglish;
    });
    _updatePageContent();
  }

  void _updatePageContent() {
    setState(() {
      _pageContent = _getPageContent();
    });
  }

  String _getPageContent() {
    String content = _isEnglish
        ? introData['definition']['en']
        : introData['definition']['es'];
    content += _isEnglish
        ? ' Types of ${widget.shapeName}:'
        : ' Tipos de ${widget.shapeName}:';
    for (var type in introData['types']) {
      content += " " +
          (_isEnglish ? type['title']['en'] : type['title']['es']) +
          ". " +
          (_isEnglish ? type['description']['en'] : type['description']['es']);
    }
    return content;
  }

  Future<void> _speak(String text) async {
    if (_isSpeaking) {
      await flutterTts.stop();
      setState(() {
        _isSpeaking = false;
        _voiceButtonClickCount = 0;
      });
    } else {
      setState(() {
        _isSpeaking = true;
      });
      await flutterTts.setLanguage(_isEnglish ? 'en-US' : 'es-ES');
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(text);
    }
  }

  Widget _buildDefinition(bool isEnglish, bool isDark) {
    return Card(
      color: _getShapeCardColor(isDark).withOpacity(0.85),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          isEnglish
              ? introData['definition']['en']
              : introData['definition']['es'],
          style: const TextStyle(
            fontSize: 19.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildTypes(bool isEnglish, bool isDark, double horizontalPadding) {
    String headerText = isEnglish
        ? 'Types of ${widget.shapeName}:'
        : 'Tipos de ${widget.shapeName}:';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headerText,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: _getShapeCardColor(isDark),
            ),
          ),
          const SizedBox(height: 10.0),
          ...introData['types'].map<Widget>((type) {
            String title =
                isEnglish ? type['title']['en'] : type['title']['es'];
            String description = isEnglish
                ? type['description']['en']
                : type['description']['es'];
            String imagePath =
                isEnglish ? type['image']['en'] : type['image']['es'];
            return _buildTypeItem(title, description, imagePath, isDark);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTypeItem(
      String title, String description, String imagePath, bool isDark) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              final screenSize = MediaQuery.of(context).size;
              final double dialogWidth = screenSize.width * 0.70;
              final double dialogHeight = screenSize.height * 0.70;

              return Dialog(
                backgroundColor: const Color(0xDD2C2C2C),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Container(
                  width: dialogWidth,
                  height: dialogHeight,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Flexible(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.contain,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Text(
                          description,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text(
                            'Close',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Card(
          color: _getShapeCardColor(isDark).withOpacity(0.85),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
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

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeModel,
      builder: (context, _) {
        bool isDark = themeModel.isDarkMode;
        String mainImage = _isEnglish
            ? introData['mainImage']['en']
            : introData['mainImage']['es'];

        double screenWidth = MediaQuery.of(context).size.width;
        double horizontalPadding = screenWidth > 800
            ? screenWidth * 0.10
            : screenWidth * 0.05;

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(67.2),
            child: Container(
              color: _getShapeCardColor(themeModel.isDarkMode),
              child: SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          widget.shapeName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.translate, color: Colors.white),
                          onPressed:(){
                            analytics.logEvent(name: '${widget.shapeName} Learn Translate');
                            _toggleLanguage;
                          }
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.record_voice_over,
                            color: _isSpeaking ? Colors.blue : Colors.white,
                          ),
                          onPressed: () {
                            analytics.logEvent(name: '${widget.shapeName} Learn Sound');
                            setState(() {
                              _voiceButtonClickCount++;
                            });
                            if (_voiceButtonClickCount == 1) {
                              _speak(_pageContent);
                            } else if (_voiceButtonClickCount == 2) {
                              _speak('');
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            themeModel.isDarkMode
                                ? Icons.nightlight_round
                                : Icons.wb_sunny,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            analytics.logEvent(name: 'TC ${widget.shapeName} Learn');
                            themeModel.toggleTheme();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Container(
            color: isDark ? const Color(0xFF212121) : Colors.white,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (mainImage.isNotEmpty)
                    Image.asset(
                      mainImage,
                      height: 400.0,
                      width: 300.0,
                      fit: BoxFit.contain,
                    ),
                  const SizedBox(height: 20.0),
                  _buildDefinition(_isEnglish, isDark),
                  const SizedBox(height: 20.0),
                  _buildTypes(_isEnglish, isDark, 0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
