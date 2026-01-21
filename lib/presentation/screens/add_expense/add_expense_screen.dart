import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/validators.dart';
import '../../../domain/entities/expense.dart';
import '../../providers/expense_provider.dart';
import 'widgets/amount_input.dart';
import 'widgets/category_selector.dart';

class AddExpenseScreen extends StatefulWidget {
  final Expense? expense;

  const AddExpenseScreen({super.key, this.expense});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedCategoryId;
  ExpenseType _expenseType = ExpenseType.expense;
  DateTime _selectedDate = DateTime.now();
  String? _paymentMethod;
  bool _isLoading = false;

  final List<String> _paymentMethods = [
    'Cash',
    'Credit Card',
    'Debit Card',
    'UPI',
    'Net Banking',
    'Wallet',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.expense != null) {
      _loadExpenseData();
    }
  }

  void _loadExpenseData() {
    final expense = widget.expense!;
    _titleController.text = expense.title;
    _amountController.text = expense.amount.toString();
    _descriptionController.text = expense.description ?? '';
    _selectedCategoryId = expense.categoryId;
    _expenseType = expense.type;
    _selectedDate = expense.date;
    _paymentMethod = expense.paymentMethod;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedCategoryId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a category')));
      return;
    }

    setState(() => _isLoading = true);

    final expense = Expense(
      id: widget.expense?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      amount: double.parse(_amountController.text),
      categoryId: _selectedCategoryId!,
      date: _selectedDate,
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      type: _expenseType,
      paymentMethod: _paymentMethod,
    );

    final expenseProvider = context.read<ExpenseProvider>();

    bool success;
    if (widget.expense == null) {
      success = await expenseProvider.createExpense(expense);
    } else {
      success = await expenseProvider.updateExpense(expense);
    }

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (success) {
      Navigator.of(context).pop(true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.expense == null
                ? 'Expense added successfully'
                : 'Expense updated successfully',
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            expenseProvider.errorMessage ?? 'Failed to save expense',
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.expense == null ? 'Add Expense' : 'Edit Expense'),
        actions: [
          if (widget.expense != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                // Show delete confirmation
              },
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Type Selector
            SegmentedButton<ExpenseType>(
              segments: const [
                ButtonSegment(
                  value: ExpenseType.expense,
                  label: Text('Expense'),
                  icon: Icon(Icons.trending_down),
                ),
                ButtonSegment(
                  value: ExpenseType.income,
                  label: Text('Income'),
                  icon: Icon(Icons.trending_up),
                ),
              ],
              selected: {_expenseType},
              onSelectionChanged: (Set<ExpenseType> selection) {
                setState(() {
                  _expenseType = selection.first;
                  _selectedCategoryId = null;
                });
              },
            ),
            const SizedBox(height: 24),

            // Amount Input
            AmountInput(controller: _amountController, type: _expenseType),
            const SizedBox(height: 24),

            // Title Field
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'Enter title',
                prefixIcon: Icon(Icons.title),
              ),
              validator: (value) =>
                  Validators.validateRequired(value, fieldName: 'Title'),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),

            // Category Selector
            CategorySelector(
              selectedCategoryId: _selectedCategoryId,
              expenseType: _expenseType,
              onCategorySelected: (categoryId) {
                setState(() => _selectedCategoryId = categoryId);
              },
            ),
            const SizedBox(height: 16),

            // Date Selector
            InkWell(
              onTap: _selectDate,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Date',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(
                  '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Payment Method
            DropdownButtonFormField<String>(
              value: _paymentMethod,
              decoration: const InputDecoration(
                labelText: 'Payment Method',
                prefixIcon: Icon(Icons.payment),
              ),
              items: _paymentMethods.map((method) {
                return DropdownMenuItem(value: method, child: Text(method));
              }).toList(),
              onChanged: (value) {
                setState(() => _paymentMethod = value);
              },
            ),
            const SizedBox(height: 16),

            // Description Field
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (Optional)',
                hintText: 'Add notes',
                prefixIcon: Icon(Icons.notes),
              ),
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 32),

            // Save Button
            ElevatedButton(
              onPressed: _isLoading ? null : _handleSave,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
                      widget.expense == null ? 'Add Expense' : 'Update Expense',
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
