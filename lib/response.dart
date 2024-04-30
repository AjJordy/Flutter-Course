import 'package:flutter/material.dart';

class Response extends StatelessWidget {
  final String text;
  final void Function() onSelection;

  const Response(this.text, this.onSelection, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      height: 40,
      child: ElevatedButton(
        onPressed: onSelection,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        child: Text(text),
      ),
    );
  }
}
