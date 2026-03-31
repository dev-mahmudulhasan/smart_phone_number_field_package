library smart_phone_field;

// ── Public surface ────────────────────────────────────────────────────────
export 'package:country_picker/country_picker.dart'
    show Country, CountryListThemeData, showCountryPicker;

export 'models/country_model.dart';
export 'models/phone_format_spec.dart';
export 'utils/phone_formatter.dart';

// ── Internal ──────────────────────────────────────────────────────────────
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_picker/country_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'models/country_model.dart';
import 'utils/phone_formatter.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SmartPhoneField
// ─────────────────────────────────────────────────────────────────────────────

/// A smart phone-number input field with:
///
/// * Automatic country detection from device locale / GPS (optional).
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
  /// Takes priority over [autoDetectCountry].
  final String? initialCountryCode;

  /// Called whenever the phone number or country changes.
  /// [nationalDigits] contains only the digits the user typed (no separators).
  /// [isoCode] is the ISO alpha-2 country code.
  final void Function(String nationalDigits, String isoCode)? onChanged;

  /// Called with a validation error string, or `null` when valid.
  final void Function(String? error)? onError;

  /// Called when the user submits the field (keyboard action).
  final void Function(String value)? onSubmitted;

  // ── Behaviour ─────────────────────────────────────────────────────────────

  /// Whether to attempt GPS-based country detection on first load.
  /// Ignored if [initialCountryCode] is set.
  final bool autoDetectCountry;

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
    this.onError,
    this.onSubmitted,
    // behaviour
    this.autoDetectCountry = true,
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
        const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    this.searchHintText = 'Search country…',
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
        const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
  State<SmartPhoneField> createState() => _SmartPhoneFieldState();
}

// ─────────────────────────────────────────────────────────────────────────────
// State
// ─────────────────────────────────────────────────────────────────────────────

