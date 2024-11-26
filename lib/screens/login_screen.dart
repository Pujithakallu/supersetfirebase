
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController loginController = TextEditingController();

  Future<void> login(BuildContext context) async {
    String loginId = loginController.text.trim();

    if (loginId.length != 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login must be a 3-digit number")),
      );
      return;
    }

    final database = FirebaseDatabase.instance.ref();
    final snapshot = await database.child("users/$loginId").get();

    if (snapshot.exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login successful!")),
      );
      Navigator.pushReplacementNamed(context, '/home', arguments: loginId);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed: User not found")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: loginController,
              decoration: InputDecoration(
                labelText: 'Enter your 3-digit Login ID',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => login(context),
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
