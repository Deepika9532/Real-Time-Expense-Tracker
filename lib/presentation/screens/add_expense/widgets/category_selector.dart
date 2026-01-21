import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/category_provider.dart';
import '../../../../domain/entities/expense.dart';
import '../../../../domain/entities/category.dart';

class CategorySelector extends StatelessWidget {
  final String? selectedCategoryId;
  final ExpenseType expenseType;
  final Function(String) onCategorySelected;

  const CategorySelector({
    super.key,
    required this.selectedCategoryId,
    required this.expenseType,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) {
        final categories = expenseType == ExpenseType.expense
            ? categoryProvider.expenseCategories
            : categoryProvider.incomeCategories;

        final selectedCategory = selectedCategoryId != null
            ? categories.firstWhere(
                (c) => c.id == selectedCategoryId,
                orElse: () => categories.first,
              )
            : null;

        return InkWell(
          onTap: () => _showCategoryPicker(context, categories),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: 'Category',
              prefixIcon: selectedCategory != null
                  ? Icon(
                      _getIconData(selectedCategory.icon),
                      color: Color(selectedCategory.color),
                    )
                  : const Icon(Icons.category),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedCategory?.name ?? 'Select category',
                  style: TextStyle(
                    color: selectedCategory != null
                        ? Theme.of(context).textTheme.bodyLarge?.color
                        : Theme.of(context).hintColor,
                  ),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCategoryPicker(BuildContext context, List<Category> categories) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Select Category',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const Divider(height: 1),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = category.id == selectedCategoryId;

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(category.color).withOpacity(0.2),
                      child: Icon(
                        _getIconData(category.icon),
                        color: Color(category.color),
                      ),
                    ),
                    title: Text(category.name),
                    trailing: isSelected
                        ? Icon(
                            Icons.check_circle,
                            color: Theme.of(context).colorScheme.primary,
                          )
                        : null,
                    onTap: () {
                      onCategorySelected(category.id);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  // Navigate to create category screen
                },
                icon: const Icon(Icons.add),
                label: const Text('Add New Category'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    final iconMap = {
      'shopping_bag': Icons.shopping_bag,
      'restaurant': Icons.restaurant,
      'local_gas_station': Icons.local_gas_station,
      'home': Icons.home,
      'health_and_safety': Icons.health_and_safety,
      'school': Icons.school,
      'attach_money': Icons.attach_money,
      'card_giftcard': Icons.card_giftcard,
      'category': Icons.category,
    };

    return iconMap[iconName] ?? Icons.category;
  }
}
