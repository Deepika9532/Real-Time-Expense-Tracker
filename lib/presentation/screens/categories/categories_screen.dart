import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/category_provider.dart';
import '../../../../domain/entities/category.dart';
import 'widgets/category_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryProvider>().loadCategories(refresh: true);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Expenses', icon: Icon(Icons.trending_down)),
            Tab(text: 'Income', icon: Icon(Icons.trending_up)),
          ],
        ),
        actions: [
          Consumer<CategoryProvider>(
            builder: (context, provider, child) {
              return IconButton(
                icon: Icon(
                  provider.showInactiveCategories
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: provider.toggleShowInactiveCategories,
                tooltip: provider.showInactiveCategories
                    ? 'Hide inactive'
                    : 'Show inactive',
              );
            },
          ),
        ],
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, categoryProvider, child) {
          if (categoryProvider.isLoading &&
              categoryProvider.categories.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (categoryProvider.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    categoryProvider.errorMessage ?? 'An error occurred',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        categoryProvider.loadCategories(refresh: true),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return TabBarView(
            controller: _tabController,
            children: [
              _buildCategoryList(categoryProvider, CategoryType.expense),
              _buildCategoryList(categoryProvider, CategoryType.income),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to add category screen
        },
        icon: const Icon(Icons.add),
        label: const Text('New Category'),
      ),
    );
  }

  Widget _buildCategoryList(CategoryProvider provider, CategoryType type) {
    final categories = type == CategoryType.expense
        ? provider.expenseCategories
        : provider.incomeCategories;

    if (categories.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.category_outlined, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No ${type == CategoryType.expense ? 'expense' : 'income'} categories',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Create a category to get started',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to add category screen
              },
              icon: const Icon(Icons.add),
              label: const Text('Create Category'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => provider.loadCategories(refresh: true),
      child: ReorderableListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        onReorder: (oldIndex, newIndex) async {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final items = List<Category>.from(categories);
          final item = items.removeAt(oldIndex);
          items.insert(newIndex, item);
          await provider.reorderCategories(items);
        },
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            key: ValueKey(category.id),
            padding: const EdgeInsets.only(bottom: 12),
            child: CategoryItem(
              category: category,
              onTap: () {
                // Navigate to category details
              },
              onEdit: () {
                // Navigate to edit category
              },
              onToggle: () async {
                await provider.toggleCategoryStatus(category.id);
              },
              onDelete: () async {
                final confirmed = await _showDeleteConfirmation(
                  context,
                  category.name,
                );
                if (confirmed == true) {
                  await provider.deleteCategory(category.id);
                }
              },
            ),
          );
        },
      ),
    );
  }

  Future<bool?> _showDeleteConfirmation(
    BuildContext context,
    String categoryName,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Category'),
        content: Text(
          'Are you sure you want to delete "$categoryName"?\n\nThis action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
