import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:real_time_expense_tracker/app.dart';

void main() {
  testWidgets('App starts and renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app initializes
    // Note: Adjust these expectations based on your actual app's initial screen
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('Example test - demonstrates basic widget testing', (
    WidgetTester tester,
  ) async {
    // Example: Testing a simple stateful counter widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: TestCounterWidget(),
        ),
      ),
    );

    // Verify initial state
    expect(find.text('Counter: 0'), findsOneWidget);
    expect(find.text('Counter: 1'), findsNothing);

    // Tap the button
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify counter incremented
    expect(find.text('Counter: 0'), findsNothing);
    expect(find.text('Counter: 1'), findsOneWidget);
  });
}

// Simple test widget to demonstrate testing patterns
class TestCounterWidget extends StatefulWidget {
  const TestCounterWidget({super.key});

  @override
  State<TestCounterWidget> createState() => _TestCounterWidgetState();
}

class _TestCounterWidgetState extends State<TestCounterWidget> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Counter: $counter'),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                counter++;
              });
            },
          ),
        ],
      ),
    );
  }
}
