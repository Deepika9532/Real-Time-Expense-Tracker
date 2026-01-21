import 'package:flutter/material.dart';

/// Constants for all colors used in the application
/// Provides consistent color palette across the entire expense tracker app
class ColorConstants {
  // Brand Colors - Primary brand identity
  static const Color primaryColor = Color(0xFF4361ee); // Modern blue
  static const Color primaryLightColor = Color(0xFF4cc9f0); // Light blue
  static const Color primaryDarkColor = Color(0xFF3a0ca3); // Dark blue

  static const Color secondaryColor = Color(0xFF4cc9f0); // Complementary blue
  static const Color secondaryLightColor = Color(0xFF80ffdb); // Light teal
  static const Color secondaryDarkColor = Color(0xFF4895ef); // Medium blue

  // Financial Colors - Used for financial indicators
  static const Color expenseColor = Color(0xFFf72585); // Pink-red for expenses
  static const Color incomeColor = Color(0xFF2ec4b6); // Teal for income
  static const Color balancePositiveColor = Color(
    0xFF06d6a0,
  ); // Green for positive balance
  static const Color balanceNegativeColor = Color(
    0xFFef476f,
  ); // Red for negative balance

  // Expense Category Colors - Color coding for different expense types
  static const Color foodColor = Color(0xFFff9e00); // Orange for food
  static const Color transportationColor = Color(
    0xFF7209b7,
  ); // Purple for transportation
  static const Color entertainmentColor = Color(
    0xFFf15bb5,
  ); // Magenta for entertainment
  static const Color shoppingColor = Color(0xFFfee440); // Yellow for shopping
  static const Color healthColor = Color(0xFF00bbf9); // Blue for health
  static const Color housingColor = Color(0xFF00f5d4); // Mint for housing
  static const Color utilitiesColor = Color(0xFF9b5de5); // Purple for utilities
  static const Color travelColor = Color(0xFFf8961e); // Amber for travel
  static const Color educationColor = Color(0xFF43aa8b); // Green for education
  static const Color otherColor = Color(0xFF90e0ef); // Light blue for other

  // Background Colors - For different surfaces and backgrounds
  static const Color backgroundColor = Color(0xFFFFFFFF); // White background
  static const Color backgroundDarkColor = Color(
    0xFF121212,
  ); // Dark mode background
  static const Color surfaceColor = Color(0xFFF8F9FA); // Light surface
  static const Color surfaceDarkColor = Color(0xFF1E1E1E); // Dark surface
  static const Color cardColor = Color(0xFFFFFFFF); // Card background
  static const Color cardDarkColor = Color(0xFF2D2D2D); // Dark card background

  // Text Colors - For different text elements
  static const Color textPrimaryColor = Color(0xFF212121); // Dark primary text
  static const Color textSecondaryColor = Color(
    0xFF757575,
  ); // Medium emphasis text
  static const Color textDisabledColor = Color(0xFFBDBDBD); // Disabled text
  static const Color textWhiteColor = Color(0xFFFFFFFF); // White text
  static const Color textHintColor = Color(0xFF9E9E9E); // Hint text

  // Status Colors - For different states and notifications
  static const Color successColor = Color(0xFF06d6a0); // Success green
  static const Color errorColor = Color(0xFFef476f); // Error red
  static const Color warningColor = Color(0xFFFF9800); // Warning orange
  static const Color infoColor = Color(0xFF4361ee); // Info blue

  // Neutral Colors - For general use
  static const Color greyLight = Color(0xFFF5F5F5); // Very light grey
  static const Color greyMedium = Color(0xFFE0E0E0); // Light medium grey
  static const Color greyDark = Color(0xFF757575); // Dark medium grey
  static const Color black = Color(0xFF000000); // Pure black
  static const Color white = Color(0xFFFFFFFF); // Pure white

  // Divider & Border Colors
  static const Color dividerColor = Color(0xFFE0E0E0); // Light divider
  static const Color borderLightColor = Color(0xFFE8EAED); // Light border
  static const Color borderDarkColor = Color(0xFF5F6368); // Dark border

  // Shadow & Overlay Colors
  static const Color shadowColor = Color(0x1F000000); // Subtle shadow
  static const Color overlayLight = Color(
    0x40000000,
  ); // Semi-transparent dark overlay
  static const Color overlayDark = Color(
    0x40000000,
  ); // Semi-transparent dark overlay for dark mode

  // Chart Colors - Vibrant colors for analytics and charts
  static const List<Color> chartColors = [
    Color(0xFF4361ee), // Blue
    Color(0xFF4cc9f0), // Light blue
    Color(0xFFf72585), // Pink
    Color(0xFF7209b7), // Purple
    Color(0xFF3a0ca3), // Dark blue
    Color(0xFF4895ef), // Medium blue
    Color(0xFF4cc9f0), // Cyan
    Color(0xFFf15bb5), // Magenta
    Color(0xFFfee440), // Yellow
    Color(0xFF00bbf9), // Sky blue
    Color(0xFFf15bb5), // Magenta
    Color(0xFF9b5de5), // Purple
    Color(0xFF00bbf9), // Blue
    Color(0xFF00f5d4), // Mint
    Color(0xFFf8961e), // Amber
  ];

