import 'package:flipgrid/product_list_view.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  final double totalAmount = 150.0;
  final double userBalance = 200.0;

  const CartScreen({super.key});

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
              ProductListView(),
              Text(
                'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'Your Balance: \$${userBalance.toStringAsFixed(2)}',
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
