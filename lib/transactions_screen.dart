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
    getTransactionHistory();
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
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Text(
                    transaction.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: transaction
                        .toJson()
                        .entries
                        .map((e) => e.value != null && e.key != "title"
                            ? Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Text("${e.key} : ${e.value}"))
                            : const SizedBox.shrink())
                        .toList(),
                  ),
                ],
                // contentPadding: const EdgeInsets.all(15),
                // title: Text(transaction.title),
                // titleAlignment: ListTileTitleAlignment.center,
                // titleTextStyle: const TextStyle(fontWeight: FontWeight.bold),
                // subtitle: Column(
                //   children: transaction
                //       .toJson()
                //       .entries
                //       .map((e) => e.value != null && e.key != "title"
                //           ? Text("${e.key} : ${e.value}")
                //           : const SizedBox.shrink())
                //       .toList(),
                // ),
              ),
            ),
          );
        },
      ),
    );
  }
}
