// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:real_time_expense_tracker/core/theme/text_styles.dart';
import 'package:real_time_expense_tracker/core/utils/validators.dart';

enum TextFieldType {
  text,
  email,
  password,
  number,
  phone,
  currency,
  multiline,
  date,
}

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String labelText;
  final String? hintText;
  final String? errorText;
  final TextFieldType type;
  final bool isRequired;
  final bool isEnabled;
  final bool autofocus;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputAction textInputAction;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? prefixText;
  final String? suffixText;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    this.controller,
    required this.labelText,
    this.hintText,
    this.errorText,
    this.type = TextFieldType.text,
    this.isRequired = false,
    this.isEnabled = true,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.suffixText,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.focusNode,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = true;
  late TextInputType _keyboardType;
  late List<TextInputFormatter> _inputFormatters;

  @override
  void initState() {
    super.initState();
    _setKeyboardType();
    _setInputFormatters();
  }

  void _setKeyboardType() {
    switch (widget.type) {
      case TextFieldType.email:
        _keyboardType = TextInputType.emailAddress;
        break;
      case TextFieldType.number:
      case TextFieldType.currency:
        _keyboardType = TextInputType.numberWithOptions(decimal: true);
        break;
      case TextFieldType.phone:
        _keyboardType = TextInputType.phone;
        break;
      case TextFieldType.multiline:
        _keyboardType = TextInputType.multiline;
        break;
      default:
        _keyboardType = TextInputType.text;
    }
  }

  void _setInputFormatters() {
    _inputFormatters = widget.inputFormatters ?? [];

    switch (widget.type) {
      case TextFieldType.currency:
        _inputFormatters.add(
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
        );
        break;
      case TextFieldType.number:
        _inputFormatters.add(FilteringTextInputFormatter.digitsOnly);
        break;
      default:
        break;
    }

    if (widget.maxLength != null) {
      _inputFormatters.add(LengthLimitingTextInputFormatter(widget.maxLength));
    }
  }

  String? _validator(String? value) {
    if (widget.isRequired && (value == null || value.isEmpty)) {
      return '${widget.labelText} is required';
    }

    if (value == null || value.isEmpty) return null;

    switch (widget.type) {
      case TextFieldType.email:
        if (!Validators.isValidEmail(value)) {
          return 'Please enter a valid email';
        }
        break;
      case TextFieldType.password:
        if (!Validators.isValidPassword(value)) {
          return 'Password must be at least 6 characters';
        }
        break;
      case TextFieldType.phone:
        if (!Validators.isValidPhone(value)) {
          return 'Please enter a valid phone number';
        }
        break;
      default:
        break;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isError = widget.errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: TextStyles.caption.copyWith(
            color: colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          keyboardType: _keyboardType,
          textInputAction: widget.textInputAction,
          maxLines: widget.maxLines,
          minLines: widget.minLines ?? widget.maxLines,
          obscureText: widget.type == TextFieldType.password && _isObscured,
          enabled: widget.isEnabled,
          autofocus: widget.autofocus,
          textCapitalization: widget.textCapitalization,
          inputFormatters: _inputFormatters,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyles.bodyMedium.copyWith(
              // ignore: duplicate_ignore
              // ignore: deprecated_member_use
              color: colorScheme.onSurface.withOpacity(0.5),
            ),
            filled: true,
            fillColor: widget.isEnabled
                ? colorScheme.surface
                // ignore: duplicate_ignore
                // ignore: deprecated_member_use
                : colorScheme.surfaceContainerHighest.withOpacity(0.3),
            prefixIcon: widget.prefixIcon,
            prefixText: widget.prefixText,
            suffixIcon: widget.type == TextFieldType.password
                ? IconButton(
                    icon: Icon(
                      _isObscured ? Icons.visibility : Icons.visibility_off,
                      // ignore: duplicate_ignore
                      // ignore: deprecated_member_use
                      color: colorScheme.onSurface.withOpacity(0.5),
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                  )
                : widget.suffixIcon,
            suffixText: widget.suffixText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.outline, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isError ? colorScheme.error : colorScheme.outline,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isError ? colorScheme.error : colorScheme.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.error, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            errorText: widget.errorText,
          ),
          style: TextStyles.bodyMedium.copyWith(color: colorScheme.onSurface),
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          onTap: widget.onTap,
          validator: _validator,
        ),
      ],
    );
  }
}
