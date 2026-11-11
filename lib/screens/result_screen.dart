import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/responsive_wrapper.dart';
import 'main_tab_screen.dart';
import 'quiz_screen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String _selectedFilter = 'Semua'; // Filter status pembahasan

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuizProvider>().saveToHistory();
    });
  }

  String _getPredicate(int score) {
    if (score >= 80) return 'Luar Biasa! 🎉';
    if (score >= 60) return 'Cukup Baik! 👍';
    return 'Terus Belajar! 💪';
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.watch<QuizProvider>();
    final score = quizProvider.calculateScore();
    final correctCount = quizProvider.calculateCorrectCount();
    final total = quizProvider.totalQuestions;
    final colorScheme = Theme.of(context).colorScheme;
    final questions = quizProvider.filteredQuestions;

    // Filter pembahasan berdasarkan tombol chip yang dipilih
    final filteredIndexList = List.generate(total, (i) => i).where((index) {
      final userAnsIndex = quizProvider.selectedAnswers[index];
      final isCorrect = userAnsIndex == questions[index].correctOptionIndex;
      if (_selectedFilter == 'Benar') return isCorrect;
      if (_selectedFilter == 'Salah') return !isCorrect;
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pembahasan ${quizProvider.selectedCourse}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ResponsiveWrapper(
            child: Column(
              children: [
                // Kartu Skor Lingkaran Kuisin
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        colorScheme.primary,
                        colorScheme.primary.withValues(alpha: 0.85),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _getPredicate(score),
                        style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        quizProvider.userName,
                        style: TextStyle(
                          color: colorScheme.onPrimary.withValues(alpha: 0.9),
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Container(
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$score',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Benar $correctCount dari $total Pertanyaan',
                        style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Tombol Filter Pembahasan (Semua, Benar, Salah)
                Row(
                  children: ['Semua', 'Benar', 'Salah'].map((filter) {
                    final isSelected = _selectedFilter == filter;
                    final count = filter == 'Semua'
                        ? total
                        : filter == 'Benar'
                            ? correctCount
                            : (total - correctCount);

                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text('$filter ($count)'),
                        selected: isSelected,
                        onSelected: (_) {
                          setState(() {
                            _selectedFilter = filter;
                          });
                        },
                        selectedColor: colorScheme.primary,
                        labelStyle: TextStyle(
                          color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 16),

                // List Card Pembahasan Jawaban
                ...filteredIndexList.map((index) {
                  final q = questions[index];
                  final userAnsIndex = quizProvider.selectedAnswers[index];
                  final isCorrect = userAnsIndex == q.correctOptionIndex;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: BorderSide(
                        color: isCorrect
                            ? Colors.green.withValues(alpha: 0.3)
                            : Colors.red.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: isCorrect
                                    ? Colors.green.withValues(alpha: 0.15)
                                    : Colors.red.withValues(alpha: 0.15),
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: isCorrect ? Colors.green : Colors.red,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: isCorrect
                                      ? Colors.green.withValues(alpha: 0.15)
                                      : Colors.red.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  isCorrect ? 'Benar' : 'Salah',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: isCorrect ? Colors.green[700] : Colors.red[700],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            q.questionText,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '✓ Jawabanmu: ${userAnsIndex != null ? q.options[userAnsIndex] : "-"}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isCorrect ? Colors.green[700] : Colors.red[700],
                            ),
                          ),
                          if (!isCorrect) ...[
                            const SizedBox(height: 4),
                            Text(
                              '💡 Kunci Jawaban: ${q.options[q.correctOptionIndex]}',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: colorScheme.primary,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 20),
                CustomButton(
                  label: 'Ulangi Kuis',
                  icon: Icons.refresh_rounded,
                  onPressed: () {
                    quizProvider.resetQuiz();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const QuizScreen()),
                    );
                  },
                ),
                const SizedBox(height: 12),
                CustomButton(
                  label: 'Kembali ke Beranda',
                  icon: Icons.home_rounded,
                  isOutlined: true,
                  onPressed: () {
                    quizProvider.resetQuiz();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const MainTabScreen()),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}