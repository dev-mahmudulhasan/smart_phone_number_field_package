/// Defines the national-number format for a specific country.
///
/// Pattern syntax:
///   `#`   → consumes one digit
///   ` `   → space separator (displayed while typing)
///   `-`   → dash separator
///   `(`/`)` → parenthesis (used in NANP format)
///
/// Example: `## ####-######` for Bangladesh → `17 5869-130323`
class PhoneFormatSpec {
  /// The display pattern used while typing (e.g. `## #### ######`).
  final String pattern;

  /// A localised example number string shown as hint (e.g. `17 5869-130323`).
  final String example;

  /// Minimum digit count for a valid national number.
  final int minLength;

  /// Maximum digit count for a national number.
  final int maxLength;

  const PhoneFormatSpec({
    required this.pattern,
    required this.example,
    required this.minLength,
    required this.maxLength,
  });

  /// Fallback spec used when no country-specific override exists.
  /// Accepts up to 15 digits (E.164 max) with simple grouping.
  factory PhoneFormatSpec.generic({String example = '1234567890'}) {
    return PhoneFormatSpec(
      pattern: '#### ### ####',
      example: example,
      minLength: 4,
      maxLength: 15,
    );
  }
}
