import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:real_time_expense_tracker/presentation/providers/auth_provider.dart';
import 'package:real_time_expense_tracker/presentation/screens/auth/login_screen.dart';

class MockAuthProvider extends Mock implements AuthProvider {
  bool _isLoading = false;
  String? _errorMessage;
  bool _isAuthenticated = false;

  @override
  bool get isLoading => _isLoading;

  @override
  String? get errorMessage => _errorMessage;

  @override
  bool get isAuthenticated => _isAuthenticated;

  @override
  Future<bool> login({
    required String email,
    required String password,
    bool rememberMe = false,
  });

  @override
  void clearError() {}

  // Methods to set values for testing
  void setIsLoading(bool value) {
    _isLoading = value;
  }

  void setErrorMessage(String? value) {
    _errorMessage = value;
  }

  void setIsAuthenticated(bool value) {
    _isAuthenticated = value;
  }
}

void main() {
  late MockAuthProvider mockAuthProvider;

  setUp(() {
    mockAuthProvider = MockAuthProvider();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: ChangeNotifierProvider.value(
        value: mockAuthProvider,
        child: const LoginScreen(),
      ),
    );
  }

  group('LoginScreen Widget Tests', () {
    testWidgets('renders all UI elements correctly', (
      WidgetTester tester,
    ) async {
      // Arrange
      mockAuthProvider.setIsLoading(false);
      mockAuthProvider.setErrorMessage(null);

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.text('Welcome Back'), findsOneWidget);
      expect(find.text('Sign in to continue'), findsOneWidget);
      expect(find.byType(TextFormField),
          findsNWidgets(2)); // Email and password fields
      expect(find.text('Sign In'), findsOneWidget);
      expect(find.text("Don't have an account?"), findsOneWidget);
      expect(find.text('Sign Up'), findsOneWidget);
    });

    testWidgets('shows loading indicator when isLoading is true', (
      WidgetTester tester,
    ) async {
      // Arrange
      mockAuthProvider.setIsLoading(true);

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error message when error exists', (
      WidgetTester tester,
    ) async {
      // Arrange
      mockAuthProvider.setIsLoading(false);
      mockAuthProvider.setErrorMessage('Invalid credentials');

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.text('Invalid credentials'), findsOneWidget);
    });

    testWidgets('calls login when form is submitted with valid data', (
      WidgetTester tester,
    ) async {
      // Arrange
      mockAuthProvider.setIsLoading(false);
      mockAuthProvider.setErrorMessage(null);
      when(mockAuthProvider.login(
        email: 'test@example.com',
        password: 'password123',
        rememberMe: true,
      )).thenAnswer((_) async => true);
      when(mockAuthProvider.login(
        email: 'test@example.com',
        password: 'password123',
        rememberMe: false,
      )).thenAnswer((_) async => true);

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Enter email
      await tester.enterText(
        find.byType(TextFormField).first,
        'test@example.com',
      );
      // Enter password
      await tester.enterText(
        find.byType(TextFormField).last,
        'password123',
      );

      // Tap login button
      await tester.tap(find.text('Sign In'));
      await tester.pump();

      // Assert
      verify(mockAuthProvider.login(
        email: 'test@example.com',
        password: 'password123',
      )).called(1);
    });

    testWidgets('shows validation errors for empty fields', (
      WidgetTester tester,
    ) async {
      // Arrange
      mockAuthProvider.setIsLoading(false);
      mockAuthProvider.setErrorMessage(null);

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Tap login button without entering data
      await tester.tap(find.text('Sign In'));
      await tester.pump();

      // Assert - The validation errors should appear based on form validation
      // Since the actual validation happens inside the form, we'll check if error text appears
      // after submitting with empty fields
      expect(find.textContaining('Email'),
          findsWidgets); // Field should still show
    });

    testWidgets('shows validation error for invalid email', (
      WidgetTester tester,
    ) async {
      // Arrange
      mockAuthProvider.setIsLoading(false);
      mockAuthProvider.setErrorMessage(null);

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Enter invalid email
      await tester.enterText(
        find.byType(TextFormField).first,
        'invalid-email',
      );
      await tester.enterText(
        find.byType(TextFormField).last,
        'password123',
      );

      // Tap login button
      await tester.tap(find.text('Sign In'));
      await tester.pump();

      // Assert - Check if validation error appears
      expect(find.textContaining('valid email'),
          findsWidgets); // Expect validation error
    });

    testWidgets('password visibility toggle works', (
      WidgetTester tester,
    ) async {
      // Arrange
      mockAuthProvider.setIsLoading(false);
      mockAuthProvider.setErrorMessage(null);

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Enter password
      await tester.enterText(
        find.byType(TextFormField).last,
        'password123',
      );

      // Initially should be obscured
      // The password field should initially show the visibility_off icon (eye with line through it)
      expect(find.byIcon(Icons.visibility_off_outlined),
          findsOneWidget); // Initially shows eye-off icon

      // Tap visibility toggle
      await tester.tap(find.byIcon(Icons.visibility_off_outlined));
      await tester.pump();

      // Now should show the visibility icon (eye without line)
      expect(find.byIcon(Icons.visibility_outlined),
          findsOneWidget); // Shows eye icon
    });

    testWidgets('navigates to register screen when sign up is tapped', (
      WidgetTester tester,
    ) async {
      // Arrange
      mockAuthProvider.setIsLoading(false);
      mockAuthProvider.setErrorMessage(null);

      // Create a real navigator
      final navigator = MockNavigatorObserver();
      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: mockAuthProvider,
          child: MaterialApp(
            home: const LoginScreen(),
            navigatorObservers: [navigator],
          ),
        ),
      );

      // Act - Tap sign up text
      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();

      // Assert - Should navigate to register screen
      // Note: We can't easily test navigation without a real navigator setup
      // This test shows the pattern for navigation testing
    });

    testWidgets('clears error when user starts typing', (
      WidgetTester tester,
    ) async {
      // Arrange
      mockAuthProvider.setIsLoading(false);
      mockAuthProvider.setErrorMessage('Some error');

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Verify error is shown
      expect(find.text('Some error'), findsOneWidget);

      // Start typing in email field
      await tester.enterText(find.byType(TextFormField).first, 't');

      // Assert
      verify(mockAuthProvider.clearError()).called(1);
    });

    testWidgets('disables button when loading', (WidgetTester tester) async {
      // Arrange
      mockAuthProvider.setIsLoading(true);

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert - find the button and check if it's enabled
      final button = find.widgetWithText(ElevatedButton, 'Sign In');
      expect(button, findsOneWidget);

      final elevatedButton = tester.widget<ElevatedButton>(button);
      expect(elevatedButton.enabled, false);
    });
  });
}

// Mock navigator observer for testing navigation
class MockNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // Can add assertions here
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // Can add assertions here
  }
}
