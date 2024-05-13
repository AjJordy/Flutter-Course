import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transactions.dart';
import 'package:expenses/utils/convert_values.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(String) onRemove;
  const TransactionList(this.transactions, this.onRemove, {super.key});

  // String _convertValue(double value) {
  //   if (value > 1000) {
  //     return "R\$${value ~/ 1000}K";
  //   }
  //   return "R\$${value.toInt()}";
  // }

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: [
              Text(
                "Nenhuma transação cadastrada",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 50),
              Container(
                height: 300,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final tr = transactions[index];
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
                  leading: Container(
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
                  trailing: IconButton(
                    onPressed: () => onRemove(tr.id),
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              );
            },
          );
  }
}
