import 'package:flutter/material.dart';
import '../widgets/non_clickable_number1.dart';
import '../widgets/numberoption1.dart';

class SequenceDemo extends StatelessWidget {
  const SequenceDemo({super.key});

  @override
  Widget build(BuildContext context) {
  // Define the correct option
  const String correctOption = 'Four';

  return Scaffold(
  backgroundColor: Colors.purple[100],
  appBar: AppBar(
  title: const Text('LEVEL 1'),
  centerTitle: true,
  backgroundColor: Colors.purple,
  ),
  body: Center(
  child: Column(
  mainAxisSize: MainAxisSize.min,
  children: [
  const SizedBox(height: 20),
  // Sequence numbers
  const Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
  NonClickableNumber1(text: 'Two'),
  NonClickableNumber1(text: 'Three'),
  NonClickableNumber1(text: '__'),
  NonClickableNumber1(text: 'Five'),
  ],
  ),
  const SizedBox(height: 32),
  // Options heading
  const Text(
  'Choose an Option',
  style: TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.white,
  ),
  ),
  const SizedBox(height: 20),
  // Option buttons with increased spacing
  NumberOptionButton1(
  text: 'One',
  backgroundColor: Colors.purple,
  onPressed: () => navigate(context, false),
  ),
  const SizedBox(height: 10), // Increased spacing between buttons
  NumberOptionButton1(
  text: 'Seven',
  backgroundColor: Colors.purple,
  onPressed: () => navigate(context, false),
  ),
  const SizedBox(height: 10), // Increased spacing between buttons
  NumberOptionButton1(
  text: 'Six',
  backgroundColor: Colors.purple,
  onPressed: () => navigate(context, false),
  ),
  const SizedBox(height: 10), // Increased spacing between buttons
  NumberOptionButton1(
  text: 'Four',
  backgroundColor:
  correctOption == 'Four' ? Colors.green : Colors.purple,
  onPressed: () => navigate(context, true),
  ),
  ],
  ),
  ),
  );
  }

  void navigate(BuildContext context, bool isCorrect) {
  showDialog(
  context: context,
  builder: (BuildContext context) {
  return AlertDialog(
  title: Text(isCorrect ? 'Correct!' : 'Wrong'),
  content: Text(isCorrect
  ? 'You have chosen the right answer!'
      : 'That was not the right answer. Try again!'),
  actions: [
  TextButton(
  child: const Text('OK'),
  onPressed: () {
  Navigator.of(context)
      .pop(); // Dismiss the dialog but stay on the current page
  },
  ),
  ],
  );
  },
  );
  }
  }
