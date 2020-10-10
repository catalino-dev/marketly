import 'package:flutter_test/flutter_test.dart';
import 'package:marketly/widgets/widgets.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // expect:
    await tester.pumpWidget(BottomBar(buttonText: 'Sample Text', buttonAction: () => print('test')));

    expect(find.text('Sample Text'), findsOneWidget);

    // when:
    // await tester.tap(find.byWidgetPredicate((widget) => widget is GestureDetector));
    // await tester.pump();
    // expect(find.widgetWithText(Text, 'Sample Text'), findsOneWidget);
  });
}
