import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // TODO: Work in progress
    // await tester.pumpWidget(BottomBar(buttonText: 'Sample Text', buttonAction: () => print('test')));

    expect(find.text('Sample Text'), findsNothing);
  });
}
