import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/user_pin_provider.dart';
import '../utils/logout_util.dart';
import '../gamescreen/mathmingle/main.dart' show MathMingleApp;

class AllMathsPage extends StatefulWidget {
  const AllMathsPage({Key? key}) : super(key: key);

  @override
  State<AllMathsPage> createState() => _AllMathsPageState();
}

class _AllMathsPageState extends State<AllMathsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pin = Provider.of<UserPinProvider>(context, listen: false).pin;
    final screenHeight = MediaQuery.of(context).size.height;

    final games = [
      {
        'image': 'assets/images/math_mingle.png',
        'title': 'Math Mingle',
        'desc': 'Fun with numbers!',
        'widget': MathMingleApp(),
      },
      // {
      //   'image': '', //'assets/images/math_equations.png',
      //   'title': 'Math Equations',
      //   'desc': 'Solve tricky puzzles!',
      //   'widget': null,
      // },
      // {
      //   'image': '', //'assets/images/math_operators.png',
      //   'title': 'Math Operators',
      //   'desc': 'Learn + - × ÷ easily!',
      //   'widget': null,
      // },
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'All Maths',
          style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child:
                Image.asset('assets/images/background.png', fit: BoxFit.cover),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white
                          .withOpacity(0.35 + 0.15 * sin(_controller.value * 2 * pi)),
                      Colors.white.withOpacity(0.6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              );
            },
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _PinBadge(pin: pin), // ✅ PIN badge with orange gradient
                  SizedBox(height: screenHeight * 0.03),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        int crossAxisCount =
                            (constraints.maxWidth ~/ 150).clamp(2, 3);
                        double spacing = 10;
                        double itemWidth =
                            (constraints.maxWidth - (crossAxisCount - 1) * spacing) /
                                crossAxisCount;
                        double itemHeight = itemWidth * 1.2;

                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: spacing,
                            mainAxisSpacing: spacing,
                            childAspectRatio: itemWidth / itemHeight,
                          ),
                          itemCount: games.length,
                          itemBuilder: (context, index) {
                            final game = games[index];
                            return _GameTile(
                              image: game['image'] as String,
                              title: game['title'] as String,
                              description: game['desc'] as String,
                              onTap: () {
                                if (game['widget'] != null) {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      pageBuilder: (_, __, ___) =>
                                          game['widget'] as Widget,
                                      transitionsBuilder: (_, animation, __, child) =>
                                          FadeTransition(opacity: animation, child: child),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("${game['title']} coming soon!"),
                                    ),
                                  );
                                }
                              },
                            );
                          },
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
      floatingActionButton: FloatingActionButton(
        heroTag: 'logoutAllMaths',
        onPressed: () async {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Logout'),
              content: const Text('Are you sure you want to log out?'),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.pop(context, false),
                ),
                ElevatedButton(
                  child: const Text('Logout'),
                  onPressed: () => Navigator.pop(context, true),
                ),
              ],
            ),
          );
          if (confirm == true) logout(context);
        },
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.logout_rounded, color: Colors.white),
      ),
    );
  }
}

// ✅ PIN badge with orange gradient
class _PinBadge extends StatelessWidget {
  final String pin;
  const _PinBadge({required this.pin});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.orange, Colors.deepOrangeAccent],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Text(
        'PIN: $pin',
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _GameTile extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _GameTile({
    required this.image,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: image.isNotEmpty
                    ? Image.asset(
                        image,
                        fit: BoxFit.contain,
                        width: double.infinity,
                      )
                    : Container(),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 3),
            Text(
              description,
              style: const TextStyle(fontSize: 11, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
