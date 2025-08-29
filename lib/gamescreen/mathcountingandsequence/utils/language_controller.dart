import 'package:flutter/material.dart';

class LanguageController extends ChangeNotifier {
  String currentLanguage = 'en'; // Default to English

  // Define translations map at the class level
  final Map<String, Map<String, String>> translations = {
    'en': {
      'Shell Game - Level': 'Shell Game - Level',
      'Score': 'Score',
      'Congratulations!': 'Congratulations!',
      'You found the correct shell!': 'You found the correct shell!',
      'Game Over': 'Game Over',
      'Wrong shell! Try again.': 'Wrong shell! Try again.',
      'OK': 'OK',
      'find_shell': 'Find the {ordinal} shell to rescue your friend.',
      'hint': 'The shell is in the {row} row and {column} column.',
      'Game Complete!': 'Game Complete!',
      'You completed all 10 levels! Great job!':
          'You completed all 10 levels! Great job!',
    },
    'es': {
      'Shell Game - Level': 'Juego de Conchas - Nivel',
      'Score': 'Puntuación',
      'Congratulations!': '¡Felicidades!',
      'You found the correct shell!': '¡Encontraste la concha correcta!',
      'Game Over': 'Fin del juego',
      'Wrong shell! Try again.': '¡Concha equivocada! Inténtalo de nuevo.',
      'OK': 'Aceptar',
      'find_shell':
          'Encuentra el {ordinal} caparazón para rescatar a tu amigo.',
      'hint': 'El caparazón está en la fila {row} y la columna {column}.',
      'Game Complete!': '¡Juego completado!',
      'You completed all 10 levels! Great job!':
          '¡Completaste los 10 niveles! ¡Buen trabajo!',
    },
  };

  void toggleLanguage() {
    currentLanguage = currentLanguage == 'en' ? 'es' : 'en';
    notifyListeners();
  }

  String translate(String key) {
    if (key.contains('{ordinal}')) {
      return _translateWithOrdinal(key);
    }
    return translations[currentLanguage]?[key] ?? key;
  }

  String _translateWithOrdinal(String key) {
    final ordinalMatch = RegExp(r'\{ordinal\}').firstMatch(key);
    if (ordinalMatch == null) {
      return key; // No placeholders found
    }

    final number = _extractNumberFromKey(key);
    String translatedText = translations[currentLanguage]?[key] ?? key;
    return translatedText.replaceAll('{ordinal}', _ordinalInSpanish(number));
  }

  int _extractNumberFromKey(String key) {
    final numberMatch = RegExp(r'(\d+)').firstMatch(key);
    return numberMatch != null ? int.parse(numberMatch.group(0)!) : 1;
  }

//new method added for translating number to word
  String ordinal_from_number_to_word(int number) {
    if (number == 1) {
      return "first";
    } else {
      return "zero";
    }
  }

  String ordinal(int number) {
    if (currentLanguage == 'es') {
      return _ordinalInSpanish(number);
    } else {
      // Fallback to English ordinals
      return _ordinalInEnglish(number);
    }
  }

  String _ordinalInEnglish(int number) {
    final specialCases = {
      1: 'first',
      2: 'second',
      3: 'third',
      4: 'fourth',
      5: 'fifth',
      6: 'sixth',
      7: 'seventh',
      8: 'eighth',
      9: 'ninth',
      10: 'tenth',
      11: 'eleventh',
      12: 'twelfth',
      13: 'thirteenth',
      14: 'fourteenth',
      15: 'fifteenth',
      16: 'sixteenth',
      17: 'seventeenth',
      18: 'eighteenth',
      19: 'nineteenth',
      20: 'twentieth',
      30: 'thirtieth',
      40: 'fortieth',
      50: 'fiftieth',
      60: 'sixtieth',
      70: 'seventieth',
      80: 'eightieth',
      90: 'ninetieth',
      100: 'hundredth',
    };

    if (specialCases.containsKey(number)) {
      return specialCases[number]!;
    }

    if (number > 20 && number < 100) {
      final tens = (number ~/ 10) * 10;
      final ones = number % 10;
      if (ones == 0) {
        return specialCases[tens]!;
      } else {
        return '${"${specialCases[tens]!.substring(0, specialCases[tens]!.length - 4)}y"}-${specialCases[ones]}';
      }
    }

    // For numbers greater than 100, you might want to implement a more complex logic
    // or fallback to the numeric representation
    return '${number}th';
  }

  String _ordinalInSpanish(int number) {
    // Special cases for numbers 1 to 12.
    switch (number) {
      case 1:
        return 'primero';
      case 2:
        return 'segundo';
      case 3:
        return 'tercero';
      case 4:
        return 'cuarto';
      case 5:
        return 'quinto';
      case 6:
        return 'sexto';
      case 7:
        return 'séptimo';
      case 8:
        return 'octavo';
      case 9:
        return 'noveno';
      case 10:
        return 'décimo';
      case 11:
        return 'undécimo';
      case 12:
        return 'duodécimo';
      default:
        // Maps for prefixes and suffixes.
        Map<int, String> hundreds = {
          1: 'centésimo',
          2: 'ducentésimo',
          3: 'tricentésimo',
          4: 'cuadringentésimo',
          5: 'quingentésimo',
          6: 'sexcentésimo',
          7: 'septingentésimo',
          8: 'octingentésimo',
          9: 'noningentésimo',
          10: 'milésimo'
        };

        Map<int, String> tens = {
          2: 'vigésimo',
          3: 'trigésimo',
          4: 'cuadragésimo',
          5: 'quincuagésimo',
          6: 'sexagésimo',
          7: 'septuagésimo',
          8: 'octogésimo',
          9: 'nonagésimo',
        };

        Map<int, String> units = {
          0: '',
          1: 'primero',
          2: 'segundo',
          3: 'tercero',
          4: 'cuarto',
          5: 'quinto',
          6: 'sexto',
          7: 'séptimo',
          8: 'octavo',
          9: 'noveno'
        };

        int hundred = number ~/ 100; // Calculate hundreds
        int ten = (number % 100) ~/ 10; // Calculate tens
        int unit = number % 10; // Calculate units

        // Construct parts based on the mappings.
        String hundredPart =
            hundred > 0 ? (hundreds[hundred] ?? '$hundredº') : '';
        String tenPart = ten > 0 ? (tens[ten] ?? '') : '';
        String unitPart = units[unit] ?? '';

        // Combine parts, taking care of spaces between words.
        String result = [hundredPart, tenPart, unitPart]
            .where((part) => part.isNotEmpty)
            .join(' ');

        return result;
    }
  }
}
