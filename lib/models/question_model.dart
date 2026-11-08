class Question {
  final int index;
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;

  const Question({
    required this.index,
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });
}
