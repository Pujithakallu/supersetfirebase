import 'dart:math';
import 'number_to_word_1.dart';
class NumberGenerator1 {
  static int n = 0; // Starting number of the sequence
  static int missingNumberPosition =
  0; // Position of the missing number in the sequence

  static List<String> generateSequence(int length) {
    List<String> sequence = [];
    Random random = Random();
    n = random.nextInt((100 - length) ~/ 2) *
        2; // Ensure sequence fits within 0-100 range and generate only even numbers

    // Determine the position of the missing number
    missingNumberPosition = random.nextInt(length);

    for (int i = 0; i < length; i++) {
      if (i == missingNumberPosition) {
        sequence.add('__');
      } else {
        sequence.add(NumberToWord1.convert(n + i * 2));
      }
    }

    return sequence;
  }

  static String generateCorrectOption(List<String> sequence) {
    // The correct option is the number at the missing position
    return NumberToWord1.convert(n + missingNumberPosition * 2);
  }

  static List<String> generateOptions(List<String> sequence) {
    List<String> options = [];
    Random random = Random();
    Set<String> optionsSet = {}; // Use a Set to avoid duplicate options

    // Add random options
    while (optionsSet.length < 3) {
      int option = random.nextInt(100);
      // Ensure the random option is not the correct answer
      if (option != n + missingNumberPosition * 2) {
        optionsSet.add(NumberToWord1.convert(option));
      }
    }

    // Add the correct option
    optionsSet.add(NumberToWord1.convert(n + missingNumberPosition * 2));
    options = optionsSet.toList();

    // Shuffle the options
    options.shuffle();

    return options;
  }

  static String convertToSpanish(String number) {
    // Define a map to map English numbers to Spanish
    Map<String, String> spanishNumbers = {
      'One': 'Uno',
      'Two': 'Dos',
      'Three': 'Tres',
      'Four': 'Cuatro',
      'Five': 'Cinco',
      'Six': 'Seis',
      'Seven': 'Siete',
      'Eight': 'Ocho',
      'Nine': 'Nueve',
      'Ten': 'Diez',
      'Eleven': 'Once',
      'Twelve': 'Doce',
      'Thirteen': 'Trece',
      'Fourteen': 'Catorce',
      'Fifteen': 'Quince',
      'Sixteen': 'Dieciséis',
      'Seventeen': 'Diecisiete',
      'Eighteen': 'Dieciocho',
      'Nineteen': 'Diecinueve',
      'Twenty': 'Veinte',
      'Twenty One': 'Veintiuno',
      'Twenty Two': 'Veintidós',
      'Twenty Three': 'Veintitrés',
      'Twenty Four': 'Veinticuatro',
      'Twenty Five': 'Veinticinco',
      'Twenty Six': 'Veintiséis',
      'Twenty Seven': 'Veintisiete',
      'Twenty Eight': 'Veintiocho',
      'Twenty Nine': 'Veintinueve',
      'Thirty': 'Treinta',
      'Thirty One': 'Treinta y uno',
      'Thirty Two': 'Treinta y dos',
      'Thirty Three': 'Treinta y tres',
      'Thirty Four': 'Treinta y cuatro',
      'Thirty Five': 'Treinta y cinco',
      'Thirty Six': 'Treinta y seis',
      'Thirty Seven': 'Treinta y siete',
      'Thirty Eight': 'Treinta y ocho',
      'Thirty Nine': 'Treinta y nueve',
      'Forty': 'Cuarenta',
      'Forty One': 'Cuarenta y uno',
      'Forty Two': 'Cuarenta y dos',
      'Forty Three': 'Cuarenta y tres',
      'Forty Four': 'Cuarenta y cuatro',
      'Forty Five': 'Cuarenta y cinco',
      'Forty Six': 'Cuarenta y seis',
      'Forty Seven': 'Cuarenta y siete',
      'Forty Eight': 'Cuarenta y ocho',
      'Forty Nine': 'Cuarenta y nueve',
      'Fifty': 'Cincuenta',
      'Fifty One': 'Cincuenta y uno',
      'Fifty Two': 'Cincuenta y dos',
      'Fifty Three': 'Cincuenta y tres',
      'Fifty Four': 'Cincuenta y cuatro',
      'Fifty Five': 'Cincuenta y cinco',
      'Fifty Six': 'Cincuenta y seis',
      'Fifty Seven': 'Cincuenta y siete',
      'Fifty Eight': 'Cincuenta y ocho',
      'Fifty Nine': 'Cincuenta y nueve',
      'Sixty': 'Sesenta',
      'Sixty One': 'Sesenta y uno',
      'Sixty Two': 'Sesenta y dos',
      'Sixty Three': 'Sesenta y tres',
      'Sixty Four': 'Sesenta y cuatro',
      'Sixty Five': 'Sesenta y cinco',
      'Sixty Six': 'Sesenta y seis',
      'Sixty Seven': 'Sesenta y siete',
      'Sixty Eight': 'Sesenta y ocho',
      'Sixty Nine': 'Sesenta y nueve',
      'Seventy': 'Setenta',
      'Seventy One': 'Setenta y uno',
      'Seventy Two': 'Setenta y dos',
      'Seventy Three': 'Setenta y tres',
      'Seventy Four': 'Setenta y cuatro',
      'Seventy Five': 'Setenta y cinco',
      'Seventy Six': 'Setenta y seis',
      'Seventy Seven': 'Setenta y siete',
      'Seventy Eight': 'Setenta y ocho',
      'Seventy Nine': 'Setenta y nueve',
      'Eighty': 'Ochenta',
      'Eighty One': 'Ochenta y uno',
      'Eighty Two': 'Ochenta y dos',
      'Eighty Three': 'Ochenta y tres',
      'Eighty Four': 'Ochenta y cuatro',
      'Eighty Five': 'Ochenta y cinco',
      'Eighty Six': 'Ochenta y seis',
      'Eighty Seven': 'Ochenta y siete',
      'Eighty Eight': 'Ochenta y ocho',
      'Eighty Nine': 'Ochenta y nueve',
      'Ninety': 'Noventa',
      'Ninety One': 'Noventa y uno',
      'Ninety Two': 'Noventa y dos',
      'Ninety Three': 'Noventa y tres',
      'Ninety Four': 'Noventa y cuatro',
      'Ninety Five': 'Noventa y cinco',
      'Ninety Six': 'Noventa y seis',
      'Ninety Seven': 'Noventa y siete',
      'Ninety Eight': 'Noventa y ocho',
      'Ninety Nine': 'Noventa y nueve',
      'Hundred': 'Cien',
    };

    // If the number is in the map, return its Spanish equivalent, else return the number itself
    return spanishNumbers.containsKey(number)
        ? spanishNumbers[number]!
        : number;
  }
}