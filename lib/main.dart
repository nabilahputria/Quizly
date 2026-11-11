import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/quiz_provider.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => QuizProvider(),
      child: const QuizlyApp(),
    ),
  );
}

class QuizlyApp extends StatelessWidget {
  const QuizlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<QuizProvider>().isDarkMode;

    return MaterialApp(
      title: 'Quizly - UTS Pemrograman Mobile',
      debugShowCheckedModeBanner: false,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        colorSchemeSeed: const Color(0xFF4F46E5),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        colorSchemeSeed: const Color(0xFF4F46E5),
        brightness: Brightness.dark,
      ),
      home: const LoginScreen(),
    );
  }
}