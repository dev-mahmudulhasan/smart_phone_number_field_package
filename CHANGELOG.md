## 1.0.0

* Initial release: `SmartPhoneField` with flag + dial code, searchable country picker (`country_picker`, 240+ countries).
* National number formatting per country (detailed rules for many countries; pattern-based fallback for the rest).
* Optional GPS-based country detection via `geolocator` + `geocoding` (`autoDetectLocation`).
* Exports `CountryModel`, `PhoneFormatter`, and selected `country_picker` APIs.
