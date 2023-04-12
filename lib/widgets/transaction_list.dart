import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  const TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text(
                  'No Transactions added yet!',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                          child: Text('\$ ${transactions[index].amount}')),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: mediaQuery.size.width > 560
                      ? TextButton.icon(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            deleteTx(transactions[index]);
                          },
                          label: Text('Delete'),
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(
                                Theme.of(context).colorScheme.error),
                          ),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).colorScheme.error,
                          onPressed: () {
                            deleteTx(transactions[index]);
                          },
                        ),
                ),
              );
              // return Card(
              //   child: Row(children: [
              //     Container(
              //       padding: const EdgeInsets.all(10),
              //       margin: const EdgeInsets.symmetric(
              //           vertical: 10, horizontal: 15),
              //       decoration: BoxDecoration(
              //         border: Border.all(
              //             color: Theme.of(context).primaryColor,
              //             width: 2,
              //             style: BorderStyle.solid),
              //       ),
              //       child: Text(
              //         '\$ ${transactions[index].amount.toStringAsFixed(2)}',
              //         style: const TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 20,
              //           color: Colors.purple,
              //         ),
              //       ),
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           transactions[index].title,
              //           style: Theme.of(context).textTheme.titleMedium,
              //         ),
              //         Text(
              //           DateFormat.yMMMd().format(transactions[index].date),
              //           style: const TextStyle(
              //             color: Colors.grey,
              //             fontSize: 12,
              //           ),
              //         )
              //       ],
              //     )
              //   ]),
              // );
            },
            itemCount: transactions.length,
          );
  }
}
