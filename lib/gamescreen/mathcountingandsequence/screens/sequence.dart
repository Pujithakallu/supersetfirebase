import 'package:flutter/material.dart';
import '../widgets/sequence_option_button.dart';
import 'even_numbers.dart';
import 'one_to_ten_page.dart';
import 'multiples_of_five.dart';
import 'multiples_of_ten.dart';
import '../widgets/exit_button.dart';
import 'package:supersetfirebase/gamescreen/mathcountingandsequence/analytics_engine.dart';

class SequencingPage extends StatelessWidget {
  const SequencingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        title: const Text(
          'Sequencing',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 20.0), // Add padding to avoid overflow
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SequenceOptionButton(
                context: context,
                text: '1 to 100',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OneToTenPage()),
                  );
                  // TODO: Navigate to 1 to 10 Page
                },
              ),
              SequenceOptionButton(
                context: context,
                text: 'Even Numbers',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EvenNumbersPage()),
                  );

                  // TODO: Navigate to 10 to 1 Page
                },
              ),
              SequenceOptionButton(
                context: context,
                text: 'Multiples of Five',
                onPressed: () {
                  // TODO: Navigate to 1 to 100 Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MultiplesOfFive()),
                  );
                },
              ),
              SequenceOptionButton(
                context: context,
                text: 'Multiples of Ten',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MultiplesOfTen()),
                  );
                  // TODO: Navigate to 100 to 1 Page
                },
              ),
              // Placeholder for the caterpillar image. Replace 'assets/MathC&S/greenAnt.png' with your image path

              Padding(
                //padding: const EdgeInsets.all(90.0),
                padding: const EdgeInsets.fromLTRB(110.0, 20.0, 110.0, 20),
                child: Image.asset('assets/MathC&S/greenAnt.png', fit: BoxFit.contain),
              ),

              ExitButton(context: context)
            ],
          ),
        ),
      ),
    );
  }
}
