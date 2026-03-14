import 'package:flutter_test/flutter_test.dart';

import 'package:student_management_system/main.dart';

void main() {
  testWidgets('app shows the create tab by default', (WidgetTester tester) async {
    await tester.pumpWidget(const StudentManagementApp());

    expect(find.text('Create'), findsWidgets);
    expect(find.text('Student ID'), findsOneWidget);
  });
}
