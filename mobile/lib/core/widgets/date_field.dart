import 'package:flutter/material.dart';

import '../format.dart';

/// Read-only field that opens a date picker; value is an ISO 'YYYY-MM-DD' string (or null).
class DateField extends StatelessWidget {
  const DateField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.firstDate,
    this.lastDate,
    this.clearable = false,
    this.errorText,
  });

  final String label;
  final String? value;
  final ValueChanged<String> onChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool clearable;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final initial = value != null ? parseIsoDate(value!) : DateTime.now();
        final picked = await showDatePicker(
          context: context,
          initialDate: initial,
          firstDate: firstDate ?? DateTime(1950),
          lastDate: lastDate ?? DateTime(2100),
        );
        if (picked != null) onChanged(isoDate(picked));
      },
      child: InputDecorator(
        decoration: InputDecoration(labelText: label, suffixIcon: const Icon(Icons.calendar_today_outlined), errorText: errorText),
        child: Text(value == null ? '' : formatDate(value!)),
      ),
    );
  }
}
