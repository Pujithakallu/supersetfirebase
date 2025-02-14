import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart'; 
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
  late final AnimationController _bounceController;
  
  late List<Map<String, dynamic>> games;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    games = [
      {
        'title': '1. Math Mingle',
        'icon': Icons.calculate_outlined,
        'color': const Color(0xFFFF6B6B),
        'gradient': const [Color(0xFFFF6B6B), Color(0xFFFF9999)],
        'description': 'Fun with numbers!',
        'progress': 0.0,
        'key': 'math_mingle_progress',
      },
      {
        'title': '2. Math Equations',
        'icon': Icons.functions_outlined,
        'color': const Color(0xFF4ECB71),
        'gradient': const [Color(0xFF4ECB71), Color(0xFF99FF99)],
        'description': 'Master equations!',
        'progress': 0.0,
        'key': 'math_equations_progress',
      },
      {
        'title': '3. Math Operators',
        'icon': Icons.calculate_rounded,
        'color': const Color(0xFF6C63FF),
        'gradient': const [Color(0xFF6C63FF), Color(0xFF9999FF)],
        'description': 'Learn new Symbols n more!',
        'progress': 0.0,
        'key': 'math_operators_progress',
      },
      {
        'title': '4. Studio',
        'icon': Icons.palette_outlined,
        'color': const Color(0xFFFFB347),
        'gradient': const [Color(0xFFFFB347), Color(0xFFFFD699)],
        'description': 'Draw and create!',
        'progress': 0.0,
        'key': 'studio_progress',
      },
    ];
    
    _loadProgress();
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      for (var game in games) {
        final progress = prefs.getDouble('${widget.pin}_${game['key']}') ?? 0.0;
        game['progress'] = progress;
      }
    });
  }

  Future<void> _updateProgress(int gameIndex, double progress) async {
    final prefs = await SharedPreferences.getInstance();
    final game = games[gameIndex];
    await prefs.setDouble('${widget.pin}_${game['key']}', progress);
    setState(() {
      game['progress'] = progress;
    });
  }

  Future<void> _handleGameCompletion(int gameIndex) async {
    await _updateProgress(gameIndex, 1.0);
  }

  void _handleGameTap(BuildContext context, int index) async {
    HapticFeedback.lightImpact();
    
    switch (index) {
      case 0:
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  MathMingleApp()),
        );
        if (result == true) {
          await _handleGameCompletion(index);
        }
        break;
      case 1:
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyApp(userPin: widget.pin)),
        );
        if (result == true) {
          await _handleGameCompletion(index);
        }
        break;
      case 2:
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Operators(userPin: widget.pin)),
        );
        if (result == true) {
          await _handleGameCompletion(index);
        }
        break;
      default:
        if (mounted) {
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
              backgroundColor: games[index]['color'] as Color,
              duration: const Duration(seconds: 2),
            ),
          );
        }
    }
  }

  Widget _buildGameCard(int index, Animation<double> animation) {
    final game = games[index];
    final Color color = game['color'] as Color;
    final List<Color> gradientColors = game['gradient'] as List<Color>;
    
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
            colors: gradientColors,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              game['icon'] as IconData,
              size: 60,
              color: Colors.white,
            ),
            const SizedBox(height: 12),
            Text(
              game['title'] as String,
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
                game['description'] as String,
                style: TextStyle(
                  fontSize: 14,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Progress: ${((game['progress'] as double) * 100).toInt()}%',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: game['progress'] as double,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      minHeight: 8,
                    ),
                  ),
                ],
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
    final int crossAxisCount = screenSize.width < 600 ? 2 : 
                             screenSize.width < 900 ? 3 : 4;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4A4A4A)),
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) =>  LoginScreen()),
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
                MaterialPageRoute(builder: (_) =>  LoginScreen()),
              );
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
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
          
          ...List.generate(5, (index) {
            return Positioned(
              left: (index * 80.0) % screenSize.width,
              top: (index * 60.0) % (screenSize.height * 0.5),
              child: Opacity(
                opacity: 0.4,
                child: Icon(
                  Icons.cloud,
                  size: 60 + (index * 10),
                  color: Colors.white,
                ),
              ),
            );
          }),
          
          SafeArea(
            child: CustomScrollView(
              slivers: [
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