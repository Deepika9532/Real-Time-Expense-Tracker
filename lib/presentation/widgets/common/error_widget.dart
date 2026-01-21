import 'package:flutter/material.dart';
import 'package:real_time_expense_tracker/core/theme/text_styles.dart';

class ErrorWidget extends StatelessWidget {
  final String errorMessage;
  final String? buttonText;
  final VoidCallback? onRetry;
  final IconData? icon;

  const ErrorWidget({
    super.key,
    required this.errorMessage,
    this.buttonText = 'Try Again',
    this.onRetry,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon ?? Icons.error_outline,
              size: 64,
              // ignore: deprecated_member_use
              color: colorScheme.error.withOpacity(0.7),
            ),
            const SizedBox(height: 20),
            Text(
              'Oops!',
              style: TextStyles.headlineSmall.copyWith(
                color: colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              errorMessage,
              style: TextStyles.bodyMedium.copyWith(
                // ignore: deprecated_member_use
                color: colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.errorContainer,
                  foregroundColor: colorScheme.onErrorContainer,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(buttonText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class CustomErrorWidget extends StatelessWidget {
  final String title;
  final String message;
  final Widget? actionButton;
  final Widget? illustration;

  const CustomErrorWidget({
    super.key,
    this.title = 'Something went wrong',
    required this.message,
    this.actionButton,
    this.illustration,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (illustration != null) ...[
              illustration!,
              const SizedBox(height: 24),
            ] else
              Icon(
                Icons.sentiment_dissatisfied_outlined,
                size: 80,
                // ignore: deprecated_member_use
                color: colorScheme.onSurface.withOpacity(0.3),
              ),
            const SizedBox(height: 20),
            Text(
              title,
              style: TextStyles.headlineSmall.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: TextStyles.bodyMedium.copyWith(
                // ignore: deprecated_member_use
                color: colorScheme.onSurface.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
            if (actionButton != null) ...[
              const SizedBox(height: 24),
              actionButton!,
            ],
          ],
        ),
      ),
    );
  }
}
