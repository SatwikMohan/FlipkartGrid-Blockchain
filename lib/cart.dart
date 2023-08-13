import 'package:flipgrid/main.dart';
import 'package:flipgrid/models/test_models.dart';
import 'package:flipgrid/product_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  double totalAmount = 0;
  double userBalance = 0;

  @override
  void initState() {
    totalAmount = products.fold(
        0, (previousValue, element) => previousValue + element.price);
    userBalance = (ref.read(currentUserStateProvider).getCurrentUser.tokens ??
        0) as double;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ProductListView(),
              Text(
                'Total Amount: ${totalAmount.toStringAsFixed(2)} tokens',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'Your Balance: ${userBalance.toStringAsFixed(2)} tokens',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: totalAmount <= userBalance
                    ? () {
                        // Buy Now logic
                        // You can implement your own logic here
                      }
                    : null,
                child: const Text('Buy Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
