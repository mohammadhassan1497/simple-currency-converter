import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final Function(Object?)? onChanged;
  final TextInputType? keyboardType;

  const TextFieldWidget({
    super.key,
    required this.labelText,
    this.onChanged,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!));
    return TextField(
      onChanged: onChanged,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.done,
      inputFormatters: [
        if (keyboardType ==
            const TextInputType.numberWithOptions(decimal: true))
          FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)'))
      ],
      decoration: InputDecoration(
        labelText: labelText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }
}
