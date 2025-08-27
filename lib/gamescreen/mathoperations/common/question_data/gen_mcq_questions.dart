import 'package:supersetfirebase/gamescreen/mathoperations/common/question_data/mcq_question.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/random_num_gen.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/translate/translate.dart';
import 'package:supersetfirebase/gamescreen/mathoperations/common/global.dart';
import 'package:spelling_number/spelling_number.dart';
// import 'dart:developer';

List<McqQuestion> getMcqQuestions(String sign, {bool hard = false}) {
  int numLimit = sign == '÷'
      ? hard
          ? 30
          : 20
      : hard
          ? 20
          : 10;
  int totalQuestions = 5;
  int numQuesLim = 2;
  numQuesLim -= 1;
  List<String> langKey = [
    getNumToWordLangKey(GlobalVariables.priLang),
    getNumToWordLangKey(GlobalVariables.secLang)
  ];

  List<List<int>> data = [];

  for (int i = 0; i < totalQuestions; i++) {
    data.add(getRandomNumbersWithLimit(numLimit, numLimit));
  }

  List<McqQuestion> questions = [];

  for (int i = 0; i < data.length; i++) {
    List<String> questionText = [
      '${data[i][0]} $sign ${data[i][1]}',
      '${data[i][0]} $sign ${data[i][1]}'
    ];
    if (i > numQuesLim) {
      questionText = [
        '${SpellingNumber(lang: langKey[0]).convert(data[i][0])} $sign ${SpellingNumber(lang: langKey[0]).convert(data[i][1])}',
        '${SpellingNumber(lang: langKey[1]).convert(data[i][0])} $sign ${SpellingNumber(lang: langKey[1]).convert(data[i][1])}'
      ];
    }

    List<int> rawOptions = [
      data[i][0] + data[i][1],
      data[i][0] - data[i][1],
      data[i][0] * data[i][1],
      data[i][0] ~/ data[i][1],
    ];

    int rawCorrect;
    switch (sign) {
      case '+':
        rawCorrect = 0;
        break;
      case '-':
        rawCorrect = 1;
        break;
      case 'x':
        rawCorrect = 2;
        break;
      case '÷':
        rawCorrect = 3;
        break;
      default:
        rawCorrect = 0;
    }
    for (int j = 0; j < rawOptions.length; j++) {
      if (j != rawCorrect && rawOptions[j] == rawOptions[rawCorrect]) {
        rawOptions[j] =
            getRandomNumberWithLimitNotEqual(numLimit, rawOptions[rawCorrect]);
      }
    }
    // Shuffle options without labels
    List<int> shuffledOptions = List.from(rawOptions)..shuffle();

    // Find the index of the correct answer before shuffling
    int correctAnswerIndex = shuffledOptions.indexOf(rawOptions[rawCorrect]);

    // Create options list with labels
    List<List<String>> options = [];
    if (i > numQuesLim) {
      options = [
        [
          'a) ${SpellingNumber(lang: langKey[0]).convert(shuffledOptions[0])}',
          'a) ${SpellingNumber(lang: langKey[1]).convert(shuffledOptions[0])}'
        ],
        [
          'b) ${SpellingNumber(lang: langKey[0]).convert(shuffledOptions[1])}',
          'b) ${SpellingNumber(lang: langKey[1]).convert(shuffledOptions[1])}'
        ],
        [
          'c) ${SpellingNumber(lang: langKey[0]).convert(shuffledOptions[2])}',
          'c) ${SpellingNumber(lang: langKey[1]).convert(shuffledOptions[2])}'
        ],
        [
          'd) ${SpellingNumber(lang: langKey[0]).convert(shuffledOptions[3])}',
          'd) ${SpellingNumber(lang: langKey[1]).convert(shuffledOptions[3])}'
        ],
      ];
    } else {
      options = [
        ['a) ${shuffledOptions[0]}', 'a) ${shuffledOptions[0]}'],
        ['b) ${shuffledOptions[1]}', 'b) ${shuffledOptions[1]}'],
        ['c) ${shuffledOptions[2]}', 'c) ${shuffledOptions[2]}'],
        ['d) ${shuffledOptions[3]}', 'd) ${shuffledOptions[3]}'],
      ];
    }

    questions.add(
      McqQuestion(
        question: questionText,
        correctAnswerIndex: correctAnswerIndex,
        options: options,
        sign: sign,
      ),
    );
  }
  // log("$questions");
  return questions;
}

