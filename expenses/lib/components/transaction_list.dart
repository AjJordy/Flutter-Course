import 'package:flutter/material.dart';
import 'package:expenses/components/transaction_item.dart';
import 'package:expenses/models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(String) onRemove;
  const TransactionList(this.transactions, this.onRemove, {super.key});

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return LayoutBuilder(
        builder: (ctx, constraints) {
          return Column(
            children: [
              const SizedBox(height: 20),
              Text(
                "Nenhuma transação cadastrada",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: constraints.maxHeight * 0.6,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          );
        },
      );
    } else {
      return ListView(
        children: transactions.map((tr) {
          return TransactionItem(
            key: ValueKey(tr.id), // UniqueKey(),
            tr: tr,
            onRemove: onRemove,
          );
        }).toList(),
      );
      // return ListView.builder(
      //   itemCount: transactions.length,
      //   itemBuilder: (context, index) {
      //     final tr = transactions[index];
      //     return TransactionItem(
      //       key: GlobalObjectKey(tr), // worst
      //       tr: tr,
      //       onRemove: onRemove,
      //     );
      //   },
      // );
    }
  }
}
