import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:todo/main_test.dart' as app;
import 'package:todo/presentation/screens/todo_editing/widgets/todo_editing_card.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('После создания задание отобразится в списке', (tester) async {
    const enteredText = 'some text';

    await app.main();
    await tester.pumpAndSettle();

    // вошли в экран нового задания
    await tester.tap(find.byIcon(Icons.add).first);
    await tester.pumpAndSettle();

    // ввели текст
    await tester.enterText(find.byType(TodoEditingCard), enteredText);
    await tester.pumpAndSettle();

    // сохранили
    await tester.tap(
      find.descendant(
        of: find.byType(AppBar),
        matching: find.byType(TextButton),
      ),
    );
    // подождали возврата на основной экран
    await tester.pumpAndSettle();

    // проверили, что есть задание с нужным текстом
    expect(find.text(enteredText), findsOneWidget);
  });
}
