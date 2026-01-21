import 'package:flutter/material.dart';

import '../../../../domain/entities/category.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onToggle;
  final VoidCallback? onDelete;

  const CategoryItem({
    super.key,
    required this.category,
    this.onTap,
    this.onEdit,
    this.onToggle,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: category.isActive ? 2 : 1,
      color: category.isActive ? null : Colors.grey[100],
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Drag Handle
              ReorderableDragStartListener(
                index: 0,
                child: Icon(Icons.drag_handle, color: Colors.grey[400]),
              ),
              const SizedBox(width: 12),

              // Category Icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Color(category.color).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getIconData(category.icon),
                  color: Color(category.color),
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),

              // Category Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            category.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: category.isActive
                                      ? null
                                      : Colors.grey[600],
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (category.isDefault)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Default',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.blue[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    if (category.description != null &&
                        category.description!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        category.description!,
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getTypeColor(
                              category.type,
                            ).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            _getTypeText(category.type),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: _getTypeColor(category.type),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          category.isActive ? Icons.check_circle : Icons.cancel,
                          size: 16,
                          color: category.isActive ? Colors.green : Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          category.isActive ? 'Active' : 'Inactive',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Actions Menu
              PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 12),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'toggle',
                    child: Row(
                      children: [
                        Icon(
                          category.isActive
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        const SizedBox(width: 12),
                        Text(category.isActive ? 'Deactivate' : 'Activate'),
                      ],
                    ),
                  ),
                  if (!category.isDefault)
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 12),
                          Text('Delete', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                ],
                onSelected: (value) {
                  if (value == 'edit' && onEdit != null) {
                    onEdit!();
                  } else if (value == 'toggle' && onToggle != null) {
                    onToggle!();
                  } else if (value == 'delete' && onDelete != null) {
                    onDelete!();
                  }
                },
              ),
            ],
          ),
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
      'directions_car': Icons.directions_car,
      'phone': Icons.phone,
      'sports_esports': Icons.sports_esports,
      'flight': Icons.flight,
      'shopping_cart': Icons.shopping_cart,
      'local_hospital': Icons.local_hospital,
      'fitness_center': Icons.fitness_center,
      'pets': Icons.pets,
      'music_note': Icons.music_note,
      'movie': Icons.movie,
      'work': Icons.work,
      'savings': Icons.savings,
      'business': Icons.business,
    };

    return iconMap[iconName] ?? Icons.category;
  }

  Color _getTypeColor(CategoryType type) {
    switch (type) {
      case CategoryType.expense:
        return Colors.red;
      case CategoryType.income:
        return Colors.green;
      case CategoryType.both:
        return Colors.blue;
    }
  }

  String _getTypeText(CategoryType type) {
    switch (type) {
      case CategoryType.expense:
        return 'Expense';
      case CategoryType.income:
        return 'Income';
      case CategoryType.both:
        return 'Both';
    }
  }
}
