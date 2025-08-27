// lib/screens/teens_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user_pin_provider.dart';
import '../utils/logout_util.dart';
import '../gamescreen/mathequations/main.dart' show MathEquationsApp;

class TeensPage extends StatelessWidget {
  const TeensPage({Key? key}) : super(key: key);

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
        title: const Text('Teens', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),

      // Full‐screen background + overlay
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
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

                // Central tile image
                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => MathEquationsApp()),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/images/math_equations.png',
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
                    Icon(Icons.functions, size: 28, color: Colors.purple),
                    SizedBox(width: 8),
                    Text(
                      'Equations',
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
                    'Master equations!',
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
        heroTag: 'logoutTeens',
        onPressed: () => logout(context),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.logout_rounded, color: Colors.white),
      ),
    );
  }
}
