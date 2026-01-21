import 'package:intl/intl.dart';

class CurrencyFormatter {
  // Format currency with symbol
  static String format(
    double amount, {
    String locale = 'en_US',
    String symbol = '\$',
    int decimalDigits = 2,
  }) {
    final formatter = NumberFormat.currency(
      locale: locale,
      symbol: symbol,
      decimalDigits: decimalDigits,
    );
    return formatter.format(amount);
  }

  // Format currency without symbol
  static String formatWithoutSymbol(
    double amount, {
    String locale = 'en_US',
    int decimalDigits = 2,
  }) {
    final formatter = NumberFormat.currency(
      locale: locale,
      symbol: '',
      decimalDigits: decimalDigits,
    );
    return formatter.format(amount).trim();
  }

  // Common currency formats
  static String formatUSD(double amount, {int decimalDigits = 2}) {
    return format(
      amount,
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: decimalDigits,
    );
  }

  static String formatEUR(double amount, {int decimalDigits = 2}) {
    return format(
      amount,
      locale: 'de_DE',
      symbol: '€',
      decimalDigits: decimalDigits,
    );
  }

  static String formatGBP(double amount, {int decimalDigits = 2}) {
    return format(
      amount,
      locale: 'en_GB',
      symbol: '£',
      decimalDigits: decimalDigits,
    );
  }

  static String formatINR(double amount, {int decimalDigits = 2}) {
    return format(
      amount,
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: decimalDigits,
    );
  }

  static String formatJPY(double amount) {
    return format(amount, locale: 'ja_JP', symbol: '¥', decimalDigits: 0);
  }

  static String formatCNY(double amount, {int decimalDigits = 2}) {
    return format(
      amount,
      locale: 'zh_CN',
      symbol: '¥',
      decimalDigits: decimalDigits,
    );
  }

  // Format with compact notation (e.g., 1.5K, 2.3M)
  static String formatCompact(
    double amount, {
    String locale = 'en_US',
    String symbol = '\$',
  }) {
    final formatter = NumberFormat.compactCurrency(
      locale: locale,
      symbol: symbol,
    );
    return formatter.format(amount);
  }

  // Format as percentage
  static String formatPercentage(double value, {int decimalDigits = 2}) {
    final formatter = NumberFormat.percentPattern()
      ..maximumFractionDigits = decimalDigits
      ..minimumFractionDigits = decimalDigits;
    return formatter.format(value);
  }

  // Format with thousand separators
  static String formatWithSeparator(
    double amount, {
    String locale = 'en_US',
    int decimalDigits = 2,
  }) {
    final formatter = NumberFormat('#,##0.${'0' * decimalDigits}', locale);
    return formatter.format(amount);
  }

  // Parse currency string to double
  static double? parse(String currencyString) {
    try {
      // Remove currency symbols and spaces
      final cleanString = currencyString
          .replaceAll(RegExp(r'[^\d.,\-]'), '')
          .replaceAll(',', '');
      return double.parse(cleanString);
    } catch (e) {
      return null;
    }
  }

  // Format with custom symbol position
  static String formatCustom(
    double amount, {
    String symbol = '\$',
    bool symbolAfter = false,
    int decimalDigits = 2,
    String thousandSeparator = ',',
    String decimalSeparator = '.',
  }) {
    final absAmount = amount.abs();
    final intPart = absAmount.floor();
    final decimalPart = ((absAmount - intPart) * 100).round();

    // Format integer part with thousand separator
    final intString = intPart.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}$thousandSeparator',
    );

    // Format decimal part
    final decimalString = decimalPart.toString().padLeft(2, '0');

    // Combine parts
    String result = decimalDigits > 0
        ? '$intString$decimalSeparator${decimalString.substring(0, decimalDigits)}'
        : intString;

    // Add symbol
    result = symbolAfter ? '$result $symbol' : '$symbol$result';

    // Add negative sign if needed
    return amount < 0 ? '-$result' : result;
  }

  // Format for display in lists (shorter format)
  static String formatForList(double amount, {String symbol = '\$'}) {
    if (amount.abs() >= 1000000) {
      return formatCompact(amount, symbol: symbol);
    } else {
      return format(amount, symbol: symbol, decimalDigits: 0);
    }
  }

  // Validate currency string
  static bool isValidCurrencyString(String value) {
    final regex = RegExp(r'^\$?\d{1,3}(,?\d{3})*(\.\d{2})?$');
    return regex.hasMatch(value.trim());
  }

  // Get currency symbol by code
  static String getCurrencySymbol(String currencyCode) {
    final symbols = {
      'USD': '\$',
      'EUR': '€',
      'GBP': '£',
      'INR': '₹',
      'JPY': '¥',
      'CNY': '¥',
      'AUD': 'A\$',
      'CAD': 'C\$',
      'CHF': 'CHF',
      'SEK': 'kr',
      'NZD': 'NZ\$',
    };
    return symbols[currencyCode.toUpperCase()] ?? currencyCode;
  }
}
