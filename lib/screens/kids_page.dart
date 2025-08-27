// lib/screens/kids_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user_pin_provider.dart';
import '../utils/logout_util.dart';
import '../gamescreen/mathoperations/main.dart' show Operators;

class KidsPage extends StatelessWidget {
  const KidsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pin = Provider.of<UserPinProvider>(context, listen: false).pin;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,

      // Plain AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text('Kids', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),

      // Background + overlay
      body: Stack(
        children: [
          Positioned.fill(
            child:
                Image.asset('assets/images/background.png', fit: BoxFit.cover),
          ),
          Container(color: Colors.white.withOpacity(0.6)),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 16),

                // PIN badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'PIN: $pin',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Tile image
                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Operators(userPin: pin)),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/images/math_operators.png',
                          width: screenWidth * 0.6,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Title + icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.show_chart, size: 28, color: Colors.green),
                    SizedBox(width: 8),
                    Text(
                      'Operators',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Description
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    'Learn new symbols & more!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),

      // Logout FAB
      floatingActionButton: FloatingActionButton(
        heroTag: 'logoutKids',
        onPressed: () => logout(context),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.logout_rounded, color: Colors.white),
      ),
    );
  }
}
