import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../presentation/providers/auth_provider.dart';
import '../../domain/entities/expense.dart';
import '../../services/analytics_service.dart';
import '../../services/di_locator.dart';
import '../../presentation/providers/expense_provider.dart';

class TestFirebaseScreen extends StatefulWidget {
  const TestFirebaseScreen({super.key});

  @override
  State<TestFirebaseScreen> createState() => _TestFirebaseScreenState();
}

class _TestFirebaseScreenState extends State<TestFirebaseScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _isLoading = false;
  String _testResult = '';
  final List<String> _logs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Integration Test'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Firebase Integration Test',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'This screen tests all Firebase services:\n'
                      '• Authentication (sign-in/sign-up)\n'
                      '• Firestore (expense data storage)\n'
                      '• Analytics (event tracking)',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Auth Tests
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Authentication Tests',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),

                    // Email input
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 8),

                    // Password input
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 8),

                    // Name input (for registration)
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name (for registration)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Sign In button
                    ElevatedButton(
                      onPressed: _isLoading ? null : _testSignIn,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Test Sign In'),
                    ),
                    const SizedBox(height: 8),

                    // Sign Up button
                    ElevatedButton(
                      onPressed: _isLoading ? null : _testSignUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Test Sign Up'),
                    ),
                    const SizedBox(height: 8),

                    // Sign Out button
                    ElevatedButton(
                      onPressed: _isLoading ? null : _testSignOut,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Test Sign Out'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Firestore Tests
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Firestore Tests',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),

                    // Amount input
                    TextField(
                      controller: _amountController,
                      decoration: const InputDecoration(
                        labelText: 'Amount',
                        hintText: 'Enter expense amount (e.g., 25.99)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                    ),
                    const SizedBox(height: 8),

                    // Description input
                    TextField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        hintText: 'Enter expense description',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),

                    ElevatedButton(
                      onPressed: _isLoading ? null : _testFirestore,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Test Firestore (Create Expense)'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Analytics Test
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Analytics Tests',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _testAnalytics,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Test Analytics Event'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Current User Info
            Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                return Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Current User Status',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text('Status: ${authProvider.status.name}'),
                        if (authProvider.currentUser != null) ...[
                          const SizedBox(height: 8),
                          Text('Email: ${authProvider.currentUser?.email}'),
                          Text('Name: ${authProvider.currentUser?.name}'),
                          Text('ID: ${authProvider.currentUser?.id}'),
                        ] else ...[
                          const SizedBox(height: 8),
                          const Text('No user signed in'),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // Test Results
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Test Results',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    if (_isLoading)
                      const LinearProgressIndicator()
                    else
                      const Text('Ready to test'),
                    const SizedBox(height: 8),
                    Text(
                        _testResult.isEmpty ? 'No tests run yet' : _testResult),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Logs
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Logs',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: _logs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Text(
                              _logs[index],
                              style: const TextStyle(fontSize: 12),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _log(String message) {
    setState(() {
      _logs.insert(0, '[${DateTime.now().toString()}] $message');
      if (_logs.length > 20) {
        _logs.removeLast(); // Keep only last 20 logs
      }
    });
  }

  void _showResult(String result) {
    setState(() {
      _testResult = result;
    });
  }

  Future<void> _testSignIn() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showResult('Please enter email and password');
      _log('ERROR: Missing email or password for sign in');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      _log('Attempting sign in with email: ${_emailController.text}');

      final result = await authProvider.login(
          email: _emailController.text.trim(),
          password: _passwordController.text);

      if (result) {
        _showResult('✅ Sign in successful!');
        _log('SUCCESS: User signed in successfully');

        // Test analytics event
        await getIt<AnalyticsService>().logLogin(loginMethod: 'email');
        _log('SUCCESS: Analytics login event logged');
      } else {
        _showResult('❌ Sign in failed');
        _log('ERROR: Sign in failed');
      }
    } catch (e) {
      _showResult('❌ Sign in error: ${e.runtimeType}');
      _log('ERROR: Sign in failed with error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _testSignUp() async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _nameController.text.isEmpty) {
      _showResult('Please enter email, password, and name');
      _log('ERROR: Missing required fields for sign up');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      _log('Attempting sign up with email: ${_emailController.text}');

      final result = await authProvider.register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (result) {
        _showResult('✅ Sign up successful!');
        _log('SUCCESS: User registered successfully');

        // Test analytics event
        await getIt<AnalyticsService>().logSignUp(signUpMethod: 'email');
        _log('SUCCESS: Analytics sign up event logged');
      } else {
        _showResult('❌ Sign up failed');
        _log('ERROR: Sign up failed');
      }
    } catch (e) {
      _showResult('❌ Sign up error: ${e.runtimeType}');
      _log('ERROR: Sign up failed with error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _testSignOut() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      _log('Attempting sign out');

      await authProvider.logout();

      _showResult('✅ Sign out successful!');
      _log('SUCCESS: User signed out successfully');
    } catch (e) {
      _showResult('❌ Sign out error: ${e.runtimeType}');
      _log('ERROR: Sign out failed with error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _testFirestore() async {
    if (_amountController.text.isEmpty || _descriptionController.text.isEmpty) {
      _showResult('Please enter amount and description');
      _log('ERROR: Missing amount or description for expense');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      if (authProvider.currentUser == null) {
        _showResult('❌ Please sign in first to test Firestore');
        _log('ERROR: User not authenticated for Firestore test');
        setState(() {
          _isLoading = false;
        });
        return;
      }

      _log('Attempting to create expense in Firestore');

      // Parse amount
      final amount = double.tryParse(_amountController.text);
      if (amount == null) {
        _showResult('❌ Invalid amount entered');
        _log('ERROR: Invalid amount format');
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Create expense entity
      final expense = Expense(
        id: '', // Will be auto-generated
        title: 'Test Expense',
        amount: amount,
        categoryId: 'test_category',
        date: DateTime.now(),
        description: _descriptionController.text.trim(),
        type: ExpenseType.expense,
        userId: authProvider.currentUser!.id,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Add to provider (which should sync to Firestore)
      final expenseProvider = getIt.get<ExpenseProvider>();
      await expenseProvider.createExpense(expense);

      _showResult('✅ Expense created and stored in Firestore!');
      _log('SUCCESS: Expense created and saved to Firestore');
    } catch (e) {
      _showResult('❌ Firestore test error: ${e.runtimeType}');
      _log('ERROR: Firestore test failed with error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _testAnalytics() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _log('Testing analytics event logging');

      final analyticsService = getIt<AnalyticsService>();

      // Log a custom event
      await analyticsService.logEvent(
        name: 'firebase_test_event',
        parameters: {
          'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          'test_type': 'integration_test',
        },
      );

      // Log screen view
      await analyticsService.logScreenView(
        screenName: 'TestFirebaseScreen',
      );

      _showResult('✅ Analytics events logged successfully!');
      _log('SUCCESS: Analytics events logged');
    } catch (e) {
      _showResult('❌ Analytics test error: ${e.runtimeType}');
      _log('ERROR: Analytics test failed with error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
