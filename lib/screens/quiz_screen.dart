import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/option_card.dart';
import '../widgets/responsive_wrapper.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.watch<QuizProvider>();
    final question = quizProvider.currentQuestion;
    final currentIndex = quizProvider.currentQuestionIndex;
    final total = quizProvider.totalQuestions;
    final selectedAnswer = quizProvider.getSelectedAnswerForCurrent();
    final isLastQuestion = currentIndex == total - 1;
    final optionLetters = ['A', 'B', 'C', 'D'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Halo, ${quizProvider.userName}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Chip(
                label: Text(
                  '${currentIndex + 1} / $total',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ResponsiveWrapper(
            maxWidth: 850,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress Bar Dinamis
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: (currentIndex + 1) / total,
                    minHeight: 8,
                  ),
                ),
                const SizedBox(height: 20),

                // Adaptive Layout: 2 kolom di tablet/web lebar, 1 kolom di HP
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 680;

                    final questionBox = Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primaryContainer
                            .withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              question.category,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            question.questionText,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    );

                    final optionsList = Column(
                      children: List.generate(question.options.length, (index) {
                        return OptionCard(
                          optionLetter: optionLetters[index],
                          optionText: question.options[index],
                          isSelected: selectedAnswer == index,
                          onTap: () => quizProvider.selectAnswer(index),
                        );
                      }),
                    );

                    if (isWide) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 5, child: questionBox),
                          const SizedBox(width: 24),
                          Expanded(flex: 6, child: optionsList),
                        ],
                      );
                    }

                    return Column(
                      children: [
                        questionBox,
                        const SizedBox(height: 20),
                        optionsList,
                      ],
                    );
                  },
                ),

                const SizedBox(height: 24),

                // Tombol Navigasi Soal
                Row(
                  children: [
                    if (currentIndex > 0) ...[
                      Expanded(
                        child: CustomButton(
                          label: 'Sebelumnya',
                          icon: Icons.arrow_back_rounded,
                          isOutlined: true,
                          onPressed: () => quizProvider.previousQuestion(),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: CustomButton(
                        label: isLastQuestion ? 'Selesai & Lihat Skor' : 'Selanjutnya',
                        icon: isLastQuestion
                            ? Icons.check_rounded
                            : Icons.arrow_forward_rounded,
                        onPressed: selectedAnswer == null
                            ? null
                            : () {
                          if (isLastQuestion) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ResultScreen(),
                              ),
                            );
                          } else {
                            quizProvider.nextQuestion();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}