import 'dart:math';
class NumberGenerator3 {
  static final Map<int, String> _numberWords = {
    0: 'Zero',
    5: 'Five',
    10: 'Ten',
    15: 'Fifteen',
    20: 'Twenty',
    25: 'Twenty-Five',
    30: 'Thirty',
    35: 'Thirty-Five',
    40: 'Forty',
    45: 'Forty-Five',
    50: 'Fifty',
    55: 'Fifty-Five',
    60: 'Sixty',
    65: 'Sixty-Five',
    70: 'Seventy',
    75: 'Seventy-Five',
    80: 'Eighty',
    85: 'Eighty-Five',
    90: 'Ninety',
    95: 'Ninety-Five',
    100: 'Hundred'
  };

  static int missingNumberIndex = 0; // Position of the missing number.
  static int missingNumberValue = 0; // The actual missing number.

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
    int maxNumber = 100; // Maximum number allowed
    int maxMultiple = maxNumber ~/ 5; // Maximum multiple of 5 within 100
    int firstNumber = (random.nextInt(maxMultiple - length + 2) + 1) *
        5; // Randomly select the first number, ensuring that the sequence won't exceed 100 and can accommodate the specified length

    // Generate sequential numbers for the sequence
    for (int i = 0; i < length; i++) {
      int nextNumber = firstNumber + i * 5;
      if (nextNumber <= maxNumber) {
        sequence.add(_numberToWord(nextNumber));
      } else {
        // If the next number exceeds 100, stop generating the sequence
        break;
      }
    }

    // If the generated sequence is shorter than the specified length, adjust the length accordingly
    if (sequence.length < length) {
      length = sequence.length;
    }

    // Randomly select the position for the missing number
    missingNumberIndex = random.nextInt(length);
    missingNumberValue = firstNumber + missingNumberIndex * 5;

    // Replace the selected number with a placeholder
    sequence[missingNumberIndex] = '__';

    return sequence;
  }

  static String generateCorrectOption() {
    // Use the missingNumberValue for the correct option.
    return _numberToWord(missingNumberValue);
  }

  static List<String> generateOptions() {
    List<String> options = [];
    Random random = Random();
    String correctOption =
    generateCorrectOption(); // Determine the correct option.

    Set<String> uniqueOptions = {}; // Use a set to ensure uniqueness.

    // Generate random options until we have 3 unique ones different from the correct option.
    while (uniqueOptions.length < 3) {
      int optionNum = (random.nextInt(20) + 1) *
          5; // Generate a multiple of 5 between 5 and 100.
      String option = _numberToWord(optionNum);
      if (option != correctOption && !uniqueOptions.contains(option)) {
        // Ensure it's not the correct option.
        uniqueOptions.add(option);
      }
    }

    // Convert the set to a list and add the correct option.
    options = uniqueOptions.toList();
    options.add(
        correctOption); // Add the correct option to ensure it's always included.

    options
        .shuffle(); // Shuffle the list to randomize the order of the options.
    return options;
  }

  static String convertToSpanish(String number) {
    // Define a map to map English numbers to Spanish
    Map<String, String> spanishNumbers = {
      'Zero': 'Cero',
      'Five': 'Cinco',
      'Ten': 'Diez',
      'Fifteen': 'Quince',
      'Twenty': 'Veinte',
      'Twenty-Five': 'Veinticinco',
      'Thirty': 'Treinta',
      'Thirty-Five': 'Treinta y cinco',
      'Forty': 'Cuarenta',
      'Forty-Five': 'Cuarenta y cinco',
      'Fifty': 'Cincuenta',
      'Fifty-Five': 'Cincuenta y cinco',
      'Sixty': 'Sesenta',
      'Sixty-Five': 'Sesenta y cinco',
      'Seventy': 'Setenta',
      'Seventy-Five': 'Setenta y cinco',
      'Eighty': 'Ochenta',
      'Eighty-Five': 'Ochenta y cinco',
      'Ninety': 'Noventa',
      'Ninety-Five': 'Noventa y cinco',
      'Hundred': 'Cien',
    };

    // If the number is in the map, return its Spanish equivalent, else return the number itself
    return spanishNumbers.containsKey(number)
        ? spanishNumbers[number]!
        : number;
  }
}