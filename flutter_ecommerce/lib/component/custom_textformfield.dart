// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String hintText;
  final void Function(String?)? onSaved;

  final String? Function(String?)? validator;

  const CustomTextFormField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.onSaved,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: validator,
      decoration: InputDecoration(hintText: hintText, label: Text(label)),
    );
  }
}
