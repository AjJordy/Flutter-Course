import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expenses/models/transactions.dart';
import 'package:expenses/utils/convert_values.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    required Key key, // super.key,
    required this.tr,
    required this.onRemove,
  }) : super(key: key);

  final Transaction tr;
  final Function(String p1) onRemove;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  static final colors = [
    Colors.red[200],
    Colors.purple[200],
    Colors.orange[200],
    Colors.blue[200],
    Colors.green[200],
  ];

  late Color _backgroundColor;

  @override
  void initState() {
    super.initState();
    int i = Random().nextInt(5);
    _backgroundColor = colors[i]!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _backgroundColor,
      elevation: 5,
      surfaceTintColor: Colors.white,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        // leading: CircleAvatar(
        //   radius: 30,
        //   backgroundColor: _backgroundColor, // Theme.of(context).primaryColor,
        //   foregroundColor: Colors.white,
        //   child: Padding(
        //     padding: const EdgeInsets.all(8),
        //     child: FittedBox(
        //       child: Text("R\$${widget.tr.value}"),
        //     ),
        //   ),
        // ),
        leading: SizedBox(
          width: 70,
          child: Text(
            convertValue(widget.tr.value),
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          widget.tr.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(DateFormat('d MMM y').format(widget.tr.date)),
        trailing: MediaQuery.of(context).size.width > 480
            ? ElevatedButton.icon(
                onPressed: () => widget.onRemove(widget.tr.id),
                icon: const Icon(Icons.delete),
                label: const Text('Excluir'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
              )
            : IconButton(
                onPressed: () => widget.onRemove(widget.tr.id),
                icon: const Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
              ),
      ),
    );
  }
}
