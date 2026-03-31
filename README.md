# smart_phone_field

A smart, professional Flutter phone-number input field with:

- 🌍 **Auto country detection** — GPS-based on first load *(optional)*
- 🏳️ **180+ countries** pre-configured with correct national spacing/dash patterns
- ⌨️ **Live formatting** as the user types — `1758 691303`, `(212) 555 1234`, etc.
- ✅ **Built-in validation** with customisable error display
- 🎨 **Fully customisable** — borders, fill, colours, styles, and more

---

## Installation

```yaml
dependencies:
  smart_phone_field: ^2.0.0
```

Then add location permissions to your platform manifests if you enable `autoDetectCountry`.

---

## Quick Start

```dart
import 'package:smart_phone_field/smart_phone_field.dart';

SmartPhoneField(
  onChanged: (nationalDigits, isoCode) {
    print('$isoCode → $nationalDigits');
  },
)
```

---

## All Parameters

### Core

| Parameter | Type | Default | Description |
|---|---|---|---|
| `controller` | `TextEditingController?` | `null` | External controller |
| `initialCountryCode` | `String?` | `null` | ISO alpha-2, e.g. `'BD'`, `'US'` |
| `onChanged` | `void Function(digits, iso)?` | `null` | Called on every change |
| `onError` | `void Function(String?)?` | `null` | Called with validation error |
| `onSubmitted` | `void Function(String)?` | `null` | Called on keyboard submit |

### Behaviour

| Parameter | Type | Default | Description |
|---|---|---|---|
| `autoDetectCountry` | `bool` | `true` | GPS-based country detect |
| `readOnly` | `bool` | `false` | Non-editable mode |
| `enabled` | `bool` | `true` | Enable / disable widget |
| `autofocus` | `bool` | `false` | Auto-focus on build |
| `textInputAction` | `TextInputAction` | `done` | Keyboard action |
| `inputFormatters` | `List<TextInputFormatter>?` | `null` | Extra formatters |

### Design — Container

| Parameter | Type | Default | Description |
|---|---|---|---|
| `borderRadius` | `BorderRadius?` | `circular(12)` | Corner radius |
| `borderColor` | `Color?` | `grey.shade400` | Normal border |
| `focusedBorderColor` | `Color?` | theme primary | Focused border |
| `errorBorderColor` | `Color?` | `red.shade400` | Error border |
| `borderWidth` | `double` | `1.0` | Border thickness |
| `fillColor` | `Color?` | `null` | Background colour |
| `filled` | `bool` | `false` | Show background fill |
| `containerDecoration` | `BoxDecoration?` | `null` | Full override |

### Design — Labels & Text

| Parameter | Type | Default | Description |
|---|---|---|---|
| `labelText` | `String?` | `null` | Label above field |
| `hintText` | `String?` | country example | Hint inside field |
| `hintStyle` | `TextStyle?` | `null` | Hint style |
| `labelStyle` | `TextStyle?` | `null` | Label style |
| `textStyle` | `TextStyle?` | `null` | Input text style |
| `cursorColor` | `Color?` | theme primary | Cursor colour |
| `contentPadding` | `EdgeInsets` | `h:12 v:14` | Inner padding |
| `decoration` | `InputDecoration?` | `null` | Full [InputDecoration] override |

### Design — Country Selector

| Parameter | Type | Default | Description |
|---|---|---|---|
| `flagSize` | `double` | `22` | Flag emoji size |
| `dialCodeStyle` | `TextStyle?` | `null` | Dial code text style |
| `showDropdownIcon` | `bool` | `true` | Show chevron arrow |
| `countryButtonPadding` | `EdgeInsets` | `h:12 v:14` | Selector padding |
| `searchHintText` | `String` | `'Search country…'` | Search field hint |
| `countryPickerTheme` | `CountryListThemeData?` | `null` | Bottom-sheet theme |

### Error Display

| Parameter | Type | Default | Description |
|---|---|---|---|
| `showError` | `bool` | `true` | Show inline error |
| `errorTextStyle` | `TextStyle?` | `null` | Error text style |
| `errorBuilder` | `Widget Function(error)?` | `null` | Custom error widget |

---

## Examples

### Bangladesh pre-selected
```dart
SmartPhoneField(
  initialCountryCode: 'BD',
  autoDetectCountry: false,
  hintText: '1758 691303',
  labelText: 'Mobile Number',
)
```
*Formats as you type: `1758 691303`*

### Custom-styled field
```dart
SmartPhoneField(
  filled: true,
  fillColor: Colors.blue.shade50,
  borderRadius: BorderRadius.circular(16),
  focusedBorderColor: Colors.blue,
  cursorColor: Colors.blue,
  labelText: 'Phone',
)
```

### Custom error display
```dart
SmartPhoneField(
  errorBuilder: (error) => MyCustomErrorWidget(error),
)
```

---

## Utilities

```dart
// Format digits with a country's pattern
final formatted = PhoneFormatter.format('1758691303', country);
// → '1758 691303' (for BD)

// Strip all non-digits from a formatted string
final digits = PhoneFormatter.getUnformatted('+880 1758 691303');
// → '8801758691303'

// Validate
final error = PhoneFormatter.validate('175869', country);
// → 'Enter at least 10 digits (e.g. 1758 691303)'

// Access country info
final bd = CountryModel.getByCode('BD');
print(bd.flag);     // 🇧🇩
print(bd.dialCode); // +880
print(bd.example);  // 1758 691303
```

---

## License

MIT
