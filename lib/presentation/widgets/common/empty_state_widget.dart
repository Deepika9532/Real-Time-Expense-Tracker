// lib/presentation/widgets/common/empty_state_widget.dart

import 'package:flutter/material.dart';

import '../../../core/theme/text_styles.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String message;

  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyles.headlineSmall),
          const SizedBox(height: 8),
          Text(message, style: TextStyles.bodyMedium),
        ],
      ),
    );
  }
}
