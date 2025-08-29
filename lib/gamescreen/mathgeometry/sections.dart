import 'package:flutter/material.dart';
import 'main.dart';
import 'genericIntroductionPage.dart';
import 'genericPracticePage.dart';
import 'genericQuizPage.dart';
import 'theme_state.dart';
import 'shapes_data.dart'; // To lookup shape data for colors.
import 'package:firebase_analytics/firebase_analytics.dart';

class SectionsPage extends StatefulWidget {
  final String title; // e.g. "Angles", "Planes", etc.
  final List<Map<String, dynamic>> sectionItems;

  const SectionsPage({
    super.key,
    required this.title,
    required this.sectionItems,
  });

  @override
  State<SectionsPage> createState() => _SectionsPageState();
}

class _SectionsPageState extends State<SectionsPage> {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = themeModel.isDarkMode;
    return AnimatedBuilder(
      animation: themeModel,
      builder: (context, _) {
        bool isDark = themeModel.isDarkMode;
        final double screenHeight = MediaQuery.of(context).size.height;
        final double screenWidth = MediaQuery.of(context).size.width;
        final double horizontalPadding = screenWidth * 0.10;

        // Lookup shape data by matching widget.title to shape['name'].
        final shapeData = shapes.firstWhere(
          (element) => element['name'] == widget.title,
          orElse: () => <String, dynamic>{},
        );

        // Set default wave colors if shapeData is empty.
        Color biggerWaveColor = const Color(0xFFB3E5FC);
        Color smallerWaveColor = const Color(0xFF4A90E2);

        if (shapeData.isNotEmpty &&
            shapeData.containsKey('color') &&
            shapeData.containsKey('darkcolor')) {
          final Color shapeColor = shapeData['color'];
          final Color shapeDarkColor = shapeData['darkcolor'];

          if (isDark) {
            biggerWaveColor = shapeDarkColor;
            smallerWaveColor = shapeColor;
          } else {
            biggerWaveColor = shapeColor;
            smallerWaveColor = shapeDarkColor;
          }
        }

        return Scaffold(
          body: Stack(
            clipBehavior: Clip.none,
            children: [
              // Animated background image.
              Positioned.fill(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  switchInCurve: Curves.easeInOut,
                  switchOutCurve: Curves.easeInOut,
                  child: Container(
                    key: ValueKey(isDark),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          isDark
                              ? 'assets/Mathgeometry/backgroundd-dark.gif'
                              : 'assets/Mathgeometry/backgroundd.gif',
                        ),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
              ),
              // Scrollable content below the wave header.
              Positioned.fill(
                top: 160,
                child: SingleChildScrollView(
                  clipBehavior: Clip.none,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: screenHeight * 0.10,
                      bottom: 24.0,
                      left: horizontalPadding,
                      right: horizontalPadding,
                    ),
                    child: Column(
                      children: List.generate(widget.sectionItems.length, (index) {
                        final item = widget.sectionItems[index];
                        // Use 'darkcolor' if dark mode is on; else use 'color'.
                        final Color tileColor = (isDark && item.containsKey('darkcolor'))
                            ? item['darkcolor'] as Color
                            : item['color'] as Color;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 35.0),
                          child: _buildSectionTile(
                            context,
                            item['title'] as String,
                            item['icon'] as IconData,
                            tileColor,
                            item['page'] as String, // 'learn', 'practice', or 'quiz'
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
              // Top Wave Header with title, back, and toggle.
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 160,
                child: SafeArea(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Custom wave painter using our selected wave colors.
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _WaveBackgroundPainter(
                            biggerWaveColor: biggerWaveColor,
                            smallerWaveColor: smallerWaveColor,
                          ),
                        ),
                      ),
                      // Center Title.
                      Center(
                        child: Text(
                          widget.title.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                  offset: Offset(1, 1),
                                  blurRadius: 2,
                                  color: Colors.black26)
                            ],
                          ),
                        ),
                      ),
                      // Toggle Button with pointer cursor.
                      Positioned(
                        right: 24,
                        top: 56,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {analytics.logEvent(
                                name: 'TC ${widget.title} Section',
                                parameters: {
                                  'new_mode': isDarkMode ? 'light' : 'dark',
                                },
                              );
                              themeModel.toggleTheme();
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 60,
                              height: 32,
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? Colors.indigo.withOpacity(0.8)
                                    : Colors.yellow.shade600.withOpacity(0.85),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  AnimatedAlign(
                                    duration: const Duration(milliseconds: 300),
                                    alignment:
                                        isDark ? Alignment.centerRight : Alignment.centerLeft,
                                    child: Icon(
                                      isDark ? Icons.nightlight_round : Icons.wb_sunny,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Back Button.
                      Positioned(
                        left: 12,
                        top: 56,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 34,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BilingualMathGeoHomePage(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionTile(
    BuildContext context,
    String sectionTitle,
    IconData icon,
    Color color,
    String pageType,
  ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Widget destination;
          switch (pageType.toLowerCase()) {
            case 'learn':
              analytics.logEvent(
                name: '${widget.title} Learn',
              );
              destination = GenericIntroductionPage(shapeName: widget.title);
              break;
            case 'practice':
              analytics.logEvent(
                name: '${widget.title} Practice',
              );
              destination = GenericPracticePage(shapeName: widget.title);
              break;
            case 'quiz':
              analytics.logEvent(
                name: '${widget.title} Quiz',
              );
              destination = GenericQuizPage(shapeName: widget.title);
              break;
            default:
              destination = Container();
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        child: Material(
          elevation: 4,
          clipBehavior: Clip.none,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 10,
                  right: 10,
                  child: Icon(
                    icon,
                    color: Colors.white.withOpacity(0.15),
                    size: 48,
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, size: 40, color: Colors.white),
                      const SizedBox(width: 16),
                      Text(
                        sectionTitle,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 2,
                              color: Colors.black26,
                            )
                          ],
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

class _WaveBackgroundPainter extends CustomPainter {
  final Color biggerWaveColor;   // The behind wave
  final Color smallerWaveColor;  // The top wave

  _WaveBackgroundPainter({
    required this.biggerWaveColor,
    required this.smallerWaveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the secondary (bigger) wave.
    final secondaryPaint = Paint()..color = biggerWaveColor;
    final secondaryPath = Path()
      ..moveTo(0, 0)
      ..lineTo(0, 160)
      ..quadraticBezierTo(size.width * 0.25, 200, size.width * 0.5, 160)
      ..quadraticBezierTo(size.width * 0.85, 140, size.width, 200)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(secondaryPath, secondaryPaint);

    // Draw the primary (smaller) wave on top.
    final primaryPaint = Paint()..color = smallerWaveColor;
    final primaryPath = Path()
      ..moveTo(0, 0)
      ..lineTo(0, 140)
      ..quadraticBezierTo(size.width * 0.25, 180, size.width * 0.5, 140)
      ..quadraticBezierTo(size.width * 0.85, 100, size.width, 160)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(primaryPath, primaryPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
