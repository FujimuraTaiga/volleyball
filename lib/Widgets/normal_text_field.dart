import 'package:flutter/material.dart';

class NormalTextField extends StatelessWidget {

  const NormalTextField({
    Key? key,
    required this.controller,
    this.hint,
    this.label
  }) : super(key: key);

  final TextEditingController controller;
  final String? hint;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
