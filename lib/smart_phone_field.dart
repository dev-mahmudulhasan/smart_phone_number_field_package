library smart_phone_field;

// ── Public surface ────────────────────────────────────────────────────────
export 'package:country_picker/country_picker.dart'
    show Country, CountryListThemeData, showCountryPicker;

export 'models/country_model.dart';
export 'models/phone_format_spec.dart';
export 'utils/phone_formatter.dart';

// ── Internal ──────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_picker/country_picker.dart';

import 'models/country_model.dart';
import 'utils/phone_formatter.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SmartPhoneField
// ─────────────────────────────────────────────────────────────────────────────

/// A smart phone-number input field with:
///
/// * Per-country number formatting applied as the user types.
/// * Searchable country picker (bottom sheet).
/// * Full design customisation via individual properties.
///
/// ### Minimal usage
/// ```dart
/// SmartPhoneField(
///   onChanged: (nationalDigits, isoCode) { … },
/// )
/// ```
///
/// ### Full-custom border + colours
/// ```dart
/// SmartPhoneField(
///   borderRadius: BorderRadius.circular(12),
///   focusedBorderColor: Colors.blue,
///   fillColor: Colors.grey.shade100,
///   filled: true,
///   labelText: 'Mobile Number',
/// )
/// ```
class SmartPhoneField extends StatefulWidget {
  // ── Core ──────────────────────────────────────────────────────────────────

  /// External controller. If `null`, the widget manages its own controller.
  final TextEditingController? controller;

  /// ISO 3166-1 alpha-2 code to pre-select a country (e.g. `'BD'`, `'US'`).
  final String? initialCountryCode;

  /// Called whenever the phone number or country changes.
  /// [dialCode] is the country dial code (e.g. `+880`).
  /// [phoneNumber] contains only the digits the user typed (no separators).
  /// [isoCode] is the ISO alpha-2 country code.
  final void Function(String dialCode, String phoneNumber, String isoCode)?
      onChanged;

  /// Custom validator. Return an error string or `null` if valid.
  final String? Function(String dialCode, String phoneNumber)? validator;

  /// Whether the field is required. If true and no [validator] is provided,
  /// a default "Required" error will be shown when empty.
  final bool isRequired;

  /// Called with a validation error string, or `null` when valid.
  final void Function(String? error)? onError;

  /// Called when the user submits the field (keyboard action).
  final void Function(String value)? onSubmitted;

  // ── Behaviour ─────────────────────────────────────────────────────────────

  /// Makes the text field non-editable.
  final bool readOnly;

  /// Enables / disables the whole widget.
  final bool enabled;

  /// Whether to auto-focus the field.
  final bool autofocus;

  /// Keyboard action button.
  final TextInputAction textInputAction;

  /// Additional [TextInputFormatter]s applied after the built-in phone
  /// formatter.
  final List<TextInputFormatter>? inputFormatters;

  // ── Text / Style ──────────────────────────────────────────────────────────

  /// Style applied to the typed phone number.
  final TextStyle? textStyle;

  /// Colour of the cursor.
  final Color? cursorColor;

  // ── Country selector ──────────────────────────────────────────────────────

  /// Style for the dial-code text (e.g. `+880`).
  final TextStyle? dialCodeStyle;

  /// Size of the flag emoji.
  final double flagSize;

  /// Whether to show the small dropdown chevron next to the dial code.
  final bool showDropdownIcon;

  /// Padding inside the country-selector button.
  final EdgeInsetsGeometry countryButtonPadding;

  /// Hint text shown in the country search field.
  final String searchHintText;

  /// Border radius of the search field in the country picker.
  final double searchFieldBorderRadius;

  /// Theme passed directly to [showCountryPicker]. Use this to fully
  /// customise the bottom sheet appearance.
  final CountryListThemeData? countryPickerTheme;

  // ── Container decoration ──────────────────────────────────────────────────

  /// Corner radius of the outer container. Defaults to `BorderRadius.circular(12)`.
  final BorderRadius? borderRadius;

  /// Border colour when the field is unfocused and has no error.
  final Color? borderColor;

  /// Border colour when the field is focused.
  final Color? focusedBorderColor;

  /// Border colour when there is a validation error.
  final Color? errorBorderColor;

  /// Border width. Defaults to `1.0`.
  final double borderWidth;

  /// Background fill colour. Only used when [filled] is `true`.
  final Color? fillColor;

  /// Whether the field has a background fill.
  final bool filled;

  /// Replaces the entire outer [BoxDecoration] when set.
  /// If provided, [borderRadius], [borderColor], [focusedBorderColor],
  /// [errorBorderColor], [borderWidth], [fillColor], and [filled] are ignored.
  final BoxDecoration? containerDecoration;

