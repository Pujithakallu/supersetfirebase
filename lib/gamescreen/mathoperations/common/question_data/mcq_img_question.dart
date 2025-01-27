class McqImgQuestion{
  final List<String> question;
  final int firstNum;
  final int secNum;
  final List<List<String>> options;
  final int correctAnswerIndex;
  final String sign;

  const McqImgQuestion({
    required this.correctAnswerIndex,
    required this.firstNum,
    required this.secNum,
    required this.question,
    required this.options,
    required this.sign,
  });
}