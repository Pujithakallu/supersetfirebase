import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../gamescreen/mathmingle/main.dart';
import '../gamescreen/mathequations/main.dart';
import '../gamescreen/mathoperations/main.dart';

class HomeScreen extends StatelessWidget {
  final String pin;
  
  HomeScreen({
    required this.pin,
    Key? key,
  }) : super(key: key);

  final List<Map<String, dynamic>> games = [
    {
      'title': '1. Math Mingle',
      'icon': Icons.calculate,
      'color': Color(0xFFFF9999),
      'description': 'Fun with numbers!'
    },
    {
      'title': '2. Math Equations',
      'icon': Icons.functions,
      'color': Color(0xFF99FF99),
      'description': 'Master equations!'
    },
    {
      'title': '3. Math Operators',
      'icon': Icons.abc,
      'color': Color(0xFF9999FF),
      'description': 'Learn new words!'
    },
    {
      'title': '4. Art Studio',
      'icon': Icons.palette,
      'color': Color(0xFFFFB366),
      'description': 'Draw and create!'
    },
  ];

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
          icon: Icon(Icons.arrow_back, color: Color(0xFF4A4A4A)),
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => LoginScreen())
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE1F6FF),
              Color(0xFFFFECE1),
            ],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(
                        Icons.stars_rounded,
                        size: 40,
                        color: Color(0xFF6C63FF),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Hi, $pin!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4A4A4A),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Welcome to the Fun Zone!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4A4A4A),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Choose your adventure!',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF6C63FF),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(16),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.1,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return InkWell(
                        onTap: () {
                          if (index == 0) { // Math Mingle
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WelcomeScreen(userPin: pin),
                              ),
                            );
                          } else if (index == 1) { // Math Equations
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyApp(userPin: pin),
                              ),
                            );
                          }else if (index == 2) { // Math Operators
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Operators( ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '🎮 ${games[index]['title']} is coming soon!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 14),
                                ),
                                backgroundColor: games[index]['color'],
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: games[index]['color'].withOpacity(0.5),
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: games[index]['color'].withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  games[index]['icon'],
                                  size: 32,
                                  color: games[index]['color'],
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                games[index]['title'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4A4A4A),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                games[index]['description'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: games.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
