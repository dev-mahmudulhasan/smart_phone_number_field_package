import 'package:flutter_test/flutter_test.dart';
import 'package:smart_phone_field/models/country_model.dart';
import 'package:smart_phone_field/utils/phone_formatter.dart';

void main() {
  group('SmartPhoneField Package Tests', () {
    test('CountryModel - getCountries returns list', () {
      final countries = CountryModel.getCountries();
      expect(countries.isNotEmpty, true);
      expect(countries.length, greaterThan(200));
    });

    test('CountryModel - getByCode returns correct country', () {
      final country = CountryModel.getByCode('BD');
      expect(country.code, 'BD');
      expect(country.dialCode, '+880');
      expect(country.flag, '🇧🇩');
    });

    test('CountryModel - searchCountries works', () {
      final results = CountryModel.searchCountries('Bangladesh');
      expect(results.isNotEmpty, true);
      expect(results.first.code, 'BD');
    });

    test('PhoneFormatter - Bangladesh format', () {
      final country = CountryModel.getByCode('BD');
      final formatted = PhoneFormatter.format('1712345678', country);
      expect(formatted, '17 1234-5678');
    });

    test('PhoneFormatter - US format', () {
      final country = CountryModel.getByCode('US');
      final formatted = PhoneFormatter.format('2125551234', country);
      expect(formatted, '(212) 555-1234');
    });

    test('PhoneFormatter - getUnformatted', () {
      final unformatted = PhoneFormatter.getUnformatted('(212) 555-1234');
      expect(unformatted, '2125551234');
    });

    test('PhoneFormatter - validate valid number', () {
      final country = CountryModel.getByCode('BD');
      final error = PhoneFormatter.validate('1712345678', country);
      expect(error, null);
    });

    test('PhoneFormatter - validate empty number', () {
      final country = CountryModel.getByCode('BD');
      final error = PhoneFormatter.validate('', country);
      expect(error, 'Phone number is required');
    });

    test('PhoneFormatter - validate short number', () {
      final country = CountryModel.getByCode('BD');
      final error = PhoneFormatter.validate('1712', country);
      expect(error, contains('Need 10 digits'));
    });

    test('PhoneFormatter - generic country uses pattern', () {
      final country = CountryModel.getByCode('AD');
      final formatted = PhoneFormatter.format('123456', country);
      expect(formatted, isNotEmpty);
      expect(formatted.replaceAll(RegExp(r'\D'), '').length, lessThanOrEqualTo(country.maxLength));
    });
  });
}
