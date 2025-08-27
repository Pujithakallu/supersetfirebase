class TextQuestion {
  final List<String> question;
  final String answer;
  final String sign;

  const TextQuestion({
    required this.answer,
    required this.question,
    required this.sign,
  });
  @override
  String toString() {
    return 'TextQuestion{question: $question, answer: $answer, sign: $sign}';
  }
}
