// lib/screens/category_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/category.dart';
import '../provider/user_pin_provider.dart';
import '../utils/logout_util.dart';

// Import your three sub‐pages:
import 'all_maths_page.dart';
import 'kids_page.dart';
import 'teens_page.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  // helper to pick the right subtitle
  String _subtitleFor(String title) {
    switch (title) {
      case 'All Maths':
        return '(For all ages)';
      case 'Kids':
        return '(Ages: 5 to 12)';
      case 'Teens':
        return '(Age: 13+)';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final pin = Provider.of<UserPinProvider>(context, listen: false).pin;

    final categories = const <Category>[
      Category(
        title: 'All Maths',
        assetPath: 'assets/images/all_maths_tile.png',
        page: AllMathsPage(),
      ),
      Category(
        title: 'Kids',
        assetPath: 'assets/images/kids_tile.png',
        page: KidsPage(),
      ),
      Category(
        title: 'Teens',
        assetPath: 'assets/images/teens_tile.png',
        page: TeensPage(),
      ),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,

      // Plain AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        //leading: const BackButton(color: Color.fromARGB(255, 246, 2, 2)),
        title: const Text(
          "Welcome to Math World",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),

      // Background + optional overlay
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(color: Colors.white.withOpacity(0.6)),

          // Grid content
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

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 3 / 4,
                      children: categories.map((cat) {
                        final subtitle = _subtitleFor(cat.title);
                        return InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => cat.page),
                          ),
                          borderRadius: BorderRadius.circular(12),
                          child: Column(
                            children: [
                              // square thumbnail
                              AspectRatio(
                                aspectRatio: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    cat.assetPath,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 8),

                              // Title
                              Text(
                                cat.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),

                              const SizedBox(height: 4),

                              // Subtitle in parentheses
                              Text(
                                subtitle,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        heroTag: 'logoutCategory',
        onPressed: () => logout(context),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.logout_rounded, color: Colors.white),
      ),
    );
  }
}
