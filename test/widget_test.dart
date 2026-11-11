import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:quizly_app/main.dart';
import 'package:quizly_app/providers/quiz_provider.dart';

void main() {
  testWidgets('Quizly smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => QuizProvider(),
        child: const QuizlyApp(),
      ),
    );
    expect(find.text('Quizly'), findsOneWidget);
  });
}