import 'dart:math';
class NumberGenerator4 {
  static final Map<int, String> _numberWords = {
    10: 'Ten',
    20: 'Twenty',
    30: 'Thirty',
    40: 'Forty',
    50: 'Fifty',
    60: 'Sixty',
    70: 'Seventy',
    80: 'Eighty',
    90: 'Ninety',
    100: 'Hundred'
  };

  static int missingNumberIndex = 0;
  static int missingNumberValue = 0;

  static String _numberToWord(int number, {bool toSpanish = false}) {
    if (toSpanish) {
      return convertToSpanish(_numberWords[number]!);
    } else {
      return _numberWords[number]!;
    }
  }

  static List<String> generateSequence(int length) {
    List<String> sequence = [];
    Random random = Random();
    int maxNumber = 100;
    int maxMultiple = maxNumber ~/ 10;
    int firstNumber = (random.nextInt(maxMultiple - length + 2) + 1) * 10;

    for (int i = 0; i < length; i++) {
      int nextNumber = firstNumber + i * 10;
      if (nextNumber <= maxNumber) {
        sequence.add(_numberToWord(nextNumber));
      } else {
        break;
      }
    }

    if (sequence.length < length) {
      length = sequence.length;
    }

    missingNumberIndex = random.nextInt(length);
    missingNumberValue = firstNumber + missingNumberIndex * 10;

    sequence[missingNumberIndex] = '__';

    return sequence;
  }

  static String generateCorrectOption() {
    return _numberToWord(missingNumberValue);
  }

  static List<String> generateOptions() {
    List<String> options = [];
    Random random = Random();
    String correctOption = generateCorrectOption();

    Set<String> uniqueOptions = {}; // Use a set to ensure uniqueness

    // Ensure there are exactly 3 unique options in addition to the correct option
    while (uniqueOptions.length < 3) {
      int optionNum = (random.nextInt(10) + 1) * 10;
      String option = _numberToWord(optionNum);
      if (option != correctOption && !uniqueOptions.contains(option)) {
        uniqueOptions.add(option);
      }
    }

    options = uniqueOptions.toList();
    options.add(correctOption); // Add unique options to the list

    options.shuffle(); // Shuffle the list to randomize the order of the options
    return options;
  }

  static String convertToSpanish(String number) {
    Map<String, String> spanishNumbers = {
      'Ten': 'Diez',
      'Twenty': 'Veinte',
      'Thirty': 'Treinta',
      'Forty': 'Cuarenta',
      'Fifty': 'Cincuenta',
      'Sixty': 'Sesenta',
      'Seventy': 'Setenta',
      'Eighty': 'Ochenta',
      'Ninety': 'Noventa',
      'Hundred': 'Cien',
    };

    return spanishNumbers.containsKey(number)
        ? spanishNumbers[number]!
        : number;
  }
}