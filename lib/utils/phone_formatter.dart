import '../models/country_model.dart';

/// Utility class for formatting and validating phone numbers.
///
/// All formatting is driven by the [PhoneFormatSpec.pattern] stored in
/// [CountryModel]. The pattern uses `#` as a digit placeholder; every other
/// character (space, dash, parenthesis, etc.) is inserted verbatim.
class PhoneFormatter {
  PhoneFormatter._();

  // ────────────────────────────────────────────────────────────
  // Public API
  // ────────────────────────────────────────────────────────────

  /// Formats [number] (digits only or partially typed) according to the
  /// national pattern defined for [country].
  ///
  /// * Strips all non-digit characters first.
  /// * Clamps to [country.maxLength] digits.
  /// * Applies the pattern progressively as the user types.
  static String format(String number, CountryModel country) {
    final clean = _digitsOnly(number, maxLen: country.maxLength);
    if (clean.isEmpty) return '';
    return _applyPattern(clean, country.pattern);
  }

  /// Applies [pattern] to [digits] (digits-only string).
  ///
  /// `#` in the pattern consumes one digit; every other character is emitted
  /// literally. Stops when digits are exhausted. Does NOT append extra digits
  /// beyond the pattern (they are truncated by [format] already).
  static String applyPattern(String digits, String pattern) {
    return _applyPattern(digits, pattern);
  }

  /// Strips all non-digit characters from [formatted].
  static String getUnformatted(String formatted) =>
      formatted.replaceAll(RegExp(r'\D'), '');

  /// Validates [number] against [country] length constraints.
  ///
  /// Returns `null` when valid, or a localised error string.
  static String? validate(String number, CountryModel country) {
    final clean = number.replaceAll(RegExp(r'\D'), '');

    if (clean.isEmpty) {
      return 'Phone number is required';
    }
    if (clean.length < country.minLength) {
      return 'Enter at least ${country.minLength} digits  '
          '(e.g. ${country.example})';
    }
    if (clean.length > country.maxLength) {
      return 'Maximum ${country.maxLength} digits allowed';
    }
    return null;
  }

  // ────────────────────────────────────────────────────────────
  // Private helpers
  // ────────────────────────────────────────────────────────────

  /// Removes non-digits and optionally clamps to [maxLen].
  static String _digitsOnly(String raw, {int maxLen = 15}) {
    final digits = raw.replaceAll(RegExp(r'\D'), '');
    return digits.length > maxLen ? digits.substring(0, maxLen) : digits;
  }

  /// Core pattern application logic.
  static String _applyPattern(String digits, String pattern) {
    final buf = StringBuffer();
    var digitIndex = 0;

    for (var i = 0; i < pattern.length && digitIndex < digits.length; i++) {
      final ch = pattern[i];
      if (ch == '#') {
        buf.write(digits[digitIndex++]);
      } else {
        // Emit separator only if there are more digits to display after it,
        // OR we've already emitted at least one digit (avoids leading separators).
        buf.write(ch);
      }
    }

    // Trim any trailing separators that appeared before enough digits were typed.
    return buf.toString().trimRight();
  }
}
