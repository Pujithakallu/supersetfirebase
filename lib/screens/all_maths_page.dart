import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/user_pin_provider.dart';
import '../utils/logout_util.dart';
import '../gamescreen/mathmingle/main.dart' show MathMingleApp;

class AllMathsPage extends StatelessWidget {
  const AllMathsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pin = Provider.of<UserPinProvider>(context, listen: false).pin;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text('All Maths', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/background.png', fit: BoxFit.cover),
          ),
          Container(color: Colors.white.withOpacity(0.6)),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0), // reduced padding
              child: Column(
                children: [
                  // PIN badge
                  _PinBadge(pin: pin),
                  const SizedBox(height: 10), // reduced height

                  // Games Grid
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8, // reduced spacing
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.85,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        _GameTile(
                          image: 'assets/images/math_mingle.png',
                          title: 'Math Mingle',
                          description: 'Fun with numbers!',
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => MathMingleApp(),
                                transitionsBuilder: (_, animation, __, child) =>
                                    FadeTransition(opacity: animation, child: child),
                              ),
                            );
                          },
                        ),
                        _GameTile(
                          image: 'assets/images/math_equations.png',
                          title: 'Math Equations',
                          description: 'Solve tricky puzzles!',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Math Equations coming soon!")),
                            );
                          },
                        ),
                        _GameTile(
                          image: 'assets/images/math_operators.png',
                          title: 'Math Operators',
                          description: 'Learn + - × ÷ easily!',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Math Operators coming soon!")),
                            );
                          },
                        ),
                        _GameTile(
                          image: 'assets/images/placeholder.png',
                          title: 'Coming Soon',
                          description: 'New game on the way!',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Stay tuned for new games!")),
                            );
                          },
                        ),
                      ],
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
        backgroundColor: Colors.blue,
        child: const Icon(Icons.logout_rounded, color: Colors.white),
      ),
    );
  }
}

class _PinBadge extends StatelessWidget {
  final String pin;
  const _PinBadge({required this.pin});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), // reduced padding
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        'PIN: $pin',
        style: const TextStyle(
          fontSize: 16, // slightly smaller
          fontWeight: FontWeight.bold,
          color: Colors.black87,
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
      elevation: 3, // reduced elevation
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(8), // reduced padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 70, // reduced size
                width: 70,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(image, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 8), // reduced spacing
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4), // reduced spacing
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
