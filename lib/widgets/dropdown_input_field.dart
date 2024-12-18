import 'package:flutter/material.dart';

class DropdownInputField<T> extends StatelessWidget {
  const DropdownInputField({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.labelText,
  });

  final T value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText),
        const SizedBox(height: 8.0),
        DropdownButton<T>(
          value: value,
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item.toString().split('.').last.toUpperCase()),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}


