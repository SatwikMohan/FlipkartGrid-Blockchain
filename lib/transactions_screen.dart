import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flipgrid/main.dart';
import 'package:flipgrid/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionScreen extends ConsumerStatefulWidget {
  const TransactionScreen({super.key});

  @override
  ConsumerState<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends ConsumerState<TransactionScreen> {
  List<TransactionAppModel> transactions = [];
  void getTransactionHistory() async {
    final response = await FirebaseFirestore.instance
        .collection("Transactions")
        .where("customerEmail",
            isEqualTo: ref.read(currentUserStateProvider).getCurrentUser.email)
        .get();
    setState(() {
      transactions = response.docs
          .map((e) => TransactionAppModel.fromJson(e.data()))
          .toList();
      for (var element in transactions) {
        print(element.toJson());
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return ListTile(
            title: Text(transaction.title),
            subtitle: Column(
              children: transaction
                  .toJson()
                  .entries
                  .map((e) => e.value != null
                      ? Text("${e.key} : ${e.value}")
                      : const SizedBox.shrink())
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