List<McqQuestion> getMixMcqQuestions(String sign, {bool hard = false}) {
  List<String> signs = ['+', '-', 'x', '÷'];
  int cnt = 0;
  int currentSignIdx = 0;
  int numLimit = 20;
  int totalQuestions = 20;
  int numQuesLim = 2;
  numQuesLim -= 1;
  List<String> langKey = [
    getNumToWordLangKey(GlobalVariables.priLang),
    getNumToWordLangKey(GlobalVariables.secLang)
  ];
  List<List<int>> data = [];

  for (int i = 0; i < totalQuestions; i++) {
    data.add(getRandomNumbersWithLimit(numLimit, numLimit));
  }

  List<McqQuestion> questions = [];

  for (int i = 0; i < data.length; i++) {
    List<String> questionText = [
      '${data[i][0]} ${signs[currentSignIdx]} ${data[i][1]}',
      '${data[i][0]} ${signs[currentSignIdx]} ${data[i][1]}'
    ];
    if (cnt > numQuesLim) {
      questionText = [
        '${SpellingNumber(lang: langKey[0]).convert(data[i][0])} ${signs[currentSignIdx]} ${SpellingNumber(lang: langKey[0]).convert(data[i][1])}',
        '${SpellingNumber(lang: langKey[1]).convert(data[i][0])} ${signs[currentSignIdx]} ${SpellingNumber(lang: langKey[1]).convert(data[i][1])}'
      ];
    }

    List<int> rawOptions = [
      data[i][0] + data[i][1],
      data[i][0] - data[i][1],
      data[i][0] * data[i][1],
      data[i][0] ~/ data[i][1],
    ];

    int rawCorrect;
    switch (signs[currentSignIdx]) {
      case '+':
        rawCorrect = 0;
        break;
      case '-':
        rawCorrect = 1;
        break;
      case 'x':
        rawCorrect = 2;
        break;
      case '÷':
        rawCorrect = 3;
        break;
      default:
        rawCorrect = 0;
    }
    for (int j = 0; j < rawOptions.length; j++) {
      if (j != rawCorrect && rawOptions[j] == rawOptions[rawCorrect]) {
        rawOptions[j] =
            getRandomNumberWithLimitNotEqual(numLimit, rawOptions[rawCorrect]);
      }
    }
    // Shuffle options without labels
    List<int> shuffledOptions = List.from(rawOptions)..shuffle();

    // Find the index of the correct answer before shuffling
    int correctAnswerIndex = shuffledOptions.indexOf(rawOptions[rawCorrect]);

    // Create options list with labels
    List<List<String>> options = [];
    if (cnt > numQuesLim) {
      options = [
        [
          'a) ${SpellingNumber(lang: langKey[0]).convert(shuffledOptions[0])}',
          'a) ${SpellingNumber(lang: langKey[1]).convert(shuffledOptions[0])}'
        ],
        [
          'b) ${SpellingNumber(lang: langKey[0]).convert(shuffledOptions[1])}',
          'b) ${SpellingNumber(lang: langKey[1]).convert(shuffledOptions[1])}'
        ],
        [
          'c) ${SpellingNumber(lang: langKey[0]).convert(shuffledOptions[2])}',
          'c) ${SpellingNumber(lang: langKey[1]).convert(shuffledOptions[2])}'
        ],
        [
          'd) ${SpellingNumber(lang: langKey[0]).convert(shuffledOptions[3])}',
          'd) ${SpellingNumber(lang: langKey[1]).convert(shuffledOptions[3])}'
        ],
      ];
    } else {
      options = [
        ['a) ${shuffledOptions[0]}', 'a) ${shuffledOptions[0]}'],
        ['b) ${shuffledOptions[1]}', 'b) ${shuffledOptions[1]}'],
        ['c) ${shuffledOptions[2]}', 'c) ${shuffledOptions[2]}'],
        ['d) ${shuffledOptions[3]}', 'd) ${shuffledOptions[3]}'],
      ];
    }

    questions.add(
      McqQuestion(
        question: questionText,
        correctAnswerIndex: correctAnswerIndex,
        options: options,
        sign: signs[currentSignIdx],
      ),
    );
    cnt += 1;
    if (cnt == 5) {
      cnt = 0;
      currentSignIdx += 1;
    }
  }
  // log("$questions");
  return questions;
}
