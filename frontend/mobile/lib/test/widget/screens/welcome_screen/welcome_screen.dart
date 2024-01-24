import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mot/helper/app_router.dart';
import 'package:mot/screens/sign_in/sign_in_screen.dart';
import 'package:mot/screens/welcome_screen/welcome_screen.dart';
import 'package:mot/theme.dart';

void main() {
  testWidgets('WelcomeScreen UI test', (WidgetTester tester) async {

    await tester.pumpWidget(
      Builder(
        builder: (BuildContext context) {
          MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'MOT',
            theme: AppTheme.darkTheme(context),
            routerConfig: router,
          );

          // The builder function must return a widget.
          return Placeholder();
        },
      ),
    );

    // Verify that the WelcomeScreen displays correctly.
    expect(find.text('Welcome to MOT, Let’s shop!'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);

    // Tap on the "Continue" button and verify navigation to SignInScreen.
    await tester.tap(find.text('Continue'));
    await tester.pump();

    // Verify that the SignInScreen is navigated to.
    expect(find.byType(SignInScreen), findsOneWidget);
  });
}
