import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/responsive_wrapper.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.watch<QuizProvider>();
    final history = quizProvider.historyList;
    final colorScheme = Theme.of(context).colorScheme;

    // Hitung statistik otomatis
    final totalCompleted = history.length;
    final averageScore = history.isEmpty
        ? 0
        : (history.map((e) => e.score).reduce((a, b) => a + b) / totalCompleted).round();
    final uniqueCourses = history.map((e) => e.course).toSet().length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Belajar', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ResponsiveWrapper(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Banner Biru khas Figma Kuisin
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Riwayat belajar',
                        style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Pantau perkembangan nilaimu',
                        style: TextStyle(
                          color: colorScheme.onPrimary.withValues(alpha: 0.8),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // 3 Kotak Statistik (Kuis Selesai, Rata-rata, Materi Dicoba)
                      Row(
                        children: [
                          _buildStatCard(
                            context,
                            icon: Icons.history_edu_rounded,
                            value: '$totalCompleted',
                            label: 'Kuis selesai',
                          ),
                          const SizedBox(width: 10),
                          _buildStatCard(
                            context,
                            icon: Icons.analytics_rounded,
                            value: '$averageScore',
                            label: 'Rata-rata',
                          ),
                          const SizedBox(width: 10),
                          _buildStatCard(
                            context,
                            icon: Icons.auto_stories_rounded,
                            value: '$uniqueCourses/6',
                            label: 'Materi dicoba',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                Text(
                  'Kuis Terakhir',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Ketuk untuk melihat rincian riwayat',
                  style: TextStyle(fontSize: 12, color: colorScheme.onSurface.withValues(alpha: 0.6)),
                ),
                const SizedBox(height: 12),

                // Daftar Riwayat Pengerjaan Kuis
                history.isEmpty
                    ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.history_toggle_off_rounded, size: 56, color: colorScheme.outline),
                            const SizedBox(height: 12),
                            const Text(
                              'Belum ada riwayat kuis',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Selesaikan kuis di beranda untuk melihat riwayat.',
                              style: TextStyle(fontSize: 12, color: colorScheme.outline),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: history.length,
                        itemBuilder: (context, index) {
                          final item = history[index];
                          final formattedDate =
                              '${_twoDigits(item.date.day)}/${_twoDigits(item.date.month)}/${item.date.year} ${_twoDigits(item.date.hour)}:${_twoDigits(item.date.minute)}';

                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(
                                color: colorScheme.outline.withValues(alpha: 0.2),
                              ),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              leading: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: colorScheme.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(Icons.school_rounded, color: colorScheme.primary),
                              ),
                              title: Text(
                                item.course,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  '${item.correctCount}/${item.totalQuestions} benar • $formattedDate',
                                  style: const TextStyle(fontSize: 12.5),
                                ),
                              ),
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                decoration: BoxDecoration(
                                  color: colorScheme.primaryContainer.withValues(alpha: 0.6),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${item.score}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ),
                            ),
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

  Widget _buildStatCard(BuildContext context, {required IconData icon, required String value, required String label}) {
    final colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20, color: colorScheme.primary),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}