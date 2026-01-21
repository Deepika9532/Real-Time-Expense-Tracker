import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import 'text_styles.dart';

class AppTheme {
  // =====================
  // Light Theme
  // =====================
  static ThemeData get lightTheme {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: ColorConstants.primaryColor,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'Inter',
      colorScheme: colorScheme,
      primaryColor: ColorConstants.primaryColor,
      scaffoldBackgroundColor: ColorConstants.backgroundColor,

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: ColorConstants.textWhiteColor,
        elevation: 0,
        centerTitle: true,
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: ColorConstants.textWhiteColor,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // Inputs
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        border: _inputBorder(ColorConstants.greyLight),
        enabledBorder: _inputBorder(ColorConstants.greyLight),
        focusedBorder: _inputBorder(
          colorScheme.primary,
          width: 2,
        ),
        errorBorder: _inputBorder(ColorConstants.errorColor),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),

      // Cards
      cardTheme: CardThemeData(
        elevation: 2,
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // Dividers
      dividerTheme: DividerThemeData(
        color: ColorConstants.greyLight,
        thickness: 1,
      ),

      // Typography
      textTheme: ThemeData.light().textTheme.copyWith(
            headlineLarge: TextStyles.headlineLarge,
            headlineMedium: TextStyles.headlineMedium,
            headlineSmall: TextStyles.headlineSmall,
            titleLarge: TextStyles.titleLarge,
            titleMedium: TextStyles.titleMedium,
            titleSmall: TextStyles.titleSmall,
            bodyLarge: TextStyles.bodyLarge,
            bodyMedium: TextStyles.bodyMedium,
            bodySmall: TextStyles.bodySmall,
            labelLarge: TextStyles.labelLarge,
            labelMedium: TextStyles.labelMedium,
            labelSmall: TextStyles.labelSmall,
          ),
    );
  }

  // =====================
  // Dark Theme
  // =====================
  static ThemeData get darkTheme {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: ColorConstants.primaryLightColor,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'Inter',
      colorScheme: colorScheme,
      primaryColor: ColorConstants.primaryLightColor,
      scaffoldBackgroundColor: ColorConstants.backgroundDarkColor,

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: ColorConstants.textWhiteColor,
        elevation: 0,
        centerTitle: true,
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: ColorConstants.textPrimaryColor,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // Inputs
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        border: _inputBorder(ColorConstants.greyDark),
        enabledBorder: _inputBorder(ColorConstants.greyDark),
        focusedBorder: _inputBorder(
          colorScheme.primary,
          width: 2,
        ),
        errorBorder: _inputBorder(ColorConstants.errorColor),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),

      // Cards
      cardTheme: CardThemeData(
        elevation: 2,
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // Dividers
      dividerTheme: DividerThemeData(
        color: ColorConstants.greyDark,
        thickness: 1,
      ),

      // Typography
      textTheme: ThemeData.dark().textTheme.copyWith(
            headlineLarge:
                TextStyles.headlineLarge.copyWith(color: Colors.white),
            headlineMedium:
                TextStyles.headlineMedium.copyWith(color: Colors.white),
            headlineSmall:
                TextStyles.headlineSmall.copyWith(color: Colors.white),
            titleLarge: TextStyles.titleLarge.copyWith(color: Colors.white),
            titleMedium: TextStyles.titleMedium.copyWith(color: Colors.white),
            titleSmall: TextStyles.titleSmall.copyWith(color: Colors.white),
            bodyLarge: TextStyles.bodyLarge.copyWith(color: Colors.white70),
            bodyMedium: TextStyles.bodyMedium.copyWith(color: Colors.white70),
            bodySmall: TextStyles.bodySmall.copyWith(color: Colors.white60),
            labelLarge: TextStyles.labelLarge.copyWith(color: Colors.white),
            labelMedium: TextStyles.labelMedium.copyWith(color: Colors.white),
            labelSmall: TextStyles.labelSmall.copyWith(color: Colors.white),
          ),
    );
  }

  // =====================
  // Helper Method
  // =====================
  static OutlineInputBorder _inputBorder(
    Color color, {
    double width = 1,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }
}
