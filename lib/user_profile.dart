import 'package:flipgrid/product_list_view.dart';
import 'package:flipgrid/services/functions.dart';
import 'package:flipgrid/text_field.dart';
import 'package:flipgrid/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:web3dart/web3dart.dart';

import 'follow_to_earn.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key, required});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  Client? client;
  Web3Client? ethClient;
  @override
  void initState() {
    // TODO: implement initState
    client = Client();
    ethClient = Web3Client(infura_url, client!);
    super.initState();
  }

  final Usertest user = Usertest(
    name: 'John Doe',
    password: 'password123',
    userImage: 'https://example.com/user_image.jpg',
    ethereumWallet: '0xabc123def456...',
    loyaltyPoints: 500,
    loginStreakCount: 10,
    transactionHistory: [
      Transaction(description: 'Product A', amount: -50.0),
      Transaction(description: 'Product B', amount: -75.0),
      // Add more transactions here
    ],
  );

  TextEditingController transferAmountController = TextEditingController();
  TextEditingController friendEthIdController = TextEditingController();

  void showTransferDialog() async {
    await QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      title: "Transfer To Friend",
      widget: Column(
        children: [
          TextInputWidget(
              controller: transferAmountController,
              texthint: "Enter Amount",
              textInputType: TextInputType.number),
          const SizedBox(
            height: 8,
          ),
          TextInputWidget(
              controller: friendEthIdController,
              texthint: "Enter Reciever Id",
              textInputType: TextInputType.none),
        ],
      ),
      confirmBtnText: "Send Gift!",
      onConfirmBtnTap: () {
        ServiceClass().transferToMyLoyalCustomer(friendEthIdController.text,
            int.parse(transferAmountController.text), ethClient!);
        Navigator.pop(context);
      },
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user.userImage),
              ),
              const SizedBox(height: 16),
              Text(
                user.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Ethereum Wallet: ${user.ethereumWallet}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Loyalty Points: ${user.loyaltyPoints}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Login Streak: ${user.loginStreakCount}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  showTransferDialog();
                },
                child: const Text("Transfer Points"),
              ),
              const FollowOnSocials(),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Scaffold(body: ProductListView());
                    }));
                  },
                  child: const Text(
                    "Buy with points!",
                    style: TextStyle(fontSize: 16),
                  )),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return Scaffold(
                          appBar: AppBar(
                            title: const Text('Transaction History'),
                          ),
                          body: ListView.builder(
                            shrinkWrap: true,
                            itemCount: user.transactionHistory.length,
                            itemBuilder: (context, index) {
                              final transaction =
                                  user.transactionHistory[index];
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
                      },
                    ),
                  );
                },
                child: const Text(
                  'Transaction History:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Usertest {
  final String name;
  final String password;
  final String userImage;
  final String ethereumWallet;
  final int loyaltyPoints;
  final int loginStreakCount;
  final List<Transaction> transactionHistory;

  Usertest({
    required this.name,
    required this.password,
    required this.userImage,
    required this.ethereumWallet,
    required this.loyaltyPoints,
    required this.loginStreakCount,
    required this.transactionHistory,
  });
}

class Transaction {
  final String description;
  final double amount;

  Transaction({required this.description, required this.amount});
}
