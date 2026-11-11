class Question {
  final String id;
  final String course;
  final String category;
  final String questionText;
  final List<String> options;
  final int correctOptionIndex;

  const Question({
    required this.id,
    required this.course,
    required this.category,
    required this.questionText,
    required this.options,
    required this.correctOptionIndex,
  });
}

class QuizHistory {
  final String course;
  final String category;
  final int score;
  final int correctCount;
  final int totalQuestions;
  final DateTime date;

  QuizHistory({
    required this.course,
    required this.category,
    required this.score,
    required this.correctCount,
    required this.totalQuestions,
    required this.date,
  });
}