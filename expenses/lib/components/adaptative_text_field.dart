import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Function(String)? onSubmitted;
  final TextInputType? keyboardType;

  const AdaptativeTextField({
    required this.label,
    required this.controller,
    this.onSubmitted,
    this.keyboardType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: CupertinoTextField(
          controller: controller,
          keyboardType: keyboardType,
          onSubmitted: onSubmitted,
          placeholder: label,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
        ),
      );
    } else {
      return TextField(
        controller: controller,
        keyboardType: keyboardType,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(labelText: label),
      );
    }
  }
}
