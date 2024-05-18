import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expenses/models/transactions.dart';
import 'package:expenses/utils/convert_values.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.tr,
    required this.onRemove,
  });

  final Transaction tr;
  final Function(String p1) onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      surfaceTintColor: Colors.white,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        // leading: CircleAvatar(
        //   radius: 30,
        //   backgroundColor: Theme.of(context).primaryColor,
        //   foregroundColor: Colors.white,
        //   child: Padding(
        //     padding: const EdgeInsets.all(8),
        //     child: FittedBox(
        //       child: Text("R\$${tr.value}"),
        //     ),
        //   ),
        // ),
        leading: SizedBox(
          width: 70,
          child: Text(
            convertValue(tr.value),
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          tr.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(DateFormat('d MMM y').format(tr.date)),
        trailing: MediaQuery.of(context).size.width > 480
            ? ElevatedButton.icon(
                onPressed: () => onRemove(tr.id),
                icon: const Icon(Icons.delete),
                label: const Text('Excluir'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
              )
            : IconButton(
                onPressed: () => onRemove(tr.id),
                icon: const Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
              ),
      ),
    );
  }
}
