import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list_app/main.dart';

void main() {
  testWidgets('adds, completes, counts, and deletes tasks', (tester) async {
    tester.view.physicalSize = const Size(800, 1000);
    tester.view.devicePixelRatio = 1;
    await tester.pumpWidget(const TodoApp());

    expect(find.text('Nothing here yet. Add your first task!'), findsOneWidget);
    await tester.tap(find.text('Add'));
    await tester.pump();
    expect(find.text('0 remaining'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Review Flutter widgets');
    await tester.tap(find.text('Add'));
    await tester.pump();
    expect(find.text('Review Flutter widgets'), findsOneWidget);
    expect(find.text('1 remaining'), findsOneWidget);

    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    expect(find.text('0 remaining'), findsOneWidget);

    await tester.tap(find.byTooltip('Delete Review Flutter widgets'));
    await tester.pumpAndSettle();
    expect(find.text('Nothing here yet. Add your first task!'), findsOneWidget);

    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
}
