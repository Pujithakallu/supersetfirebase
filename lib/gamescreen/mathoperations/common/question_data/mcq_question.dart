class McqQuestion{
  final List<String> question;
  final List<List<String>> options;
  final int correctAnswerIndex;
  final String sign;

  const McqQuestion({
    required this.correctAnswerIndex,
    required this.question,
    required this.options,
    required this.sign,
  });
}