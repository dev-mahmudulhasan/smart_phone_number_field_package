import 'package:country_picker/country_picker.dart';

import '../data/country_format_overrides.dart';
import 'phone_format_spec.dart';

/// Wraps [Country] from `country_picker` with optional detailed national format.
class CountryModel {
  final Country _country;
  final PhoneFormatSpec _spec;

  CountryModel._(this._country, this._spec);

  String get code => _country.countryCode;

  String get dialCode {
    final p = _country.phoneCode;
    if (p.isEmpty) return '';
    return '+$p';
  }

  String get flag => _country.flagEmoji;

  String get name => _country.name;

  String get pattern => _spec.pattern;

  String get example {
    if (_spec.example.isNotEmpty) return _spec.example;
    if (_country.example.isNotEmpty) return _country.example;
    return '1234567890';
  }

  int get minLength => _spec.minLength;

  int get maxLength => _spec.maxLength;

  /// Underlying `country_picker` value (dial code, ISO code, localized name, etc.).
  Country get country => _country;

  static final CountryService _service = CountryService();

  /// Resolve by ISO 3166-1 alpha-2 (e.g. `BD`, `US`). Falls back to United States.
  static CountryModel getByCode(String code) {
    final c = _service.findByCode(code.toUpperCase());
    if (c != null) return fromCountry(c);
    final fallback = _service.findByCode('US');
    return fromCountry(fallback!);
  }

  static CountryModel fromCountry(Country country) {
    final spec = kCountryFormatOverrides[country.countryCode] ??
        PhoneFormatSpec.generic(
          example: country.example.isNotEmpty ? country.example : '1234567890',
        );
    return CountryModel._(country, spec);
  }

  /// All geographic countries from `country_picker` (typically 240+).
  static List<CountryModel> getCountries() {
    return _service
        .getAll()
        .where((c) => !c.iswWorldWide)
        .map(fromCountry)
        .toList();
  }

  static List<CountryModel> searchCountries(String query) {
    final q = query.trim().toLowerCase();
    final all = getCountries();
    if (q.isEmpty) return all;
    return all.where((country) {
      return country.name.toLowerCase().contains(q) ||
          country.dialCode.contains(query.trim()) ||
          country.code.toLowerCase().contains(q);
    }).toList();
  }
}
