
import 'package:flutter/material.dart';
import 'package:supersetfirebase/screens/home_screen.dart' as main_home;

class CustomGameAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userPin;
  final String title;
  final VoidCallback? onLogout;
  final bool showHomeButton;
  
  CustomGameAppBar({
    Key? key,
    required this.userPin,
    this.title = '',
    this.onLogout,
    this.showHomeButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;

    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: showHomeButton ? IconButton(
          icon: Icon(Icons.home, 
            color: Colors.black, 
            size: isSmallScreen ? 24 : 30
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => main_home.HomeScreen(pin: userPin),
              ),
            );
          },
        ) : null,
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.black,
              size: isSmallScreen ? 24 : 30,
            ),
            onPressed: () {
              if (onLogout != null) {
                onLogout!();
              } else {
                _showLogoutDialog(context);
              }
            },
          ),
          SizedBox(width: screenSize.width * 0.02),
        ],
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.03,
            vertical: screenSize.height * 0.01
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.person, 
                color: Colors.black, 
                size: isSmallScreen ? 16 : 20
              ),
              SizedBox(width: screenSize.width * 0.01),
              Text(
                'PIN: $userPin',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: isSmallScreen ? 14 : 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}