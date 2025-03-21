import 'package:flutter/material.dart';
import 'dart:ui';
import 'util.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:supersetfirebase/utils/logout_util.dart';
import 'package:provider/provider.dart';
import 'package:supersetfirebase/provider/user_pin_provider.dart';
import 'package:supersetfirebase/gamescreen/mathmingle/analytics_engine.dart';

class StudyMaterialScreen extends StatefulWidget {
  @override
  const StudyMaterialScreen({Key? key}) : super(key: key);
  _StudyMaterialScreenState createState() => _StudyMaterialScreenState();
}

class _StudyMaterialScreenState extends State<StudyMaterialScreen> {
  late final PageController _pageController;
  int currentPage = 0;
  Map<String, List<String>> translations = {};
  bool isLoading = true;
  final AudioPlayer _audioPlayer = AudioPlayer(); // Audio player instance

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        viewportFraction: 0.3); // Smaller fraction for more cards
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Dispose the audio player
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int? chapter = ModalRoute.of(context)?.settings.arguments as int?;
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

    if (isLoading) {
      loadTranslations(chapter);
    }

    String getChapterTitle() {
      switch (chapter) {
        case 1:
          return 'N U M B E R S';
        case 2:
          return 'F O U N D A T I O N S';
        case 3:
          return 'S H A P E S';
        case 4:
          return 'S Y M B O L S';
        case 5:
          return 'G E O M E T R I C S';
        default:
          return 'Unknown Chapter';
      }
    }

    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(80), // Increased height for VOCABULARY text
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

            // Column for PIN and VOCABULARY
            Positioned(
              top: 12,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // PIN Display (Smaller Width, Centered)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    constraints: const BoxConstraints(
                      maxWidth: 120, // Prevents it from being too wide
                    ),
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
                        'PIN: $userPin',
                        style: const TextStyle(
                          fontSize: 14, // Slightly smaller font for better fit
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                      height: 4), // Small gap between PIN and VOCABULARY

                  // VOCABULARY Text (Adjusted to fit better)
                  const Text(
                    'V O C A B U L A R Y',
                    style: TextStyle(
                      fontSize: 30, // Reduced font size to fit properly
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
      body: Stack(
        children: [
          Image.asset(
            'assets/Mathmingle/study_material.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.pinkAccent.withOpacity(0.05),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 100.0, 16.0, 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text(
                  'C H A P T E R  $chapter - ${getChapterTitle()}',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: translations["spanish"]?.length ?? 0,
                      onPageChanged: (int page) {
                        setState(() {
                          currentPage = page;
                        });
                      },
                      itemBuilder: (context, index) {
                        return AnimatedBuilder(
                          animation: _pageController,
                          builder: (context, child) {
                            double value = 0.0;
                            if (_pageController.position.haveDimensions) {
                              value = _pageController.page! - index;
                              value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                            }
                            return Transform.scale(
                              scale: value,
                              child: Opacity(
                                opacity: value,
                                child: child,
                              ),
                            );
                          },
                          child: buildFlashcard(
                            translations["english"]?[index] ?? '',
                            translations["spanish"]?[index] ?? '',
                            chapter, // Pass chapter to the flashcard widget
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                if (currentPage == 0)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    onPressed: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                      setState(() {
                        currentPage++;
                      });
                    },
                    child: Text(
                      'N E X T',
                      style: TextStyle(fontSize: 25, color: Colors.blue),
                    ),
                  ),
                if (currentPage > 0 &&
                    currentPage < (translations["spanish"]?.length ?? 1) - 1)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    onPressed: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );

                      setState(() {
                        currentPage++;
                      });
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                if (currentPage == (translations["spanish"]?.length ?? 1) - 1)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'E X I T',
                      style: TextStyle(fontSize: 25, color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadTranslations(int chapter) async {
    Map<String, List<String>> data = await loadJsonData(chapter);
    setState(() {
      translations = data;
      isLoading = false;
    });
  }

  Widget buildFlashcard(String spanish, String english, int chapter) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align text to the start
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    english,
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.volume_up, size: 30, color: Colors.blue),
                  onPressed: () {
                    String fileName =
                        english.toLowerCase().replaceAll("/", "_");
                    _audioPlayer.play(
                      AssetSource('Mathmingle/audio/$fileName.mp3'),
                    );
                    AnalyticsEngine.logAudioButtonClick_MathMingle(
                        english, chapter); // Log the event
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              spanish,
              style: TextStyle(fontSize: 30, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
