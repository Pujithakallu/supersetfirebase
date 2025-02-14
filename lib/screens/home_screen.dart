import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_screen.dart';
import '../gamescreen/mathmingle/main.dart';
import '../gamescreen/mathequations/main.dart';
import '../gamescreen/mathoperations/main.dart';

class HomeScreen extends StatefulWidget {
  final String pin;
  
  const HomeScreen({
    required this.pin,
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late AnimationController _floatController;
  
  final List<Map<String, dynamic>> games = [
    {
      'title': '1. Math Mingle',
      'icon': Icons.calculate_outlined,
      'color': const Color(0xFFFF6B6B),
      'gradient': const [Color(0xFFFF6B6B), Color(0xFFFF9999)],
      'description': 'Fun with numbers!'
    },
    {
      'title': '2. Math Equations',
      'icon': Icons.functions_outlined,
      'color': const Color(0xFF4ECB71),
      'gradient': const [Color(0xFF4ECB71), Color(0xFF99FF99)],
      'description': 'Master equations!'
    },
    {
      'title': '3. Math Operators',
      'icon': Icons.calculate_rounded,
      'color': const Color(0xFF6C63FF),
      'gradient': const [Color(0xFF6C63FF), Color(0xFF9999FF)],
      'description': 'Learn new Symbols n more!'
    },
    {
      'title': '4. Studio',
      'icon': Icons.palette_outlined,
      'color': const Color(0xFFFFB347),
      'gradient': const [Color(0xFFFFB347), Color(0xFFFFD699)],
      'description': 'Draw and create!'
    },
  ];

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _floatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  // Handle game card tap
  void _handleGameTap(BuildContext context, int index) {
    HapticFeedback.lightImpact();
    
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MathMingleApp()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyApp(userPin: widget.pin)),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Operators(userPin: widget.pin)),
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '🎮 ${games[index]['title']} is coming soon!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: games[index]['color'],
            duration: const Duration(seconds: 2),
          ),
        );
    }
  }

  // Build a game card
  Widget _buildGameCard(int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + (0.05 * animation.value),
          child: child,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: games[index]['gradient'],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: games[index]['color'].withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              games[index]['icon'],
              size: 60,
              color: Colors.white,
            ),
            const SizedBox(height: 12),
            Text(
              games[index]['title'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 2.0,
                    color: Color(0x40000000),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                games[index]['description'],
                style: TextStyle(
                  fontSize: 14,
                  color: games[index]['color'],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    int crossAxisCount = screenSize.width < 600 ? 2 : 
                        screenSize.width < 900 ? 3 : 4;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4A4A4A)),
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => LoginScreen())
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout_rounded,
              color: Color(0xFF6C63FF),
              size: 26,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => LoginScreen())
              );
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFE1F6FF),
                  Color(0xFFFFECE1),
                  Color(0xFFE8E1FF),
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),
          
          // Floating Clouds
          ...List.generate(5, (index) {
            double startInterval = (index * 0.2).clamp(0.0, 0.8);
            double endInterval = startInterval + 0.2;
            
            return Positioned(
              left: (index * 80.0) % screenSize.width,
              top: (index * 60.0) % (screenSize.height * 0.5),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0),
                  end: const Offset(0, 0.1),
                ).animate(CurvedAnimation(
                  parent: _floatController,
                  curve: Interval(
                    startInterval,
                    endInterval,
                    curve: Curves.easeInOut,
                  ),
                )),
                child: Opacity(
                  opacity: 0.4,
                  child: Icon(
                    Icons.cloud,
                    size: 60 + (index * 10),
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }),
          
          // Main Content
          SafeArea(
            child: CustomScrollView(
              slivers: [
                // Welcome Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Bouncing School Icon
                          ScaleTransition(
                            scale: Tween<double>(
                              begin: 1.0,
                              end: 1.1,
                            ).animate(CurvedAnimation(
                              parent: _bounceController,
                              curve: Curves.elasticInOut,
                            )),
                            child: const Icon(
                              Icons.school_rounded,
                              size: 80,
                              color: Color(0xFF6C63FF),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Hi, ${widget.pin}!',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4A4A4A),
                              shadows: [
                                Shadow(
                                  offset: Offset(1, 1),
                                  blurRadius: 2.0,
                                  color: Color(0x80000000),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Text(
                            'Welcome to the Fun Zone!',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6C63FF),
                              letterSpacing: 0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFD700).withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '🎮 Choose your adventure! ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF4A4A4A),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '🚀',
                                  style: TextStyle(
                                    fontSize: 24,
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
                
                // Games Grid
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.85,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return InkWell(
                          onTap: () => _handleGameTap(context, index),
                          child: _buildGameCard(index, _bounceController),
                        );
                      },
                      childCount: games.length,
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
}