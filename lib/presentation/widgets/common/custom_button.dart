import 'package:flutter/material.dart';
import 'package:real_time_expense_tracker/core/theme/text_styles.dart';

enum ButtonType { primary, secondary, outlined, danger, success }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;
  final bool isLoading;
  final bool isDisabled;
  final IconData? icon;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    this.borderRadius = 12,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Color backgroundColor;
    Color textColor;
    Color borderColor;
    Color disabledColor;

    switch (type) {
      case ButtonType.primary:
        backgroundColor = colorScheme.primary;
        textColor = colorScheme.onPrimary;
        borderColor = colorScheme.primary;
        // ignore: deprecated_member_use
        disabledColor = colorScheme.primary.withOpacity(0.5);
        break;
      case ButtonType.secondary:
        backgroundColor = colorScheme.secondaryContainer;
        textColor = colorScheme.onSecondaryContainer;
        borderColor = colorScheme.secondaryContainer;
        // ignore: deprecated_member_use
        disabledColor = colorScheme.secondaryContainer.withOpacity(0.5);
        break;
      case ButtonType.outlined:
        backgroundColor = Colors.transparent;
        textColor = colorScheme.onSurface;
        borderColor = colorScheme.outline;
        // ignore: deprecated_member_use
        disabledColor = colorScheme.surface.withOpacity(0.5);
        break;
      case ButtonType.danger:
        backgroundColor = colorScheme.errorContainer;
        textColor = colorScheme.onErrorContainer;
        borderColor = colorScheme.errorContainer;
        // ignore: deprecated_member_use
        disabledColor = colorScheme.errorContainer.withOpacity(0.5);
        break;
      case ButtonType.success:
        backgroundColor = Colors.green;
        textColor = Colors.white;
        borderColor = Colors.green;
        // ignore: deprecated_member_use
        disabledColor = Colors.green.withOpacity(0.5);
        break;
    }

    final buttonColor = isDisabled ? disabledColor : backgroundColor;
    // ignore: deprecated_member_use
    final buttonTextColor = isDisabled ? textColor.withOpacity(0.5) : textColor;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isDisabled || isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              type == ButtonType.outlined ? Colors.transparent : buttonColor,
          foregroundColor: buttonTextColor,
          disabledBackgroundColor: disabledColor,
          // ignore: deprecated_member_use
          disabledForegroundColor: textColor.withOpacity(0.5),
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              color: type == ButtonType.outlined
                  ? borderColor
                  : Colors.transparent,
              width: 1.5,
            ),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(buttonTextColor),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 18),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: TextStyles.button.copyWith(color: buttonTextColor),
                  ),
                ],
              ),
      ),
    );
  }
}