  // ── Input decoration ──────────────────────────────────────────────────────

  /// Label text shown above (or inside) the field.
  final String? labelText;

  /// Hint text shown when the field is empty.
  /// Defaults to the country's example number.
  final String? hintText;

  /// Style applied to [hintText].
  final TextStyle? hintStyle;

  /// Style applied to [labelText].
  final TextStyle? labelStyle;

  /// Padding inside the text field.
  final EdgeInsetsGeometry contentPadding;

  /// Widget placed at the trailing edge of the text field row.
  final Widget? suffixIcon;

  /// Replaces the entire [InputDecoration] of the inner [TextField].
  /// Border-related properties are cleared automatically.
  final InputDecoration? decoration;

  // ── Error / status ────────────────────────────────────────────────────────

  /// Whether to show the built-in inline error message. Defaults to `true`.
  final bool showError;

  /// Style applied to the error text.
  final TextStyle? errorTextStyle;

  /// Replaces the default error widget entirely.
  final Widget Function(String error)? errorBuilder;

  // ── Focus / callbacks ─────────────────────────────────────────────────────

  /// External [FocusNode]. If `null`, the widget creates its own.
  final FocusNode? focusNode;

  /// Called when the user taps the field.
  final VoidCallback? onTap;

  /// Called when editing is complete (pre-submit).
  final VoidCallback? onEditingComplete;

  // ─────────────────────────────────────────────────────────────────────────

  const SmartPhoneField({
    super.key,
    // core
    this.controller,
    this.initialCountryCode,
    this.onChanged,
    this.validator,
    this.isRequired = false,
    this.onError,
    this.onSubmitted,
    // behaviour
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    this.textInputAction = TextInputAction.done,
    this.inputFormatters,
    // text/style
    this.textStyle,
    this.cursorColor,
    // country selector
    this.dialCodeStyle,
    this.flagSize = 22,
    this.showDropdownIcon = true,
    this.countryButtonPadding =
        const EdgeInsets.only(left: 12, right: 8, top: 10, bottom: 10),
    this.searchHintText = 'Search country…',
    this.searchFieldBorderRadius = 12.0,
    this.countryPickerTheme,
    // container
    this.borderRadius,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.borderWidth = 1.0,
    this.fillColor,
    this.filled = false,
    this.containerDecoration,
    // decoration
    this.labelText,
    this.hintText,
    this.hintStyle,
    this.labelStyle,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
    this.suffixIcon,
    this.decoration,
    // error
    this.showError = true,
    this.errorTextStyle,
    this.errorBuilder,
    // focus/tap
    this.focusNode,
    this.onTap,
    this.onEditingComplete,
  });

  @override
  State<SmartPhoneField> createState() => SmartPhoneFieldState();
}

// ─────────────────────────────────────────────────────────────────────────────
// State
// ─────────────────────────────────────────────────────────────────────────────

