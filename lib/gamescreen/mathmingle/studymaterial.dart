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
       //logout button
        floatingActionButton: SizedBox(
              width: MediaQuery.of(context).size.height > 700 ? 56 : 40,
              height: MediaQuery.of(context).size.height > 700 ? 56 : 40,
              child: FloatingActionButton(
                heroTag: "logoutButton",
                onPressed: () => logout(context),
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.logout_rounded,
                  size: MediaQuery.of(context).size.height > 700 ? 28 : 20,
                  color: Colors.white,
                ),
              ),
            ),
             floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

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
              child: Builder(
                builder: (context) {
                  final screenWidth = MediaQuery.of(context).size.width;
                  final double buttonSize = screenWidth < 600 ? 30 : 50;
                  final double iconSize = screenWidth < 600 ? 18 : 28;

                  return SizedBox(
                    width: buttonSize,
                    height: buttonSize,
                    child: FloatingActionButton(
                      heroTag: "backButton",
                      onPressed: () => Navigator.pop(context),
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.lightBlue,
                      shape: const CircleBorder(),
                      mini: false, // We're handling size with SizedBox now
                      child: Icon(Icons.arrow_back_rounded, size: iconSize),
                    ),
                  );
                },
              ),
            ),


            // Column for PIN and VOCABULARY
            Positioned(
              top: 12,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // PIN Display (Smaller Width, Centered)
                  Builder(
                    builder: (context) {
                      final screenWidth = MediaQuery.of(context).size.width;

                      // Fixed size when wide; responsive when narrow
                      final double fontSize = screenWidth < 600 ? 12 : 14;
                      final double horizontalPadding = screenWidth < 600 ? 10 : 12;
                      final double verticalPadding = screenWidth < 600 ? 6 : 6;
                      final double borderRadius = screenWidth < 600 ? 10 : 12;
                      final double maxWidth = screenWidth < 600 ? 80 : 120;

                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),
                        constraints: BoxConstraints(
                          maxWidth: maxWidth,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(borderRadius),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'PIN: $userPin',
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      );
                    },
                  ),


                  const SizedBox(
                      height: 4), // Small gap between PIN and VOCABULARY
                  Text(
                      'V O C A B U L A R Y',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width > 700
                            ? 30 // Max font size for larger screens
                            : MediaQuery.of(context).size.width / 30, // Scales on smaller screens
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      
                      ),
                  ),
                ],
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
            padding: EdgeInsets.fromLTRB(16.0, MediaQuery.of(context).size.height > 300 ? 100.0 : 70.0, 16.0, 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'C H A P T E R  $chapter - ${getChapterTitle()}',
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width > 700 ? 40: MediaQuery.of(context).size.width / 20, fontWeight: FontWeight.bold),
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
                        borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width > 700 ? 20.0 : 15.0,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width > 700 ? 30 : 20,
                        vertical: MediaQuery.of(context).size.width > 700 ? 15 : 10,
                      ),
                    ),
                    onPressed: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                      setState(() => currentPage++);
                    },
                    child: Text(
                      'N E X T',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width > 700 ? 25 : 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold, // Added for better readability
                      ),
                    ),
                  ),
                if (currentPage > 0 &&
                    currentPage < (translations["spanish"]?.length ?? 1) - 1)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          // Scale border radius (20 on large screens, 15 on small)
                          MediaQuery.of(context).size.width > 600 ? 20.0 : 15.0,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width > 600 ? 30 : 20, // Less padding on small screens
                        vertical: MediaQuery.of(context).size.width > 600 ? 15 : 10,
                      ),
                    ),
                    onPressed: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                      setState(() => currentPage++);
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width > 600 ? 25 : 18, // Smaller text on small screens
                      ),
                    ),
                  ),
                if (currentPage == (translations["spanish"]?.length ?? 1) - 1)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width > 700 ? 20.0 : 15.0,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width > 700 ? 30 : 20,
                        vertical: MediaQuery.of(context).size.width > 700 ? 15 : 10,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'E X I T',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width > 700 ? 25 : 18,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
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
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  final isLargeScreen = screenWidth > 1000;

  return Center(
    child: Container(
      constraints: BoxConstraints(
        maxWidth: isLargeScreen ? screenWidth * 0.8 : screenWidth * 1.0,
        minHeight: isLargeScreen ? 100 : screenHeight * 0.2,
        maxHeight: isLargeScreen ? screenHeight * 0.9 : screenHeight * 0.5,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: isLargeScreen ? 10 : 5,
        vertical: isLargeScreen ? 20 : 10,
      ),
      padding: EdgeInsets.all(isLargeScreen ? 20 : 12),
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
      child: isLargeScreen 
          ? _buildLargeScreenContent(spanish, english, chapter)
          : _buildSmallScreenContent(spanish, english, chapter),
    ),
  );
}

Widget _buildLargeScreenContent(String spanish, String english, int chapter) {
  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  english,
                  style: TextStyle(
                    fontSize: 35,  // Max size it can scale up to
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.volume_up, size: 30, color: Colors.blue),
              onPressed: () => _playAudio(english, chapter),
            ),
          ],
        ),
        SizedBox(height: 10),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            spanish,
            style: TextStyle(
              fontSize: 30,  // Max size it can scale up to
              color: Colors.grey[600],
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSmallScreenContent(String spanish, String english, int chapter) {
  return LayoutBuilder(
    builder: (context, constraints) {
      // Calculate minimum height needed for text content
      final minCardHeight = 120.0; // Absolute minimum height
      final preferredHeight = constraints.maxHeight * 0.3; // 30% of available height
      final cardHeight = preferredHeight.clamp(minCardHeight, double.infinity);

      return SizedBox(
        height: cardHeight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        english,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.volume_up, size: 20, color: Colors.blue),
                    onPressed: () => _playAudio(english, chapter),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  spanish,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 20,
                  ),
                  maxLines: 2,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void _playAudio(String english, int chapter) {
  String fileName = english.toLowerCase().replaceAll("/", "_");
  _audioPlayer.play(AssetSource('Mathmingle/audio/$fileName.mp3'));
  AnalyticsEngine.logAudioButtonClick_MathMingle(english, chapter);
}
}
