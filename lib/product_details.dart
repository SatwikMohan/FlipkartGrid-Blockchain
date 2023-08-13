import 'package:flipgrid/cart.dart';
import 'package:flipgrid/models/brand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Brand product;

  // final ProductTest product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(product.PicUrl),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.name,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${product.CostETH} tokens',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "product.description",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      Text("product.rating"),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      return ElevatedButton(
                        onPressed: () {
                          ref.read(cartProductsProvider).add(product);
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const CartScreen();
                          }));
                          // Add product to cart logic
                          // You can implement your own logic here
                        },
                        child: const Text('Add to Cart'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
