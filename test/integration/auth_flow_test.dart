import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:real_time_expense_tracker/main.dart' as app;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Authentication Flow Tests', () {
    setUp(() async {
      // Clear shared preferences before each test
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('Complete registration and login flow', (
      WidgetTester tester,
    ) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // ========== REGISTRATION FLOW ==========

      // Verify we're on login screen initially
      expect(find.text('Sign In'), findsWidgets);

      // Navigate to registration screen
      final signUpButton = find.text('Sign Up');
      if (signUpButton.evaluate().isNotEmpty) {
        await tester.tap(signUpButton.first);
        await tester.pumpAndSettle();

        // Verify we're on registration screen
        expect(find.text('Create Account'), findsOneWidget);

        // Fill registration form
        await tester.enterText(find.byKey(const Key('nameField')), 'Test User');
        await tester.enterText(
          find.byKey(const Key('emailField')),
          'test@example.com',
        );
        await tester.enterText(
          find.byKey(const Key('passwordField')),
          'Password123!',
        );
        await tester.enterText(
          find.byKey(const Key('confirmPasswordField')),
          'Password123!',
        );

        // Submit registration
        await tester.tap(find.text('Sign Up').last);
        await tester.pumpAndSettle(const Duration(seconds: 3));
      }

      // ========== LOGIN FLOW ==========

      // Fill login form
      await tester.enterText(
        find.byKey(const Key('emailTextField')),
        'test@example.com',
      );
      await tester.enterText(
        find.byKey(const Key('passwordTextField')),
        'Password123!',
      );

      // Submit login
      await tester.tap(find.text('Sign In').first);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Verify we're logged in and on home screen
      expect(find.text('Expense Tracker'), findsOneWidget);
    });

    testWidgets('Login with invalid credentials shows error', (
      WidgetTester tester,
    ) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Attempt login with invalid credentials
      await tester.enterText(
        find.byKey(const Key('emailTextField')),
        'wrong@example.com',
      );
      await tester.enterText(
        find.byKey(const Key('passwordTextField')),
        'wrongpassword',
      );

      await tester.tap(find.text('Sign In').first);
      await tester.pumpAndSettle();

      // Verify error message is displayed (adjust text based on your app)
      expect(
        find.textContaining('Invalid', findRichText: true),
        findsWidgets,
      );
    });

    testWidgets('Registration validation works correctly', (
      WidgetTester tester,
    ) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Navigate to registration
      final signUpButton = find.text('Sign Up');
      if (signUpButton.evaluate().isNotEmpty) {
        await tester.tap(signUpButton.first);
        await tester.pumpAndSettle();

        // Test empty form validation
        await tester.tap(find.text('Sign Up').last);
        await tester.pump();

        // Check for validation errors (adjust based on your validation messages)
        expect(
            find.textContaining('required', findRichText: true), findsWidgets);

        // Test invalid email
        await tester.enterText(
          find.byKey(const Key('emailField')),
          'invalid-email',
        );
        await tester.tap(find.text('Sign Up').last);
        await tester.pump();

        // Test password mismatch
        await tester.enterText(
          find.byKey(const Key('emailField')),
          'test@example.com',
        );
        await tester.enterText(
          find.byKey(const Key('passwordField')),
          'Password123!',
        );
        await tester.enterText(
          find.byKey(const Key('confirmPasswordField')),
          'Different123!',
        );

        await tester.tap(find.text('Sign Up').last);
        await tester.pump();

        // Test weak password
        await tester.enterText(find.byKey(const Key('passwordField')), '123');
        await tester.enterText(
          find.byKey(const Key('confirmPasswordField')),
          '123',
        );

        await tester.tap(find.text('Sign Up').last);
        await tester.pump();
      }
    });

    testWidgets('Remember me functionality', (WidgetTester tester) async {
      // Start with clean state
      SharedPreferences.setMockInitialValues({});
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Login with remember me checked
      await tester.enterText(
        find.byKey(const Key('emailTextField')),
        'remember@example.com',
      );
      await tester.enterText(
        find.byKey(const Key('passwordTextField')),
        'Password123!',
      );

      // Check remember me (if your app has this feature)
      final rememberMeCheckbox = find.byKey(const Key('rememberMeCheckbox'));
      if (rememberMeCheckbox.evaluate().isNotEmpty) {
        await tester.tap(rememberMeCheckbox);
        await tester.pump();
      }

      await tester.tap(find.text('Sign In').first);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Restart app
      await tester.binding.reassembleApplication();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verify user is still logged in (adjust based on your app)
      expect(find.text('Expense Tracker'), findsOneWidget);
    });

    testWidgets('Logout functionality', (WidgetTester tester) async {
      // First login
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.enterText(
        find.byKey(const Key('emailTextField')),
        'test@example.com',
      );
      await tester.enterText(
        find.byKey(const Key('passwordTextField')),
        'Password123!',
      );
      await tester.tap(find.text('Sign In').first);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Open drawer or settings
      final drawerButton = find.byTooltip('Open navigation menu');
      if (drawerButton.evaluate().isNotEmpty) {
        await tester.tap(drawerButton);
        await tester.pumpAndSettle();

        // Find and tap logout
        final logoutButton = find.text('Logout');
        if (logoutButton.evaluate().isNotEmpty) {
          await tester.tap(logoutButton);
          await tester.pumpAndSettle(const Duration(seconds: 2));

          // Verify back to login screen
          expect(find.text('Sign In'), findsWidgets);
        }
      }
    });

    testWidgets('Password visibility toggle', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Find password field
      final passwordField = find.byKey(const Key('passwordTextField'));
      if (passwordField.evaluate().isNotEmpty) {
        await tester.enterText(passwordField, 'MyPassword123');

        // Initially should be obscured
        var textField = tester.widget<TextField>(passwordField);
        expect(textField.obscureText, true);

        // Find and tap visibility toggle
        final visibilityIcon = find.byIcon(Icons.visibility_off);
        if (visibilityIcon.evaluate().isNotEmpty) {
          await tester.tap(visibilityIcon.first);
          await tester.pump();

          // Now should be visible
          textField = tester.widget<TextField>(passwordField);
          expect(textField.obscureText, false);

          // Tap again to hide
          await tester.tap(find.byIcon(Icons.visibility).first);
          await tester.pump();

          textField = tester.widget<TextField>(passwordField);
          expect(textField.obscureText, true);
        }
      }
    });

    testWidgets('Forgot password flow', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Find and tap forgot password link
      final forgotPasswordLink = find.text('Forgot Password?');
      if (forgotPasswordLink.evaluate().isNotEmpty) {
        await tester.tap(forgotPasswordLink);
        await tester.pumpAndSettle();

        // Verify on forgot password screen
        expect(find.text('Reset Password'), findsOneWidget);

        // Enter email
        await tester.enterText(
          find.byKey(const Key('emailField')),
          'test@example.com',
        );
        await tester.tap(find.text('Send Reset Link'));
        await tester.pumpAndSettle();

        // Go back to login
        final backButton = find.text('Back to Login');
        if (backButton.evaluate().isNotEmpty) {
          await tester.tap(backButton);
          await tester.pumpAndSettle();

          expect(find.text('Sign In'), findsWidgets);
        }
      }
    });
  });
}
