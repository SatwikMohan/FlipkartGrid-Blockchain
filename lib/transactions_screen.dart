import 'package:flutter/material.dart';

import 'models/test_models.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: userTest.transactionHistory.length,
        itemBuilder: (context, index) {
          final transaction = userTest.transactionHistory[index];
          return ListTile(
            title: Text(transaction.description),
            subtitle: Text(
              transaction.amount < 0
                  ? '-\$${transaction.amount.abs().toStringAsFixed(2)}'
                  : '+\$${transaction.amount.toStringAsFixed(2)}',
            ),
          );
        },
      ),
    );
  }
}
