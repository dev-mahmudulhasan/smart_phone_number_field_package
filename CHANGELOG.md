## 2.2.1 — 2026-04-05

### ✨ New Features
* **Visual Required Indicator** — Mandatory fields (where `isRequired` is true) now automatically display a red `*` next to the label.

---

## 2.2.0 — 2026-04-05

### ✨ New Features
* **Triple Parameter `onChanged`** — Callback now provides `(dialCode, phoneNumber, isoCode)` for simpler integration.
* **`validator`** — Custom validation support through a standard callback.
* **`isRequired`** — New boolean property for quick mandatory field validation.

### 🛠 Improvements
* **Manual Validation** — Expose a dynamic `validateField()` method in `SmartPhoneFieldState` to allow validation via `GlobalKey<SmartPhoneFieldState>`.
* **Public State** — Renamed `_SmartPhoneFieldState` to `SmartPhoneFieldState` to ensure full compatibility with `GlobalKey` and platform-specific access.

---

## 2.1.2 — 2026-03-31

### ✨ New Features
* **Enhanced Country Picker UI** — Modern, professional search field styling out-of-the-box.
* **`searchFieldBorderRadius`** — Customise search field corner radius (defaults to `12.0`).

### 🛠 Improvements
* Improved default bottom-sheet design with cleaner focus states and system-aware colors.
* Fixed an issue where 4-digit country dial codes would wrap onto a second line in the country picker bottom sheet.
* Improved default spacing for the country code field: centered the vertical divider with identical gaps, and increased the dropdown arrow size to `25`.

---

## 2.1.1 — 2026-03-31

* Initialised version 2.1.1 (manual bump).

---

## 2.1.0 — 2026-03-31

### 🛠 Improvements
* **Removed location dependencies** (`geolocator`, `geocoding`) to resolve version conflicts.
* **Simplified country detection** — now uses device locale as the only fallback if `initialCountryCode` is not provided.
* **Removed `autoDetectCountry`** parameter (no longer needed).
* Updated example app and documentation.

---

## 2.0.0 — 2026-03-31

### 🚀 Breaking Changes
* Renamed `autoDetectLocation` → `autoDetectCountry` for clarity.
* `onChanged` callback now returns `(nationalDigits, isoCode)` instead of raw text.

### ✨ New Features
* **Unified pattern-based formatter** — replaced 100+ individual country switch-case functions with a single `applyPattern()` engine driven by `PhoneFormatSpec.pattern`.
* **Correct national spacing for all countries** — e.g. Bangladesh `1758 691303`, USA `(212) 555 1234`, UK `07911 123456`, China `138 1234 5678`, etc.
* **180+ countries** now have explicit format overrides (Central Asia, more African & European countries added).
* **Full design customisation via widget properties:**
  * `labelText`, `hintText`, `hintStyle`, `labelStyle`
  * `borderRadius`, `borderColor`, `focusedBorderColor`, `errorBorderColor`, `borderWidth`
  * `filled`, `fillColor`
  * `flagSize`, `dialCodeStyle`, `showDropdownIcon`, `countryButtonPadding`
  * `errorBuilder` (custom error widget)
  * `suffixIcon`, `contentPadding`, `textStyle`, `cursorColor`
  * `countryPickerTheme` for full bottom-sheet customisation
* **`autofocus`**, **`textInputAction`**, **`onSubmitted`**, **`inputFormatters`** added.
* **GPS timeout** (8 s) with automatic fallback to device locale — no more indefinite loading.
* Animated border colour transition on focus/error.
* `containerDecoration` override still available for full `BoxDecoration` control.

### 🛠 Improvements
* Removed unused `phone_numbers_parser` dependency.
* `PhoneFormatter` is now a proper utility class (`PhoneFormatter._()` private constructor).
* `PhoneFormatter.applyPattern()` is public for external use.
* Updated `pubspec.yaml`: version `2.0.0`, correct repository/issue_tracker URLs.
* Example app demonstrates 5 different configurations (auto-detect, pre-selected, filled, read-only, custom error).

---

## 1.0.0 — 2026-03-31

* Initial release: `SmartPhoneField` with flag + dial code, searchable country picker (240+ countries).
* National number formatting per country (detailed rules for many countries; pattern-based fallback for the rest).
* Optional GPS-based country detection via `geolocator` + `geocoding`.
* Exports `CountryModel`, `PhoneFormatter`, and selected `country_picker` APIs.
