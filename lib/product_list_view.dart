import 'package:flipgrid/product_details.dart';
import 'package:flutter/material.dart';

import 'models/test_models.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
      body: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return ProductDetailsScreen(product: product);
            }));
          },
          child: ListTile(
            contentPadding: const EdgeInsets.all(15),
            leading: Image.network(
              product.image,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            title: Text(product.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.company),
                Text(product.description),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow),
                    Text('${product.rating}'),
                  ],
                ),
              ],
            ),
            trailing: Text(
              product.price.toString(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
