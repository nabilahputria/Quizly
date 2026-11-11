import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/responsive_wrapper.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.watch<QuizProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: ResponsiveWrapper(
          maxWidth: 480,
          child: Column(
            children: [
              const SizedBox(height: 24),
              CircleAvatar(
                radius: 48,
                backgroundColor: colorScheme.primary,
                child: Text(
                  quizProvider.userName.isNotEmpty ? quizProvider.userName[0].toUpperCase() : 'U',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: colorScheme.onPrimary),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                quizProvider.userName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                quizProvider.userEmail,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colorScheme.outline),
              ),
              const SizedBox(height: 32),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.dark_mode_outlined),
                      title: const Text('Mode Gelap'),
                      trailing: Switch(
                        value: quizProvider.isDarkMode,
                        onChanged: (_) => quizProvider.toggleTheme(),
                      ),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.quiz_outlined),
                      title: const Text('Total Kuis Diselesaikan'),
                      trailing: Text(
                        '${quizProvider.historyList.length}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              CustomButton(
                label: 'Keluar Akun',
                icon: Icons.logout_rounded,
                isOutlined: true,
                onPressed: () {
                  quizProvider.logout();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}