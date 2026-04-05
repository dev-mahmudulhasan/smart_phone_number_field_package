import 'package:flutter/material.dart';
import 'package:smart_phone_field/smart_phone_field.dart';

void main() => runApp(const SmartPhoneFieldDemo());

class SmartPhoneFieldDemo extends StatelessWidget {
  const SmartPhoneFieldDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Phone Field Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        fontFamily: 'sans-serif',
      ),
      home: const DemoPage(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final _controller1 = TextEditingController();

  String _nationalDigits = '';
  String _isoCode = '';
  String? _error;

  @override
  void dispose() {
    _controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: cs.surfaceContainerLowest,
      appBar: AppBar(
        title: const Text('Smart Phone Field'),
        centerTitle: true,
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Default ──────────────────────────────────────────────────
            const _SectionTitle('Default (device locale)'),
            SmartPhoneField(
              controller: _controller1,
              onChanged: (dialCode, digits, iso) => setState(() {
                _nationalDigits = digits;
                _isoCode = iso;
              }),
              onError: (e) => setState(() => _error = e),
            ),
            const SizedBox(height: 12),
            _OutputCard(
              nationalDigits: _nationalDigits,
              isoCode: _isoCode,
              error: _error,
            ),

            const SizedBox(height: 32),

            // ── Pre-selected BD ──────────────────────────────────────────
            const _SectionTitle('Pre-selected: Bangladesh (+880)'),
            SmartPhoneField(
              initialCountryCode: 'BD',
              hintText: '1758 691303',
              labelText: 'Mobile Number',
              borderRadius: BorderRadius.circular(8),
              focusedBorderColor: Colors.green,
              borderColor: Colors.grey.shade300,
            ),

            const SizedBox(height: 32),

            // ── Filled style ─────────────────────────────────────────────
            const _SectionTitle('Filled + custom colours'),
            SmartPhoneField(
              initialCountryCode: 'US',
              labelText: 'Phone',
              filled: true,
              fillColor: cs.primaryContainer.withValues(alpha: 0.35),
              borderColor: Colors.transparent,
              focusedBorderColor: cs.primary,
              borderRadius: BorderRadius.circular(14),
              cursorColor: cs.primary,
              textStyle: TextStyle(
                color: cs.primary,
                fontWeight: FontWeight.w500,
              ),
              dialCodeStyle: TextStyle(
                color: cs.primary,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 32),

            // ── Read-only ─────────────────────────────────────────────────
            const _SectionTitle('Read-only'),
            SmartPhoneField(
              initialCountryCode: 'GB',
              readOnly: true,
              borderColor: Colors.grey.shade300,
              textStyle: TextStyle(color: Colors.grey.shade500),
              dialCodeStyle: TextStyle(color: Colors.grey.shade500),
              showDropdownIcon: false,
            ),

            const SizedBox(height: 32),

            // ── Custom error builder ───────────────────────────────────────
            const _SectionTitle('Custom error widget'),
            SmartPhoneField(
              initialCountryCode: 'DE',
              focusedBorderColor: Colors.purple,
              borderColor: Colors.grey.shade300,
              errorBuilder: (error) => Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber_rounded, size: 14, color: Colors.orange),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        error,
                        style: const TextStyle(fontSize: 12, color: Colors.deepOrange),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),
            // ── Validation demo ──────────────────────────────────────────
            const _SectionTitle('Required + Custom Validator'),
            _ValidationDemo(),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Helper widgets
// ─────────────────────────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}

class _OutputCard extends StatelessWidget {
  const _OutputCard({
    required this.nationalDigits,
    required this.isoCode,
    this.error,
  });

  final String nationalDigits;
  final String isoCode;
  final String? error;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final country = isoCode.isEmpty ? null : CountryModel.getByCode(isoCode);
    final full = country != null && nationalDigits.isNotEmpty ? '${country.dialCode}$nationalDigits' : '—';

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.primaryContainer.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cs.primaryContainer),
      ),
      child: Column(
        children: [
          _Row('Country', isoCode.isEmpty ? '—' : isoCode),
          _Row('National digits', nationalDigits.isEmpty ? '—' : nationalDigits),
          _Row('E.164', full),
          if (error != null) _Row('Error', error!, isError: true),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(this.label, this.value, {this.isError = false});
  final String label;
  final String value;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(label,
                style: const TextStyle(
                    fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w600)),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                color: isError ? Colors.red : null,
                fontWeight: isError ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ValidationDemo extends StatefulWidget {
  @override
  State<_ValidationDemo> createState() => _ValidationDemoState();
}

class _ValidationDemoState extends State<_ValidationDemo> {
  final _fieldKey = GlobalKey<SmartPhoneFieldState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SmartPhoneField(
          key: _fieldKey,
          isRequired: true,
          labelText: 'Validation Example',
          validator: (dialCode, digits) {
            if (digits.startsWith('0')) {
              return 'Number should not start with 0';
            }
            return null;
          },
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: () {
            final isValid = _fieldKey.currentState?.validateField() ?? false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(isValid ? 'Form is valid!' : 'Form has errors!'),
                backgroundColor: isValid ? Colors.green : Colors.red,
              ),
            );
          },
          icon: const Icon(Icons.check_circle_outline),
          label: const Text('Validate Manually'),
        ),
      ],
    );
  }
}
