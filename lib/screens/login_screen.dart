import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'signup_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  final List<TextEditingController> _controllers = List.generate(3, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(3, (_) => FocusNode());
  
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;
  late AnimationController _characterController;
  late Animation<double> _characterAnimation;
  late AnimationController _starController;
  late Animation<double> _starScale;
  
  String _errorMessage = '';
  bool _isLoading = false;
  bool _showStars = false;

  final List<Color> _pinBoxColors = [
    Color(0xFFFF9999),
    Color(0xFF99FF99),
    Color(0xFF9999FF),
  ];

  @override
  void initState() {
    super.initState();
    // Title bounce animation
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

    // Character idle animation
    _characterController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _characterAnimation = Tween<double>(
      begin: -15.0,
      end: 15.0,
    ).animate(CurvedAnimation(
      parent: _characterController,
      curve: Curves.easeInOut,
    ));

    // Star animation
    _starController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _starScale = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _starController,
      curve: Curves.elasticOut,
    ));

    // Add listeners to text controllers for star animation
    for (var controller in _controllers) {
      controller.addListener(() {
        if (controller.text.isNotEmpty && !_showStars) {
          setState(() => _showStars = true);
          _starController.forward(from: 0.0);
        }
      });
    }
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _characterController.dispose();
    _starController.dispose();
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

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => HomeScreen(pin: pin),
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

  Widget _buildAnimatedCharacter() {
    return AnimatedBuilder(
      animation: _characterAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_characterAnimation.value, 0),
          child: Container(
            width: 120,
            height: 120,
            child: Stack(
              children: [
                // You can replace this with an actual character image
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue[200],
                  ),
                  child: Center(
                    child: Text(
                      '🦸‍♂️',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                ),
                if (_showStars)
                  AnimatedBuilder(
                    animation: _starScale,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _starScale.value,
                        child: Container(
                          alignment: Alignment.topRight,
                          child: Text('✨', style: TextStyle(fontSize: 24)),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
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
                    _buildAnimatedCharacter(),
                    SizedBox(height: 20),
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
                          Stack(
                            children: [
                              Text(
                                'Enter your secret code!',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Color(0xFF4A4A4A),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (_showStars)
                                Positioned(
                                  right: -10,
                                  top: -10,
                                  child: AnimatedBuilder(
                                    animation: _starScale,
                                    builder: (context, child) {
                                      return Transform.scale(
                                        scale: _starScale.value,
                                        child: Text('✨', style: TextStyle(fontSize: 24)),
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 30),
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
                                  textInputAction: index < 2 
                                      ? TextInputAction.next 
                                      : TextInputAction.done,
                                  onSubmitted: (value) {
                                    if (index < 2) {
                                      _focusNodes[index + 1].requestFocus();
                                    } else {
                                      if (_controllers.every((controller) => 
                                          controller.text.isNotEmpty)) {
                                        _login();
                                      }
                                    }
                                  },
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
                          if (_errorMessage.isNotEmpty)
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('🤔 ', style: TextStyle(fontSize: 20)),
                                  Flexible(
                                    child: Text(
                                      _errorMessage,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          SizedBox(height: 30),
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
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => SignupScreen())
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Create New Secret Code',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF6C63FF),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                Text(' 🎯', style: TextStyle(fontSize: 16)),
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
        ),
      ),
    );
  }
}