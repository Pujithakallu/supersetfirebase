import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'signup_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  
  final List<TextEditingController> _controllers = List.generate(3, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(3, (_) => FocusNode());
  
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;
  
 
  String _errorMessage = '';
  bool _isLoading = false;

 
  final List<Color> _pinBoxColors = [
    Color(0xFFFF9999),  
    Color(0xFF99FF99), 
    Color(0xFF9999FF),  
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the bouncing animation
    _bounceController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    
    _bounceAnimation = Tween<double>(
      begin: -10.0,
      end: 10.0,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    // Clean up resources when widget is disposed
    _bounceController.dispose();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  Future<void> _login() async {
    
    String pin = _controllers.map((c) => c.text).join();
    
   
    if (pin.length != 3) {
      setState(() {
        _errorMessage = 'Please enter all 3 numbers!';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Check if PIN exists in Firestore
      final pinDoc = await FirebaseFirestore.instance
          .collection('pins')
          .where('pin', isEqualTo: pin)
          .get();

      if (pinDoc.docs.isEmpty) {
        setState(() {
          _errorMessage = 'Oops! Wrong PIN. Try again!';
          _isLoading = false;
        });
        return;
      }

      // Navigate to HomeScreen if PIN is valid
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => HomeScreen(
              pin: pin,
            ),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Uh oh! Something went wrong. Let\'s try again!';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        // Gradient background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFECE1),  
              Color(0xFFE1F6FF), 
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Bouncing title animation
                    AnimatedBuilder(
                      animation: _bounceAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _bounceAnimation.value),
                          child: Text(
                            '🎮 Let\'s Play & Learn! 🎮',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4A4A4A),
                              shadows: [
                                Shadow(
                                  color: Colors.white,
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 30),
                    // Main login card
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Enter your secret code!',
                            style: TextStyle(
                              fontSize: 24,
                              color: Color(0xFF4A4A4A),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 30),
                          // PIN input fields
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(3, (index) {
                              return Container(
                                width: 70,
                                height: 70,
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                child: TextField(
                                  controller: _controllers[index],
                                  focusNode: _focusNodes[index],
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  obscureText: false,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: InputDecoration(
                                    counterText: '',
                                    filled: true,
                                    fillColor: _pinBoxColors[index].withOpacity(0.3),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: _pinBoxColors[index],
                                        width: 2,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: _pinBoxColors[index],
                                        width: 3,
                                      ),
                                    ),
                                  ),
                                  // Auto-focus handling
                                  onChanged: (value) {
                                    if (value.length == 1 && index < 2) {
                                      _focusNodes[index + 1].requestFocus();
                                    }
                                  },
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 20),
                          // Error message display
                          if (_errorMessage.isNotEmpty)
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                _errorMessage,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          SizedBox(height: 30),
                          // Login button
                          ElevatedButton(
                            onPressed: _isLoading ? null : _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF6C63FF),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 5,
                              shadowColor: Color(0xFF6C63FF).withOpacity(0.5),
                            ),
                            child: _isLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Let\'s Go!',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Icon(Icons.rocket_launch),
                                    ],
                                  ),
                          ),
                          SizedBox(height: 20),
                          // Sign up link
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => SignupScreen())
                              );
                            },
                            child: Text(
                              'Create New Secret Code',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF6C63FF),
                                decoration: TextDecoration.underline,
                              ),
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
        ),
      ),
    );
  }
}