class _SmartPhoneFieldState extends State<SmartPhoneField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  CountryModel _country = CountryModel.getByCode('US');
  String _rawDigits = ''; // digits only, no separators
  String? _errorText;

  bool _isBusy = false; // guard against re-entrant formatting
  bool _isDetecting = false;
  bool _locationDenied = false;
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
    } else if (widget.autoDetectCountry) {
      _detectCountryFromGps();
    } else {
      // Fall back to device locale
      final locale = WidgetsBinding.instance.platformDispatcher.locale;
      final code = locale.countryCode;
      if (code != null && code.isNotEmpty) {
        _country = CountryModel.getByCode(code);
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

  // ── Location detection ────────────────────────────────────────────────────

  Future<void> _detectCountryFromGps() async {
    if (!mounted) return;
    setState(() {
      _isDetecting = true;
      _locationDenied = false;
    });

    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        _fallbackToLocale();
        return;
      }

      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      ).timeout(const Duration(seconds: 8));

      final marks = await placemarkFromCoordinates(
        pos.latitude,
        pos.longitude,
      );

      if (marks.isNotEmpty && mounted) {
        final code = marks.first.isoCountryCode ?? 'US';
        setState(() => _country = CountryModel.getByCode(code));
      }
    } on TimeoutException {
      _fallbackToLocale();
    } catch (_) {
      _fallbackToLocale();
    } finally {
      if (mounted) setState(() => _isDetecting = false);
    }
  }

  void _fallbackToLocale() {
    if (!mounted) return;
    final locale = WidgetsBinding.instance.platformDispatcher.locale;
    final code = locale.countryCode;
    setState(() {
      _locationDenied = true;
      if (code != null && code.isNotEmpty) {
        _country = CountryModel.getByCode(code);
      }
    });
  }

  // ── Text change & formatting ──────────────────────────────────────────────

  void _onTextChanged() {
    if (_isBusy) return;
    _isBusy = true;

    final newDigits = PhoneFormatter.getUnformatted(_controller.text);
    if (newDigits != _rawDigits) {
      _rawDigits = newDigits;
      _applyFormat();

      final err = PhoneFormatter.validate(_rawDigits, _country);
      if (err != _errorText) {
        setState(() => _errorText = err);
        widget.onError?.call(err);
      }

      widget.onChanged?.call(_rawDigits, _country.code);
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
      final err = PhoneFormatter.validate(_rawDigits, _country);
      if (err != _errorText) {
        setState(() => _errorText = err);
        widget.onError?.call(err);
      }
    }
  }

  // ── Country picker ────────────────────────────────────────────────────────

  void _openCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      countryListTheme: widget.countryPickerTheme ??
          CountryListThemeData(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            inputDecoration: InputDecoration(
              hintText: widget.searchHintText,
              prefixIcon: const Icon(Icons.search_rounded),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
      onSelect: (Country c) {
        setState(() {
          _country = CountryModel.getByCode(c.countryCode);
          _rawDigits = '';
          _errorText = null;
          _clearController();
        });
        widget.onError?.call(null);
        widget.onChanged?.call('', _country.code);
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
      border = widget.focusedBorderColor ??
          Theme.of(context).colorScheme.primary;
    } else {
      border = widget.borderColor ?? Colors.grey.shade400;
    }

    return BoxDecoration(
      borderRadius: radius,
      color: widget.filled
          ? (widget.fillColor ?? Theme.of(context).cardColor)
          : null,
      border: Border.all(color: border, width: widget.borderWidth),
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
          duration: const Duration(milliseconds: 200),
          decoration: _buildContainerDecoration(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Country selector
              _CountryButton(
                country: _country,
                isDetecting: _isDetecting,
                flagSize: widget.flagSize,
                dialCodeStyle: widget.dialCodeStyle,
                showDropdown: widget.showDropdownIcon,
                padding: widget.countryButtonPadding,
                onTap: widget.enabled && !widget.readOnly
                    ? _openCountryPicker
                    : null,
              ),

              // Vertical divider
              Container(
                height: 24,
                width: 1,
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
                      Theme.of(context).textTheme.bodyMedium,
                  cursorColor:
                      widget.cursorColor ?? Theme.of(context).colorScheme.primary,
                  onTap: widget.onTap,
                  onEditingComplete: widget.onEditingComplete,
                  onSubmitted: widget.onSubmitted,
                  decoration: _buildInputDecoration(),
                ),
              ),

              // Optional suffix
              if (widget.suffixIcon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: widget.suffixIcon!,
                ),
            ],
          ),
        ),

        // ── Status messages ────────────────────────────────────────────────
        if (widget.showError && _errorText != null)
          _buildErrorWidget(_errorText!),

        if (_locationDenied && widget.autoDetectCountry)
          _buildLocationDeniedBanner(),
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

  Widget _buildLocationDeniedBanner() {
    return Padding(
      padding: const EdgeInsets.only(left: 4, top: 4),
      child: Row(
        children: [
          Icon(Icons.location_off_rounded, size: 12, color: Colors.orange[600]),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              'Location access denied — using device locale.',
              style: TextStyle(fontSize: 11, color: Colors.orange[600]),
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
    required this.isDetecting,
    required this.flagSize,
    required this.showDropdown,
    required this.padding,
    this.dialCodeStyle,
    this.onTap,
  });

  final CountryModel country;
  final bool isDetecting;
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
            // Flag or loader
            SizedBox(
              width: flagSize + 2,
              child: isDetecting
                  ? SizedBox(
                      width: flagSize - 4,
                      height: flagSize - 4,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )
                  : Text(
                      country.flag,
                      style: TextStyle(fontSize: flagSize),
                    ),
            ),
            const SizedBox(width: 6),

            // Dial code
            Text(
              country.dialCode,
              style: dialCodeStyle ??
                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
            ),

            if (showDropdown) ...[
              const SizedBox(width: 2),
              Icon(
                Icons.arrow_drop_down_rounded,
                size: 18,
                color: Colors.grey.shade500,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
