// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pharma_lookup_app/main.dart';

void main() {
  testWidgets('App launches and shows home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const PharmaApp());
    await tester.pumpAndSettle();

    expect(find.text('Chào buổi sáng,'), findsOneWidget);
    expect(find.text('Dược sĩ Minh Anh'), findsOneWidget);
    expect(find.byIcon(Icons.home), findsOneWidget);
  });
}