  /// Returns a color based on expense type (income or expense)
  static Color getColorByExpenseType(bool isExpense) {
    return isExpense ? expenseColor : incomeColor;
  }

  /// Returns a color based on the expense category
  static Color getColorByCategory(String category) {
    if (category.isEmpty) return otherColor;

    switch (category.toLowerCase().trim()) {
      case 'food':
      case 'dining':
      case 'groceries':
        return foodColor;
      case 'transportation':
      case 'travel':
      case 'gas':
        return transportationColor;
      case 'entertainment':
      case 'movies':
      case 'games':
        return entertainmentColor;
      case 'shopping':
      case 'clothing':
      case 'retail':
        return shoppingColor;
      case 'health':
      case 'medical':
      case 'fitness':
        return healthColor;
      case 'housing':
      case 'rent':
      case 'mortgage':
        return housingColor;
      case 'utilities':
      case 'electricity':
      case 'water':
        return utilitiesColor;
      case 'education':
      case 'books':
      case 'courses':
        return educationColor;
      default:
        return otherColor;
    }
  }

  /// Returns a color from the chart colors list based on index
  /// Useful for assigning consistent colors to categories in charts
  static Color getColorByIndex(int index) {
    if (index < 0) return chartColors.first;
    return chartColors[index % chartColors.length];
  }

  /// Returns a random color from the chart colors list
  static Color getRandomColor() {
    return chartColors[DateTime.now().millisecond % chartColors.length];
  }

  /// Blends two colors together
  static Color blendColors(Color color1, Color color2, double weight) {
    if (weight < 0.0) weight = 0.0;
    if (weight > 1.0) weight = 1.0;

    final r = (color1.red * (1.0 - weight) + color2.red * weight).round();
    final g = (color1.green * (1.0 - weight) + color2.green * weight).round();
    final b = (color1.blue * (1.0 - weight) + color2.blue * weight).round();
    final a = (color1.alpha * (1.0 - weight) + color2.alpha * weight).round();

    return Color.fromARGB(a, r, g, b);
  }

  /// Converts color's red component to integer value (0-255)
  static int getRedValue(Color color) {
    return (color.red).clamp(0, 255);
  }

  /// Converts color's green component to integer value (0-255)
  static int getGreenValue(Color color) {
    return (color.green).clamp(0, 255);
  }

  /// Converts color's blue component to integer value (0-255)
  static int getBlueValue(Color color) {
    return (color.blue).clamp(0, 255);
  }

  /// Converts color's alpha component to integer value (0-255)
  static int getAlphaValue(Color color) {
    return (color.alpha).clamp(0, 255);
  }

  /// Converts color's red component to normalized double value (0.0-1.0)
  static double getRedNormalized(Color color) {
    return color.red / 255.0;
  }

  /// Converts color's green component to normalized double value (0.0-1.0)
  static double getGreenNormalized(Color color) {
    return color.green / 255.0;
  }

  /// Converts color's blue component to normalized double value (0.0-1.0)
  static double getBlueNormalized(Color color) {
    return color.blue / 255.0;
  }

  /// Converts color's alpha component to normalized double value (0.0-1.0)
  static double getAlphaNormalized(Color color) {
    return color.alpha / 255.0;
  }

  /// Converts color to RGB values as integers (0-255)
  /// Returns a Map with 'r', 'g', 'b', and 'a' keys
  static Map<String, int> getRgbaValues(Color color) {
    return {
      'r': (color.red).clamp(0, 255),
      'g': (color.green).clamp(0, 255),
      'b': (color.blue).clamp(0, 255),
      'a': (color.alpha).clamp(0, 255),
    };
  }

  /// Converts color to RGB values as normalized doubles (0.0-1.0)
  /// Returns a Map with 'r', 'g', 'b', and 'a' keys
  static Map<String, double> getRgbaNormalized(Color color) {
    return {
      'r': color.red / 255.0,
      'g': color.green / 255.0,
      'b': color.blue / 255.0,
      'a': color.alpha / 255.0,
    };
  }

  /// Creates a Color from normalized RGB values (0.0-1.0)
  static Color fromNormalized(double r, double g, double b, [double a = 1.0]) {
    return Color.fromARGB(
      (a.clamp(0.0, 1.0) * 255).round(),
      (r.clamp(0.0, 1.0) * 255).round(),
      (g.clamp(0.0, 1.0) * 255).round(),
      (b.clamp(0.0, 1.0) * 255).round(),
    );
  }

  /// Creates a Color from integer RGB values (0-255)
  static Color fromRgba(int r, int g, int b, [int a = 255]) {
    return Color.fromARGB(
      a.clamp(0, 255),
      r.clamp(0, 255),
      g.clamp(0, 255),
      b.clamp(0, 255),
    );
  }
}
