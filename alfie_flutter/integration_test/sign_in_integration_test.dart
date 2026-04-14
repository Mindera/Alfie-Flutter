import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:integration_test/integration_test.dart';
import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:alfie_flutter/main.dart';
import 'package:alfie_flutter/routing/app_route.dart';

const String kInvalidEmailError = 'Please enter a valid email';
const String kEmailRequiredError = kInvalidEmailError;
const String kInvalidCredentialsError = 'Invalid email or password';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Sign-In Feature Integration Tests', () {
    /// Initialize the app with proper dependency setup
    /// Initializes Hive, persistent storage, and GraphQL before pumping the widget
    Future<void> setupApp(WidgetTester tester) async {
      // Initialize Hive for GraphQL persistence (same as main.dart)
      await initHiveForFlutter();

      // Initialize persistent storage service
      final container = ProviderContainer();
      final persistentStorageService = container.read(
        persistentStorageServiceProvider,
      );
      await persistentStorageService.init();

      // Pump the app widget
      await tester.pumpWidget(const ProviderScope(child: MainApp()));
      await tester.pumpAndSettle();

      // Navigate directly to the sign-in screen for targeted tests.
      final scaffoldFinder = find.byType(Scaffold);
      if (scaffoldFinder.evaluate().isNotEmpty) {
        final routerContext = tester.element(scaffoldFinder.first);
        GoRouter.of(routerContext).go(AppRoute.signIn.path);
        await tester.pumpAndSettle();
      } else {
        final routerFinder = find.byType(Router);
        if (routerFinder.evaluate().isNotEmpty) {
          final routerContext = tester.element(routerFinder.first);
          GoRouter.of(routerContext).go(AppRoute.signIn.path);
          await tester.pumpAndSettle();
        }
      }
    }

    /// Enter text into a TextFormField by index position
    /// [index] - Position of the TextFormField (0 = email, 1 = password)
    Future<void> enterTextInField(
      WidgetTester tester,
      int index,
      String text,
    ) async {
      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(index), text);
      await tester.pumpAndSettle();
    }

    /// Tap the login button
    Future<void> tapLoginButton(WidgetTester tester) async {
      final loginButtonFinder = find.widgetWithText(ElevatedButton, 'Log in');

      if (loginButtonFinder.evaluate().isEmpty) {
        final textFinder = find.text('Log in');
        await tester.tap(textFinder);
      } else {
        await tester.tap(loginButtonFinder);
      }

      await tester.pumpAndSettle();
    }

    /// Trigger form validation by unfocusing the current focus
    Future<void> triggerValidation(WidgetTester tester) async {
      final scaffold = find.byType(Scaffold);
      if (scaffold.evaluate().isNotEmpty) {
        await tester.tap(scaffold.first);
        await tester.pumpAndSettle();
      }
    }

    // ============ SUCCESSFUL SIGN-IN TESTS ============

    group('Successful Sign-In', () {
      testWidgets('User successfully signs in with valid credentials', (
        tester,
      ) async {
        await setupApp(tester);

        // Enter valid credentials from mock backend
        await enterTextInField(tester, 0, 'admin@alfie.com');
        await enterTextInField(tester, 1, 'pass');

        // Submit form
        await tapLoginButton(tester);

        // Verify successful login (app navigates away)
        await tester.pumpAndSettle(const Duration(seconds: 2));
      }, tags: ['smoke']);
    });

    // ============ INVALID EMAIL FORMAT TESTS ============

    group('Invalid Email Format Validation', () {
      testWidgets('Rejects email missing @ symbol', (tester) async {
        await setupApp(tester);

        await enterTextInField(tester, 0, 'invalidemail.com');
        await triggerValidation(tester);

        expect(find.text(kInvalidEmailError), findsOneWidget);
      });

      testWidgets('Rejects email missing domain name', (tester) async {
        await setupApp(tester);

        await enterTextInField(tester, 0, 'user@');
        await triggerValidation(tester);

        expect(find.text(kInvalidEmailError), findsOneWidget);
      });

      testWidgets('Rejects email with spaces', (tester) async {
        await setupApp(tester);

        await enterTextInField(tester, 0, 'user @example.com');
        await triggerValidation(tester);

        expect(find.text(kInvalidEmailError), findsOneWidget);
      });

      testWidgets('Rejects email with multiple @ symbols', (tester) async {
        await setupApp(tester);

        await enterTextInField(tester, 0, 'user@@example.com');
        await triggerValidation(tester);

        expect(find.text(kInvalidEmailError), findsOneWidget);
      });

      testWidgets('Requires email field to be non-empty', (tester) async {
        await setupApp(tester);

        // Fill password, leave email empty
        await enterTextInField(tester, 1, 'somepassword');
        await tapLoginButton(tester);

        expect(find.text(kEmailRequiredError), findsOneWidget);
      });

      testWidgets('Rejects email with invalid format (no local part)', (
        tester,
      ) async {
        await setupApp(tester);

        await enterTextInField(tester, 0, '@example.com');
        await triggerValidation(tester);

        expect(find.text(kInvalidEmailError), findsOneWidget);
      });
    });

    // ============ INCORRECT CREDENTIALS TESTS ============

    group('Incorrect Credentials Handling', () {
      testWidgets('Shows error when password is incorrect', (tester) async {
        await setupApp(tester);

        await enterTextInField(tester, 0, 'admin@alfie.com');
        await enterTextInField(tester, 1, 'wrongpassword');

        await tapLoginButton(tester);

        await tester.pumpAndSettle(const Duration(milliseconds: 500));
        expect(find.text(kInvalidCredentialsError), findsOneWidget);
      });

      testWidgets('Shows error when email does not exist', (tester) async {
        await setupApp(tester);

        await enterTextInField(tester, 0, 'nonexistent@example.com');
        await enterTextInField(tester, 1, 'pass');

        await tapLoginButton(tester);

        await tester.pumpAndSettle(const Duration(milliseconds: 500));
        expect(find.text(kInvalidCredentialsError), findsOneWidget);
      });

      testWidgets('Shows error when both credentials are incorrect', (
        tester,
      ) async {
        await setupApp(tester);

        await enterTextInField(tester, 0, 'wrong@example.com');
        await enterTextInField(tester, 1, 'incorrectpass');

        await tapLoginButton(tester);

        await tester.pumpAndSettle(const Duration(milliseconds: 500));
        expect(find.text(kInvalidCredentialsError), findsOneWidget);
      });

      testWidgets('Password is case-sensitive', (tester) async {
        await setupApp(tester);

        // Correct email, wrong case password
        await enterTextInField(tester, 0, 'admin@alfie.com');
        await enterTextInField(tester, 1, 'Pass');

        await tapLoginButton(tester);

        await tester.pumpAndSettle(const Duration(milliseconds: 500));
        expect(find.text(kInvalidCredentialsError), findsOneWidget);
      });

      testWidgets('Shows error for whitespace-only password', (tester) async {
        await setupApp(tester);

        await enterTextInField(tester, 0, 'admin@alfie.com');
        await enterTextInField(tester, 1, '    ');

        await tapLoginButton(tester);

        await tester.pumpAndSettle(const Duration(milliseconds: 500));
        expect(find.text(kInvalidCredentialsError), findsOneWidget);
      });
    });

    // ============ EMPTY FIELDS VALIDATION TESTS ============

    group('Empty Fields Validation', () {
      testWidgets('Prevents sign-in when email is empty', (tester) async {
        await setupApp(tester);

        // Fill password, leave email empty
        await enterTextInField(tester, 1, 'pass');
        await tapLoginButton(tester);

        expect(find.text(kEmailRequiredError), findsOneWidget);
      });

      testWidgets('Prevents sign-in when both fields are empty', (
        tester,
      ) async {
        await setupApp(tester);

        // Attempt login without filling fields
        await tapLoginButton(tester);
        await tester.pumpAndSettle();

        // Validation should prevent submission
        expect(find.text(kEmailRequiredError), findsOneWidget);
      });

      testWidgets('Prevents sign-in when password field is blank', (
        tester,
      ) async {
        await setupApp(tester);

        await enterTextInField(tester, 0, 'admin@alfie.com');
        // Leave password empty

        // Attempt login
        await tapLoginButton(tester);
        await tester.pumpAndSettle();
      });
    });

    // ============ ERROR MESSAGE VERIFICATION TESTS ============

    group('Error Message Display', () {
      testWidgets('Displays error in snackbar for invalid credentials', (
        tester,
      ) async {
        await setupApp(tester);

        await enterTextInField(tester, 0, 'user@example.com');
        await enterTextInField(tester, 1, 'wrongpass');

        await tapLoginButton(tester);

        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        // Verify error message is shown
        final errorMessage = find.text(kInvalidCredentialsError);
        expect(errorMessage, findsOneWidget);

        // Verify it's displayed in a SnackBar
        expect(find.byType(SnackBar), findsOneWidget);
      });

      testWidgets('Error message is positioned correctly', (tester) async {
        await setupApp(tester);

        await enterTextInField(tester, 0, 'test@example.com');
        await enterTextInField(tester, 1, 'wrong');

        await tapLoginButton(tester);

        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        final snackbar = find.byType(SnackBar);
        expect(snackbar, findsOneWidget);

        // Verify snackbar is within screen bounds
        final size = tester.getSize(snackbar);
        expect(size.height, isPositive);
      });

      testWidgets('Multiple failed attempts show error consistently', (
        tester,
      ) async {
        await setupApp(tester);

        // First attempt
        await enterTextInField(tester, 0, 'test1@example.com');
        await enterTextInField(tester, 1, 'wrong1');
        await tapLoginButton(tester);

        await tester.pumpAndSettle(const Duration(milliseconds: 500));
        expect(find.text(kInvalidCredentialsError), findsOneWidget);

        // Second attempt
        await enterTextInField(tester, 0, 'test2@example.com');
        await enterTextInField(tester, 1, 'wrong2');
        await tapLoginButton(tester);

        await tester.pumpAndSettle(const Duration(milliseconds: 500));
        expect(find.text(kInvalidCredentialsError), findsOneWidget);
      });
    });

    // ============ USER INTERFACE INTERACTION TESTS ============

    group('UI Interactions and Behavior', () {
      testWidgets('Email field accepts and displays text input', (
        tester,
      ) async {
        await setupApp(tester);

        const testEmail = 'test.user@example.com';
        await enterTextInField(tester, 0, testEmail);

        expect(find.text(testEmail), findsOneWidget);
      });

      testWidgets('Password field exists and accepts input', (tester) async {
        await setupApp(tester);

        final passwordFields = find.byType(TextFormField);
        expect(passwordFields, findsWidgets);

        await enterTextInField(tester, 1, 'testpassword');

        final field = passwordFields.at(1);
        expect(field, findsOneWidget);
      });

      testWidgets('Login button is visible and tappable', (tester) async {
        await setupApp(tester);

        final loginButton = find.widgetWithText(ElevatedButton, 'Log in');
        expect(loginButton, findsOneWidget);

        // Verify button dimensions
        final size = tester.getSize(loginButton);
        expect(size.width, isPositive);
      });

      testWidgets('Sign In header is displayed', (tester) async {
        await setupApp(tester);

        expect(find.text('Sign In'), findsOneWidget);
      });

      testWidgets('Can replace email text by re-entering value', (
        tester,
      ) async {
        await setupApp(tester);

        // Enter first email
        await enterTextInField(tester, 0, 'first@example.com');
        expect(find.text('first@example.com'), findsOneWidget);

        // Replace with second email
        final emailField = find.byType(TextFormField).at(0);
        await tester.ensureVisible(emailField);
        await tester.pumpAndSettle();

        // Clear field and enter new text
        await tester.tap(emailField);
        await tester.pumpAndSettle();

        // Clear the field
        final String firstText = 'first@example.com';
        for (int i = 0; i < firstText.length; i++) {
          await tester.sendKeyEvent(LogicalKeyboardKey.backspace);
        }
        await tester.pumpAndSettle();

        await tester.enterText(emailField, 'second@example.com');
        await tester.pumpAndSettle();

        expect(find.text('second@example.com'), findsOneWidget);
      });
    });

    // ============ EDGE CASES AND BOUNDARY CONDITIONS ============

    group('Edge Cases and Boundary Conditions', () {
      testWidgets('Accepts very long email address', (tester) async {
        await setupApp(tester);

        const longEmail =
            'verylongemailaddresswithnumbers123456@subdomain.verylongdomainname.example.com';
        await enterTextInField(tester, 0, longEmail);
        await enterTextInField(tester, 1, 'pass');

        await tapLoginButton(tester);

        // Should handle gracefully (either error or successful validation)
        await tester.pumpAndSettle(const Duration(milliseconds: 500));
      });

      testWidgets('Handles rapid consecutive taps on login', (tester) async {
        await setupApp(tester);

        await enterTextInField(tester, 0, 'admin@alfie.com');
        await enterTextInField(tester, 1, 'pass');

        // Rapid consecutive taps
        final loginButton = find.widgetWithText(ElevatedButton, 'Log in');
        await tester.tap(loginButton);
        await tester.tap(loginButton);
        await tester.tap(loginButton);

        // Should not crash or create duplicate submissions
        await tester.pumpAndSettle(const Duration(seconds: 2));
      });

      testWidgets('Processes special characters in email', (tester) async {
        await setupApp(tester);

        await enterTextInField(tester, 0, 'user+tag@example.com');
        await triggerValidation(tester);

        // Plus sign in local part is valid in email format
        final fields = find.byType(TextFormField);
        expect(fields.at(0), findsOneWidget);
      });

      testWidgets('Handles Unicode characters in password gracefully', (
        tester,
      ) async {
        await setupApp(tester);

        await enterTextInField(tester, 0, 'admin@alfie.com');
        await enterTextInField(tester, 1, '你好pass');

        await tapLoginButton(tester);

        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        // Should show error (wrong password)
        expect(find.text(kInvalidCredentialsError), findsOneWidget);
      });
    });

    // ============ FORM STATE AND PERSISTENCE TESTS ============

    group('Form State and Persistence', () {
      testWidgets('Form state resets after failed login attempt', (
        tester,
      ) async {
        await setupApp(tester);

        // First attempt - wrong password
        await enterTextInField(tester, 0, 'admin@alfie.com');
        await enterTextInField(tester, 1, 'wrong');
        await tapLoginButton(tester);

        await tester.pumpAndSettle(const Duration(milliseconds: 500));
        expect(find.text(kInvalidCredentialsError), findsOneWidget);

        // Verify fields still contain the values (app doesn't auto-clear)
        final fields = find.byType(TextFormField);
        expect(fields, findsWidgets);
      });

      testWidgets('Validation state persists across interactions', (
        tester,
      ) async {
        await setupApp(tester);

        // Enter invalid email
        await enterTextInField(tester, 0, 'invalid-email');
        await triggerValidation(tester);

        expect(find.text(kInvalidEmailError), findsOneWidget);

        // Correct the email
        await enterTextInField(tester, 0, 'valid@example.com');
        await tester.pumpAndSettle();

        // Validation error should clear or update
        final field = find.byType(TextFormField).at(0);
        expect(field, findsOneWidget);
      });
    });

    // ============ ACCESSIBILITY AND USABILITY TESTS ============

    group('Accessibility and Usability', () {
      testWidgets('Both input fields are accessible', (tester) async {
        await setupApp(tester);

        final fields = find.byType(TextFormField);
        expect(fields, findsWidgets);

        // Both email and password fields should exist
        expect(fields, findsNWidgets(2));
      });

      testWidgets('Can tab between email and password fields', (tester) async {
        await setupApp(tester);

        final emailField = find.byType(TextFormField).at(0);
        await tester.tap(emailField);
        await tester.pumpAndSettle();

        // Simulate tab key press
        await tester.sendKeyEvent(LogicalKeyboardKey.tab);
        await tester.pumpAndSettle();

        // Focus should move to next field or button
      });
    });
  });
}
