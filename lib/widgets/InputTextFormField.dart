import 'package:flutter/material.dart';

class InputTextFormField extends StatelessWidget {

  final keyboardType;
  final controller;
  final maxLength;
  final labelText;
  final defaultValidator;
  final inputFormatters;
  final onChange;

  const InputTextFormField({
    this.keyboardType,
    this.controller,
    this.maxLength,
    this.labelText,
    this.defaultValidator,
    this.inputFormatters,
    this.onChange
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      keyboardType: keyboardType,
      controller: controller,
      maxLength: maxLength,
        inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      validator: defaultValidator
    );
  }


}
