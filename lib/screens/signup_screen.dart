
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController loginController = TextEditingController();

  Future<void> signup(BuildContext context) async {
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
        SnackBar(content: Text("Sign-up failed: User already exists")),
      );
    } else {
      try {
        await database.child("users/$loginId").set({"loginId": loginId});
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Account created successfully!")),
        );
        Navigator.pushReplacementNamed(context, '/login');
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Sign-up failed: $error")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign-Up')),
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
              onPressed: () => signup(context),
              child: Text('Sign Up'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text("Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}
