import 'package:flutter/material.dart';
import '../data/dummy_questions.dart';
import '../models/question_model.dart';

class QuizProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String _userEmail = '';
  String _userName = '';

  String _selectedCourse = 'Pemrograman Mobile';
  String _selectedCategory = 'Semua Topik';

  int _currentQuestionIndex = 0;
  final Map<int, int> _selectedAnswers = {};
  final List<QuizHistory> _historyList = [];
  bool _isDarkMode = false;

  bool get isLoggedIn => _isLoggedIn;
  String get userEmail => _userEmail;
  String get userName => _userName;
  String get selectedCourse => _selectedCourse;
  String get selectedCategory => _selectedCategory;
  int get currentQuestionIndex => _currentQuestionIndex;
  List<QuizHistory> get historyList => _historyList;
  bool get isDarkMode => _isDarkMode;

  // Daftar Mata Kuliah Unik (Diambil langsung dari KRS SATU USU)
  List<String> get availableCourses {
    final courses = dummyQuestions.map((q) => q.course).toSet().toList();
    return courses;
  }

  // Mendapatkan daftar Topik berdasarkan Matkul yang dipilih
  List<String> get availableCategories {
    final categories = dummyQuestions
        .where((q) => q.course == _selectedCourse)
        .map((q) => q.category)
        .toSet()
        .toList();
    return ['Semua Topik', ...categories];
  }

  // Hitung total pertanyaan untuk 1 Mata Kuliah di Beranda
  int getQuestionCountForCourse(String courseName) {
    return dummyQuestions.where((q) => q.course == courseName).length;
  }

  // Ambil skor tertinggi yang pernah diraih untuk 1 Mata Kuliah
  int getBestScoreForCourse(String courseName) {
    final courseHistories = _historyList.where((h) => h.course == courseName);
    if (courseHistories.isEmpty) return 0;
    return courseHistories.map((h) => h.score).reduce((a, b) => a > b ? a : b);
  }

  // Filter soal berdasarkan Mata Kuliah & Topik
  List<Question> get filteredQuestions {
    return dummyQuestions.where((q) {
      final matchesCourse = q.course == _selectedCourse;
      final matchesCategory = _selectedCategory == 'Semua Topik' || q.category == _selectedCategory;
      return matchesCourse && matchesCategory;
    }).toList();
  }

  Question get currentQuestion => filteredQuestions[_currentQuestionIndex];
  int get totalQuestions => filteredQuestions.length;
  Map<int, int> get selectedAnswers => _selectedAnswers;

  int? getSelectedAnswerForCurrent() => _selectedAnswers[_currentQuestionIndex];

  void login(String email) {
    _isLoggedIn = true;
    _userEmail = email.trim();
    if (_userName.isEmpty && _userEmail.contains('@')) {
      final rawName = _userEmail.split('@')[0];
      _userName = rawName[0].toUpperCase() + rawName.substring(1);
    }
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _userEmail = '';
    _userName = '';
    _historyList.clear();
    resetQuiz();
    notifyListeners();
  }

  // Memilih Matkul langsung dari kartu di Beranda lalu reset kuis
  void selectCourseAndStart(String courseName) {
    _selectedCourse = courseName;
    _selectedCategory = 'Semua Topik';
    resetQuiz();
    notifyListeners();
  }

  void setCourse(String course) {
    _selectedCourse = course;
    _selectedCategory = 'Semua Topik';
    resetQuiz();
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    resetQuiz();
    notifyListeners();
  }

  void setUserName(String name) {
    _userName = name.trim();
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void selectAnswer(int optionIndex) {
    _selectedAnswers[_currentQuestionIndex] = optionIndex;
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentQuestionIndex < totalQuestions - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  int calculateCorrectCount() {
    int correct = 0;
    for (int i = 0; i < totalQuestions; i++) {
      if (_selectedAnswers[i] == filteredQuestions[i].correctOptionIndex) correct++;
    }
    return correct;
  }

  int calculateScore() {
    if (totalQuestions == 0) return 0;
    return ((calculateCorrectCount() / totalQuestions) * 100).round();
  }

  void saveToHistory() {
    _historyList.insert(
      0,
      QuizHistory(
        course: _selectedCourse,
        category: _selectedCategory,
        score: calculateScore(),
        correctCount: calculateCorrectCount(),
        totalQuestions: totalQuestions,
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _selectedAnswers.clear();
    notifyListeners();
  }
}