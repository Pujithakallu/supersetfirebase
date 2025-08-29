import 'package:flutter/material.dart';
import '../screens/fivepage.dart';
import '../screens/twopage.dart';

class CountMatchDemo extends StatefulWidget {
  const CountMatchDemo({super.key});
  @override
  State<CountMatchDemo> createState() =>  _CountMatchDemoState();
}
class _CountMatchDemoState extends State<CountMatchDemo> {

  bool showSpanish = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Count Match Game'),
      ),
      body: Container(
        color: Colors.purple[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              alignment: Alignment.center,
              height: 48,
              margin: const EdgeInsets.symmetric(horizontal: 50.0),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: Text(
                showSpanish
                    ? 'Veamos cuántas uvas tenemos'
                    : 'Let\'s see how many grapes we have',
                style: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 48),
            Center(
              child: Container(
                width: 330,
                height: 186,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple, width: 4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Image.asset(
                      'assets/MathC&S/grapes.png'), // Ensure the image asset is correctly located in your project
                ),
              ),
            ),
            const SizedBox(height: 48),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Tooltip(
                message: 'Click me, the count is five!', // Tooltip text
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FivePage()), // Ensure FivePage is correctly defined elsewhere
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                  ),
                  child: Text(
                    showSpanish ? 'CINCO' : 'FIVE',
                    style: const TextStyle(fontSize: 30.0, color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            twoPage()), // Ensure TwoPage is defined as well
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                child: Text(
                  showSpanish ? 'DOS' : 'TWO',
                  style: const TextStyle(fontSize: 30.0, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    showSpanish = !showSpanish;
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(showSpanish ? 'English' : 'Español',
                    style: const TextStyle(fontSize: 23)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
