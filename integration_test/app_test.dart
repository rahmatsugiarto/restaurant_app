import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:restaurant_app/common/res/strings.dart';
import 'package:restaurant_app/main.dart' as app;

void main() {
  group('Testing App', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('Testing bottom bar navigation', (WidgetTester tester) async {
      const durationDelayToHomePage = Duration(milliseconds: 2500);
      // Build the app
      app.main();
      await tester.pumpAndSettle();
      Future.delayed(durationDelayToHomePage, () async {
        await tester.tap(find.byKey(const ValueKey('home_button')));
        await tester.tap(find.byKey(const ValueKey('favorite_button')));
        await tester.tap(find.byKey(const ValueKey('setting_button')));

        expect(find.text(Strings.hiRahmat), findsOneWidget);
        expect(find.text(Strings.favorite), findsOneWidget);
        expect(find.text(Strings.setting), findsOneWidget);
      });
    });
  });
}
