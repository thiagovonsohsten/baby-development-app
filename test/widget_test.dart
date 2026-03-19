// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:baby_development_app/main.dart';

void main() {
  testWidgets('Carrega as abas principais do app', (WidgetTester tester) async {
    await tester.pumpWidget(BabyDevelopmentApp());
    await tester.pumpAndSettle();

    expect(find.text('Início'), findsWidgets);
    expect(find.text('Desenvolvimento'), findsWidgets);
    expect(find.text('Rotina'), findsWidgets);
    expect(find.text('Calendário'), findsWidgets);
    expect(find.text('Checklist'), findsWidgets);
  });
}
