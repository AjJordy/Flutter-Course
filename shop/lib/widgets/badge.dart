import 'package:flutter/material.dart';

class MyBadge extends StatelessWidget {
  const MyBadge({
    required this.child,
    required this.value,
    this.color,
    super.key,
  });

  final Widget child;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color != null
                  ? color
                  : Theme.of(context).colorScheme.secondary,
            ),
            constraints: BoxConstraints(
              minHeight: 16,
              minWidth: 16,
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
      ],
    );
  }
}
