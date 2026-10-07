import 'package:flutter_test/flutter_test.dart';

import 'package:samplerouting/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Home Page'), findsOneWidget);
    expect(find.text('Profile Page'), findsNothing);
  });
}
