import 'package:flutter/material.dart';

class ProductListView extends StatelessWidget {
  final List<Product> products = [
    Product(
      name: 'Product 1',
      company: 'Company A',
      price: '\$19.99',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      rating: 4.5,
      image:
          'https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510_1280.jpg',
    ),
    Product(
      name: 'Product 2',
      company: 'Company B',
      price: '\$29.99',
      description:
          'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      rating: 4.0,
      image:
          'https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510_1280.jpg',
    ),
    // Add more products as needed
  ];

  ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}

class Product {
  final String name;
  final String company;
  final String price;
  final String description;
  final double rating;
  final String image;

  Product({
    required this.name,
    required this.company,
    required this.price,
    required this.description,
    required this.rating,
    required this.image,
  });
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
          product.price,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
