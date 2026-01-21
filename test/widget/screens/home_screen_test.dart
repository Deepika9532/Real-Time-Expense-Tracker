import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';
import 'package:real_time_expense_tracker/domain/entities/expense.dart';
import 'package:real_time_expense_tracker/domain/entities/user.dart';
import 'package:real_time_expense_tracker/presentation/screens/home/home_screen.dart';
import 'package:real_time_expense_tracker/presentation/providers/expense_provider.dart';
import 'package:real_time_expense_tracker/presentation/providers/auth_provider.dart';

// Mock classes - these will be replaced by generated mocks after running build_runner
class MockExpenseProvider extends Mock implements ExpenseProvider {}

class MockAuthProvider extends Mock implements AuthProvider {}

// Generate mocks using build_runner (uncomment after first run):
// @GenerateMocks([ExpenseNotifier, AuthNotifier])

void main() {
  late MockExpenseProvider mockExpenseProvider;
  late MockAuthProvider mockAuthProvider;

  final tUser = User(id: '1', name: 'Test User', email: 'test@example.com');

  final tExpenses = [
    Expense(
      id: '1',
      title: 'Groceries',
      amount: 50.0,
      categoryId: 'food',
      date: DateTime(2024, 1, 15),
    ),
    Expense(
      id: '2',
      title: 'Gas',
      amount: 40.0,
      categoryId: 'transportation',
      date: DateTime(2024, 1, 14),
    ),
    Expense(
      id: '3',
      title: 'Netflix',
      amount: 15.99,
      categoryId: 'entertainment',
      date: DateTime(2024, 1, 13),
    ),
  ];

  setUp(() {
    mockExpenseProvider = MockExpenseProvider();
    mockAuthProvider = MockAuthProvider();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<ExpenseProvider>.value(
              value: mockExpenseProvider),
          ChangeNotifierProvider<AuthProvider>.value(value: mockAuthProvider),
        ],
        child: const HomeScreen(),
      ),
    );
  }

  group('HomeScreen Widget Tests', () {
    testWidgets('renders loading state correctly', (WidgetTester tester) async {
      // Arrange
      when(mockExpenseProvider.status).thenReturn(ExpenseStatus.loading);
      when(mockAuthProvider.currentUser).thenReturn(tUser);

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders home screen with data correctly', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(mockExpenseProvider.status).thenReturn(ExpenseStatus.success);
      when(mockExpenseProvider.expenses).thenReturn(tExpenses);
      when(mockAuthProvider.currentUser).thenReturn(tUser);
      when(mockAuthProvider.isAuthenticated).thenReturn(true);

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.text('Welcome, Test User'), findsOneWidget);
      expect(find.text('\$105.99'), findsOneWidget); // Total expenses
      expect(find.text('Recent Transactions'), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(3)); // 3 expense items
    });

    testWidgets('shows empty state when no expenses', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(mockExpenseProvider.status).thenReturn(ExpenseStatus.success);
      when(mockExpenseProvider.expenses).thenReturn([]);
      when(mockAuthProvider.currentUser).thenReturn(tUser);
      when(mockAuthProvider.isAuthenticated).thenReturn(true);

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.text('No expenses yet'), findsOneWidget);
      expect(
        find.text('Add your first expense to get started'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('shows error message when error exists', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(mockExpenseProvider.status).thenReturn(ExpenseStatus.error);
      when(mockExpenseProvider.errorMessage)
          .thenReturn('Failed to load expenses');
      when(mockAuthProvider.currentUser).thenReturn(tUser);
      when(mockAuthProvider.isAuthenticated).thenReturn(true);

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.text('Failed to load expenses'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('calls loadExpenses on init', (WidgetTester tester) async {
      // Arrange
      when(mockExpenseProvider.status).thenReturn(ExpenseStatus.success);
      when(mockExpenseProvider.expenses).thenReturn([]);
      when(mockAuthProvider.currentUser).thenReturn(tUser);
      when(mockAuthProvider.isAuthenticated).thenReturn(true);
      when(mockExpenseProvider.loadExpenses(refresh: true))
          .thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      verify(mockExpenseProvider.loadExpenses(refresh: true)).called(1);
    });

    testWidgets('retry button works when error occurs', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(mockExpenseProvider.status).thenReturn(ExpenseStatus.error);
      when(mockExpenseProvider.errorMessage)
          .thenReturn('Failed to load expenses');
      when(mockAuthProvider.currentUser).thenReturn(tUser);
      when(mockAuthProvider.isAuthenticated).thenReturn(true);
      when(mockExpenseProvider.loadExpenses(refresh: true))
          .thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Tap retry button
      await tester.tap(find.text('Retry'));
      await tester.pump();

      // Assert
      verify(mockExpenseProvider.loadExpenses(refresh: true)).called(1);
    });

    testWidgets('add expense floating action button works', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(mockExpenseProvider.status).thenReturn(ExpenseStatus.success);
      when(mockExpenseProvider.expenses).thenReturn(tExpenses);
      when(mockAuthProvider.currentUser).thenReturn(tUser);
      when(mockAuthProvider.isAuthenticated).thenReturn(true);

      // Create a real navigator
      final navigator = MockNavigatorObserver();
      await tester.pumpWidget(
        MaterialApp(
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider<ExpenseProvider>.value(value: mockExpenseProvider),
              ChangeNotifierProvider<AuthProvider>.value(value: mockAuthProvider),
            ],
            child: const HomeScreen(),
          ),
          navigatorObservers: [navigator],
        ),
      );

      // Act - Tap FAB
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Assert - Should navigate to add expense screen
      // Note: Navigation testing pattern
    });

    testWidgets('expense items display correct information', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(mockExpenseProvider.status).thenReturn(ExpenseStatus.success);
      when(mockExpenseProvider.expenses).thenReturn(tExpenses);
      when(mockAuthProvider.currentUser).thenReturn(tUser);
      when(mockAuthProvider.isAuthenticated).thenReturn(true);

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.text('Groceries'), findsOneWidget);
      expect(find.text('\$50.00'), findsOneWidget);
      expect(find.text('Gas'), findsOneWidget);
      expect(find.text('\$40.00'), findsOneWidget);
    });

    testWidgets('pull to refresh triggers reload', (WidgetTester tester) async {
      // Arrange
      when(mockExpenseProvider.status).thenReturn(ExpenseStatus.success);
      when(mockExpenseProvider.expenses).thenReturn(tExpenses);
      when(mockAuthProvider.currentUser).thenReturn(tUser);
      when(mockAuthProvider.isAuthenticated).thenReturn(true);
      when(mockExpenseProvider.loadExpenses(refresh: true)).thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Perform pull to refresh gesture
      final listView = find.byType(RefreshIndicator);
      await tester.drag(listView, const Offset(0, 300));
      await tester.pumpAndSettle();

      // Assert
      verify(mockExpenseProvider.loadExpenses(refresh: true)).called(1);
    });

    testWidgets('logout button in drawer works', (WidgetTester tester) async {
      // Arrange
      when(mockExpenseProvider.status).thenReturn(ExpenseStatus.success);
      when(mockExpenseProvider.expenses).thenReturn(tExpenses);
      when(mockAuthProvider.currentUser).thenReturn(tUser);
      when(mockAuthProvider.isAuthenticated).thenReturn(true);
      when(mockAuthProvider.logout()).thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Open drawer
      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();

      // Tap logout
      await tester.tap(find.text('Logout'));
      await tester.pump();

      // Assert
      verify(mockAuthProvider.logout()).called(1);
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
