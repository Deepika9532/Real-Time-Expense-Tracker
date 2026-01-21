class Validators {
  /* --------------------------------------------------------------------------
   * CORE BOOLEAN VALIDATORS (Reusable Logic)
   * -------------------------------------------------------------------------- */

  static bool isValidEmail(String email) {
    if (email.isEmpty) return false;
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(email);
  }

  static bool isValidPassword(
    String password, {
    int minLength = 8,
    bool requireUppercase = true,
    bool requireLowercase = true,
    bool requireDigit = true,
    bool requireSpecialChar = true,
  }) {
    if (password.length < minLength) return false;
    if (requireUppercase && !password.contains(RegExp(r'[A-Z]'))) return false;
    if (requireLowercase && !password.contains(RegExp(r'[a-z]'))) return false;
    if (requireDigit && !password.contains(RegExp(r'[0-9]'))) return false;
    if (requireSpecialChar &&
        !password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return false;
    }
    return true;
  }

  static bool isValidPhone(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'[\s\-\(\)\+]'), '');
    return RegExp(r'^\d{7,15}$').hasMatch(cleaned);
  }

  static bool isValidName(String name, {int minLength = 2}) {
    return name.trim().length >= minLength &&
        RegExp(r"^[a-zA-Z\s\-']+$").hasMatch(name);
  }

  static bool isValidAmount(String value) {
    final amount = double.tryParse(value);
    return amount != null && amount > 0;
  }

  static bool isValidUrl(String url) {
    return RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}'
      r'\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    ).hasMatch(url);
  }

  static bool isNumeric(String value) => double.tryParse(value) != null;

  static bool isInteger(String value) => int.tryParse(value) != null;

  static bool isValidDate(String value) {
    try {
      DateTime.parse(value);
      return true;
    } catch (_) {
      return false;
    }
  }

  static bool matches(String a, String b) => a == b;

  static bool isValidCreditCard(String number) {
    final cleaned = number.replaceAll(RegExp(r'\s'), '');
    if (!RegExp(r'^\d{13,19}$').hasMatch(cleaned)) return false;

    int sum = 0;
    bool alternate = false;
    for (int i = cleaned.length - 1; i >= 0; i--) {
      int digit = int.parse(cleaned[i]);
      if (alternate) {
        digit *= 2;
        if (digit > 9) digit -= 9;
      }
      sum += digit;
      alternate = !alternate;
    }
    return sum % 10 == 0;
  }

  /* --------------------------------------------------------------------------
   * FORM FIELD VALIDATORS (Flutter TextFormField)
   * -------------------------------------------------------------------------- */

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!isValidEmail(value)) return 'Enter a valid email address';
    return null;
  }

  static String? validatePassword(
    String? value, {
    int minLength = 8,
  }) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (!isValidPassword(value, minLength: minLength)) {
      return 'Password must be at least $minLength chars with upper, lower, digit & special char';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) return 'Confirm your password';
    if (!matches(value, password)) return 'Passwords do not match';
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Phone number is required';
    if (!isValidPhone(value)) return 'Enter a valid phone number';
    return null;
  }

  static String? validateName(String? value, {int minLength = 2}) {
    if (value == null || value.isEmpty) return 'Name is required';
    if (!isValidName(value, minLength: minLength)) {
      return 'Enter a valid name';
    }
    return null;
  }

  static String? validateRequired(String? value,
      {String field = 'This field', required String fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '$field is required';
    }
    return null;
  }

  static String? validateNumber(String? value) {
    if (value == null || value.isEmpty) return 'This field is required';
    if (!isNumeric(value)) return 'Enter a valid number';
    return null;
  }

  static String? validateDate(
    String? value, {
    DateTime? min,
    DateTime? max,
  }) {
    if (value == null || value.isEmpty) return 'Date is required';
    if (!isValidDate(value)) return 'Invalid date';

    final date = DateTime.parse(value);
    if (min != null && date.isBefore(min)) {
      return 'Date must be after ${min.toIso8601String().split("T")[0]}';
    }
    if (max != null && date.isAfter(max)) {
      return 'Date must be before ${max.toIso8601String().split("T")[0]}';
    }
    return null;
  }

  static String? validateCreditCard(String? value) {
    if (value == null || value.isEmpty) return 'Card number is required';
    if (!isValidCreditCard(value)) return 'Invalid card number';
    return null;
  }
}
