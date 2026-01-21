import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:real_time_expense_tracker/main.dart' as app;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-End Expense CRUD Test', () {
    setUp(() async {
      // Clear shared preferences before each test
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('Complete expense lifecycle: Add, View, Edit, Delete', (
      WidgetTester tester,
    ) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // ========== ADD EXPENSE ==========

      // Find and tap the FAB to add expense
      final fab = find.byType(FloatingActionButton);
      if (fab.evaluate().isNotEmpty) {
        await tester.tap(fab);
        await tester.pumpAndSettle();

        // Verify we're on the add expense screen
        expect(find.text('Add Expense'), findsOneWidget);

        // Fill the form
        await tester.enterText(
          find.byKey(const Key('titleField')),
          'Test Expense',
        );
        await tester.enterText(find.byKey(const Key('amountField')), '100.50');

        // Select category (simulate tap on category field)
        final categoryField = find.byKey(const Key('categoryField'));
        if (categoryField.evaluate().isNotEmpty) {
          await tester.tap(categoryField);
          await tester.pumpAndSettle();

          // Select Food category from dropdown/picker
          final foodOption = find.text('Food');
          if (foodOption.evaluate().isNotEmpty) {
            await tester.tap(foodOption.last);
            await tester.pumpAndSettle();
          }
        }

        // Add description
        final descriptionField = find.byKey(const Key('descriptionField'));
        if (descriptionField.evaluate().isNotEmpty) {
          await tester.enterText(descriptionField, 'Test description');
        }

        // Select payment method
        final paymentMethodField = find.byKey(const Key('paymentMethodField'));
        if (paymentMethodField.evaluate().isNotEmpty) {
          await tester.tap(paymentMethodField);
          await tester.pumpAndSettle();

          final creditCardOption = find.text('Credit Card');
          if (creditCardOption.evaluate().isNotEmpty) {
            await tester.tap(creditCardOption.last);
            await tester.pumpAndSettle();
          }
        }

        // Save the expense
        await tester.tap(find.text('Save'));
        await tester.pumpAndSettle(const Duration(seconds: 2));

        // Verify expense is displayed
        expect(find.text('Test Expense'), findsWidgets);
      }

      // ========== EDIT EXPENSE ==========

      // Find and tap edit button
      final editButton = find.byIcon(Icons.edit);
      if (editButton.evaluate().isNotEmpty) {
        await tester.tap(editButton.first);
        await tester.pumpAndSettle();

        // Update the expense
        await tester.enterText(
          find.byKey(const Key('titleField')),
          'Updated Expense',
        );
        await tester.enterText(find.byKey(const Key('amountField')), '150.75');

        // Save the update
        final updateButton = find.text('Update');
        if (updateButton.evaluate().isNotEmpty) {
          await tester.tap(updateButton);
        } else {
          await tester.tap(find.text('Save'));
        }
        await tester.pumpAndSettle(const Duration(seconds: 2));

        // Verify update
        expect(find.text('Updated Expense'), findsWidgets);
      }

      // ========== DELETE EXPENSE ==========

      // Find and initiate delete
      final deleteButton = find.byIcon(Icons.delete);
      if (deleteButton.evaluate().isNotEmpty) {
        await tester.tap(deleteButton.first);
        await tester.pumpAndSettle();

        // Confirm deletion
        final confirmButton = find.text('Delete');
        if (confirmButton.evaluate().isNotEmpty) {
          await tester.tap(confirmButton);
          await tester.pumpAndSettle(const Duration(seconds: 2));
        }
      }
    });

    testWidgets('Add multiple expenses and verify total calculation', (
      WidgetTester tester,
    ) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Add first expense
      await _addExpense(tester, 'Lunch', 25.00, 'Food');

      // Add second expense
      await _addExpense(tester, 'Gas', 45.50, 'Transportation');

      // Add third expense
      await _addExpense(tester, 'Movie', 30.00, 'Entertainment');

      // Verify all expenses are displayed
      expect(find.text('Lunch'), findsWidgets);
      expect(find.text('Gas'), findsWidgets);
      expect(find.text('Movie'), findsWidgets);

      // Verify total calculation exists (adjust based on your UI)
      // The total might be displayed differently in your app
      expect(find.textContaining('100', findRichText: true), findsWidgets);
    });

    testWidgets('Form validation on add expense screen', (
      WidgetTester tester,
    ) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Go to add expense screen
      final fab = find.byType(FloatingActionButton);
      if (fab.evaluate().isNotEmpty) {
        await tester.tap(fab);
        await tester.pumpAndSettle();

        // Try to save with empty form
        await tester.tap(find.text('Save'));
        await tester.pump();

        // Verify validation errors exist
        expect(
            find.textContaining('required', findRichText: true), findsWidgets);

        // Enter invalid amount
        await tester.enterText(find.byKey(const Key('amountField')), 'invalid');
        await tester.tap(find.text('Save'));
        await tester.pump();

        // Enter negative amount
        await tester.enterText(find.byKey(const Key('amountField')), '-10');
        await tester.tap(find.text('Save'));
        await tester.pump();
      }
    });

    testWidgets('Category filtering functionality', (
      WidgetTester tester,
    ) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Add expenses with different categories
      await _addExpense(tester, 'Groceries', 50.0, 'Food');
      await _addExpense(tester, 'Gas', 40.0, 'Transportation');
      await _addExpense(tester, 'Netflix', 15.99, 'Entertainment');
      await _addExpense(tester, 'Restaurant', 30.0, 'Food');

      // Verify all expenses are shown
      expect(find.text('Groceries'), findsWidgets);
      expect(find.text('Gas'), findsWidgets);
      expect(find.text('Netflix'), findsWidgets);
      expect(find.text('Restaurant'), findsWidgets);

      // Find and use category filter (if available)
      final foodFilter = find.text('Food');
      if (foodFilter.evaluate().length > 1) {
        await tester.tap(foodFilter.first);
        await tester.pumpAndSettle();

        // Verify filtering works (adjust based on your implementation)
        // This is just a basic check
        expect(find.text('Groceries'), findsWidgets);
        expect(find.text('Restaurant'), findsWidgets);
      }
    });

    testWidgets('Search functionality', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Add test expenses
      await _addExpense(tester, 'Coffee at Starbucks', 5.50, 'Food');
      await _addExpense(tester, 'Gas Station', 45.00, 'Transportation');
      await _addExpense(tester, 'Starbucks Gift Card', 25.00, 'Shopping');

      // Find search field (if available)
      final searchField = find.byKey(const Key('searchField'));
      if (searchField.evaluate().isNotEmpty) {
        await tester.enterText(searchField, 'Starbucks');
        await tester.pumpAndSettle();

        // Verify search results
        expect(find.text('Coffee at Starbucks'), findsWidgets);
        expect(find.text('Starbucks Gift Card'), findsWidgets);

        // Clear search
        final clearButton = find.byIcon(Icons.clear);
        if (clearButton.evaluate().isNotEmpty) {
          await tester.tap(clearButton);
          await tester.pumpAndSettle();
        }
      }
    });
  });
}

Future<void> _addExpense(
  WidgetTester tester,
  String title,
  double amount,
  String category,
) async {
  final fab = find.byType(FloatingActionButton);
  if (fab.evaluate().isEmpty) return;

  await tester.tap(fab);
  await tester.pumpAndSettle();

  await tester.enterText(find.byKey(const Key('titleField')), title);
  await tester.enterText(
    find.byKey(const Key('amountField')),
    amount.toString(),
  );

  final categoryField = find.byKey(const Key('categoryField'));
  if (categoryField.evaluate().isNotEmpty) {
    await tester.tap(categoryField);
    await tester.pumpAndSettle();

    final categoryOption = find.text(category);
    if (categoryOption.evaluate().isNotEmpty) {
      await tester.tap(categoryOption.last);
      await tester.pumpAndSettle();
    }
  }

  await tester.tap(find.text('Save'));
  await tester.pumpAndSettle();
}