class SmartPhoneFieldState extends State<SmartPhoneField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  CountryModel _country = CountryModel.getByCode('US');
  String _rawDigits = ''; // digits only, no separators
  String? _errorText;

  bool _isBusy = false; // guard against re-entrant formatting

  bool _hasFocus = false;

  // ── Lifecycle ─────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(_onFocusChanged);
    _controller.addListener(_onTextChanged);

    _initialise();
  }

  void _initialise() {
    if (widget.initialCountryCode != null) {
      _country = CountryModel.getByCode(widget.initialCountryCode!);
    } else {
      // Use device locale by default
      final platformDispatcher = WidgetsBinding.instance.platformDispatcher;
      final locales = platformDispatcher.locales;
      String? code;

      // 1. Try to find the first non-null country code in the system's locale list
      for (final locale in locales) {
        if (locale.countryCode != null && locale.countryCode!.isNotEmpty) {
          // If we find 'BD' anywhere in the list, prioritize it
          if (locale.countryCode == 'BD') {
            code = 'BD';
            break;
          }
          code ??= locale.countryCode;
        }
      }

      // 2. If still no code, try parsing the full locale string (e.g. "en_BD")
      if (code == null || code.isEmpty) {
        for (final locale in locales) {
          final locString = locale.toString();
          if (locString.contains('_')) {
            final parts = locString.split('_');
            if (parts.length > 1 && parts.last.length == 2) {
              code = parts.last;
              break;
            }
          }
        }
      }

      // 3. Last resort fallback for Bangladesh specifically based on Timezone (UTC+6)
      if (code == null || code == 'US' || code == 'GB') {
        final offset = DateTime.now().timeZoneOffset.inHours;
        if (offset == 6) {
          code = 'BD';
        }
      }

      if (code != null && code.isNotEmpty) {
        try {
          _country = CountryModel.getByCode(code);
        } catch (_) {
          _country = CountryModel.getByCode('US');
        }
      }
    }

    // Initialise from pre-filled controller text
    if (_controller.text.isNotEmpty) {
      _rawDigits = PhoneFormatter.getUnformatted(_controller.text);
      _applyFormat();
    }
  }

  @override
  void didUpdateWidget(SmartPhoneField old) {
    super.didUpdateWidget(old);
    if (old.initialCountryCode != widget.initialCountryCode &&
        widget.initialCountryCode != null) {
      setState(() {
        _country = CountryModel.getByCode(widget.initialCountryCode!);
        _rawDigits = '';
        _errorText = null;
        _clearController();
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _focusNode.removeListener(_onFocusChanged);
    if (widget.controller == null) _controller.dispose();
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  // ── Text change & formatting ──────────────────────────────────────────────

  void _onTextChanged() {
    if (_isBusy) return;
    _isBusy = true;

    final newDigits = PhoneFormatter.getUnformatted(_controller.text);
    if (newDigits != _rawDigits) {
      _rawDigits = newDigits;
      _applyFormat();
      _validate();
      widget.onChanged?.call(_country.dialCode, _rawDigits, _country.code);
    }

    _isBusy = false;
  }

  void _applyFormat() {
    final formatted = PhoneFormatter.format(_rawDigits, _country);
    if (_controller.text != formatted) {
      _controller.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
  }

  void _clearController() {
    _controller.value = const TextEditingValue(
      text: '',
      selection: TextSelection.collapsed(offset: 0),
    );
  }

  // ── Focus ─────────────────────────────────────────────────────────────────

  void _onFocusChanged() {
    setState(() => _hasFocus = _focusNode.hasFocus);
    if (!_focusNode.hasFocus) {
      _validate();
    }
  }

  /// Manually trigger validation. Returns true if valid.
  bool validateField() {
    return _validate();
  }

  bool _validate() {
    String? err;

    // 1. Check custom validator first
    if (widget.validator != null) {
      err = widget.validator!(_country.dialCode, _rawDigits);
    }

    // 2. Default required check
    if (err == null && widget.isRequired && _rawDigits.isEmpty) {
      err = 'This field is required';
    }

    // 3. Built-in format validation
    if (err == null && _rawDigits.isNotEmpty) {
      err = PhoneFormatter.validate(_rawDigits, _country);
    }

    if (err != _errorText) {
      setState(() => _errorText = err);
      widget.onError?.call(err);
    }
    return err == null;
  }

  // ── Country picker ────────────────────────────────────────────────────────

  void _openCountryPicker() {
    showCountryPicker(
      context: context,
      countryListTheme: widget.countryPickerTheme ??
          CountryListThemeData(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
            ),
            backgroundColor: Theme.of(context).colorScheme.surface,
            searchTextStyle: Theme.of(context).textTheme.bodyMedium,
            inputDecoration: InputDecoration(
              hintText: widget.searchHintText,
              prefixIcon: const Icon(Icons.search_rounded, size: 20),
              filled: true,
              fillColor: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHighest
                  .withValues(alpha: 0.4),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.searchFieldBorderRadius),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.searchFieldBorderRadius),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.searchFieldBorderRadius),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1.5,
                ),
              ),
            ),
          ),
      showPhoneCode: false,
      customFlagBuilder: (Country c) {
        final flag = c.iswWorldWide ? '\uD83C\uDF0D' : c.flagEmoji;
        final bool isRtl = Directionality.of(context) == TextDirection.rtl;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: isRtl ? 50 : null,
              child: Text(
                flag,
                style: TextStyle(
                  fontSize: widget.countryPickerTheme?.flagSize ?? 25,
                ),
              ),
            ),
            if (!c.iswWorldWide) ...[
              const SizedBox(width: 15),
              Text(
                '${isRtl ? '' : '+'}${c.phoneCode}${isRtl ? '+' : ''}',
                style: widget.countryPickerTheme?.textStyle ??
                    const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 15),
            ] else
              const SizedBox(width: 15),
          ],
        );
      },
      onSelect: (Country c) {
        setState(() {
          _country = CountryModel.getByCode(c.countryCode);
          _rawDigits = '';
          _errorText = null;
          _clearController();
        });
        widget.onError?.call(null);
        widget.onChanged?.call(_country.dialCode, '', _country.code);
      },
    );
  }

  // ── Decoration helpers ────────────────────────────────────────────────────

  BoxDecoration _buildContainerDecoration() {
    if (widget.containerDecoration != null) {
      return widget.containerDecoration!;
    }

    final bool hasError = _errorText != null;
    final radius = widget.borderRadius ?? BorderRadius.circular(12);

    Color border;
    if (hasError) {
      border = widget.errorBorderColor ?? Colors.red.shade400;
    } else if (_hasFocus) {
      border =
          widget.focusedBorderColor ?? Theme.of(context).colorScheme.primary;
    } else {
      border = widget.borderColor ?? Colors.grey.shade400;
    }

    return BoxDecoration(
      borderRadius: radius,
      color: widget.filled
          ? (widget.fillColor ?? Theme.of(context).cardColor)
          : Theme.of(context).colorScheme.surface,
      border: Border.all(
        color: border,
        width: _hasFocus ? (widget.borderWidth + 0.5) : widget.borderWidth,
      ),
      boxShadow: [
        if (_hasFocus)
          BoxShadow(
            color: border.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
      ],
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: widget.labelStyle ??
                Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
          ),
          const SizedBox(height: 6),
        ],

        // ── Outer container ────────────────────────────────────────────────
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          decoration: _buildContainerDecoration(),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Country selector
                _CountryButton(
                  country: _country,
                  flagSize: widget.flagSize,
                  dialCodeStyle: widget.dialCodeStyle,
                  showDropdown: widget.showDropdownIcon,
                  padding: widget.countryButtonPadding,
                  onTap: widget.enabled && !widget.readOnly
                      ? _openCountryPicker
                      : null,
                ),

                // Vertical divider
                VerticalDivider(
                  width: 1,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                  color: Colors.grey.shade300,
                ),

                // Phone input
                Expanded(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    readOnly: widget.readOnly,
                    enabled: widget.enabled,
                    autofocus: widget.autofocus,
                    keyboardType: TextInputType.phone,
                    textInputAction: widget.textInputAction,
                    inputFormatters: widget.inputFormatters,
                    style: widget.textStyle ??
                        Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                    cursorColor: widget.cursorColor ??
                        Theme.of(context).colorScheme.primary,
                    cursorWidth: 2,
                    cursorRadius: const Radius.circular(2),
                    onTap: widget.onTap,
                    onEditingComplete: widget.onEditingComplete,
                    onSubmitted: widget.onSubmitted,
                    decoration: _buildInputDecoration(),
                  ),
                ),

                // Optional suffix
                if (widget.suffixIcon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: widget.suffixIcon!,
                  ),
              ],
            ),
          ),
        ),

        // ── Status messages ────────────────────────────────────────────────
        if (widget.showError && _errorText != null)
          _buildErrorWidget(_errorText!),
      ],
    );
  }

  InputDecoration _buildInputDecoration() {
    final base = widget.decoration ?? const InputDecoration();
    return base.copyWith(
      hintText: widget.hintText ?? _country.example,
      hintStyle: widget.hintStyle ??
          TextStyle(color: Colors.grey.shade400, fontSize: 14),
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
      contentPadding: widget.contentPadding,
      isDense: true,
      // Preserve user-supplied suffix/prefix from decoration if provided
      suffixIcon: base.suffixIcon,
      prefixIcon: base.prefixIcon,
    );
  }

  Widget _buildErrorWidget(String error) {
    if (widget.errorBuilder != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 4),
        child: widget.errorBuilder!(error),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(left: 4, top: 4),
      child: Row(
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 13,
            color: widget.errorBorderColor ?? Colors.red.shade400,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              error,
              style: widget.errorTextStyle ??
                  TextStyle(
                    fontSize: 11.5,
                    color: widget.errorBorderColor ?? Colors.red.shade400,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Country selector button  (internal widget)
// ─────────────────────────────────────────────────────────────────────────────

class _CountryButton extends StatelessWidget {
  const _CountryButton({
    required this.country,
    required this.flagSize,
    required this.showDropdown,
    required this.padding,
    this.dialCodeStyle,
    this.onTap,
  });

  final CountryModel country;
  final double flagSize;
  final bool showDropdown;
  final EdgeInsetsGeometry padding;
  final TextStyle? dialCodeStyle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Flag emoji
            SizedBox(
              width: flagSize + 2,
              child: Text(
                country.flag,
                style: TextStyle(fontSize: flagSize),
              ),
            ),
            const SizedBox(width: 6),

            // Dial code
            Text(
              country.dialCode,
              maxLines: 1,
              softWrap: false,
              style: dialCodeStyle ??
                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
            ),

            if (showDropdown) ...[
              const SizedBox(width: 2),
              Icon(
                Icons.arrow_drop_down_rounded,
                size: 25,
                color: Colors.grey.shade500,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
