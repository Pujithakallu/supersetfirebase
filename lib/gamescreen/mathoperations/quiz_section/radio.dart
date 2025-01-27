import 'package:flutter/material.dart';

class MCQPage extends StatefulWidget {
  const MCQPage({super.key});

  @override
  _MCQPageState createState() => _MCQPageState();
}

class _MCQPageState extends State<MCQPage> {
  int? selectedOption;

  // @override
  // void initState() {
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   super.dispose();
  // }

  void handleOptionChange(int? value) {
    setState(() {
      selectedOption = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radio!'),
      ),
      body: SingleChildScrollView(
        child:
    Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text('What is the capital of France?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              RadioListTile<int?>(
                title: const Text('New York'),
                value: 0,
                groupValue: selectedOption,
                onChanged: handleOptionChange,
              ),
              RadioListTile<int?>(
                title: const Text('Paris'),
                value: 1,
                groupValue: selectedOption,
                onChanged: handleOptionChange,
              ),
              RadioListTile<int?>(
                title: const Text('London'),
                value: 2,
                groupValue: selectedOption,
                onChanged: handleOptionChange,
              ),
              ElevatedButton(
                onPressed: () {
                  if (selectedOption != null) {
                    // Handle the selection
                    print('Selected option: $selectedOption');
                  } else {
                    // Prompt the user to select an option
                    print('Please select an option');
                  }
                },
                child: const Text('Submit'),
              ),
              SizedBox(height:20),
              Center(
                child: Image.asset('assets/Mathoperations/image1.png'),  // Path to your image file
              ),
            ],
          ),
        ),
     ),
    );
  }
}