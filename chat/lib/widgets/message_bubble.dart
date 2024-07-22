import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  // final Key? key;
  final String message;
  final bool belongsToMe;

  const MessageBubble(this.message, this.belongsToMe, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          belongsToMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: belongsToMe
                ? Colors.grey[300]
                : Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft: belongsToMe
                  ? const Radius.circular(12)
                  : const Radius.circular(0),
              bottomRight: belongsToMe
                  ? const Radius.circular(0)
                  : const Radius.circular(12),
            ),
          ),
          width: 140,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: Text(
            message,
            style: TextStyle(
              color: belongsToMe
                  ? Colors.black
                  : Theme.of(context).colorScheme.surface,
            ),
          ),
        ),
      ],
    );
  }
}
