import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flipgrid/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/brand.dart';

class ProductListView extends StatefulWidget {
  late String customerAddress;
  ProductListView(String customerAddress){
    this.customerAddress=customerAddress;
  }

  @override
  State<ProductListView> createState() => _ProductListViewState(customerAddress);
}

class _ProductListViewState extends State<ProductListView> {
  late String customerAddress;
  _ProductListViewState(String customerAddress){
    this.customerAddress=customerAddress;
  }
  List<Brand> products = [];
  void getProducts() async {
    final response =
        await FirebaseFirestore.instance.collection("Brands").get();
    setState(() {
      products = response.docs.map((e) => Brand.fromJson(e.data())).toList();
      for (var element in products) {
        print(element.toJson());
      }
    });
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        // itemCount: productsTest.length,
        itemCount: products.length,

        itemBuilder: (context, index) {
          return ProductCard(
            product: products[index], onTapDelete: null,customerAddress: customerAddress,
            // onTapDelete: null,
          );
          // return ProductCard(product: productsTest[index]);
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Brand product;
  // final bool inCart;
  late String customerAddress;
  final void Function()? onTapDelete;
  // final ProductTest product;
  ProductCard({super.key, required this.product, this.onTapDelete,required String customerAddress}){
    this.customerAddress=customerAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return ProductDetailsScreen(product: product,customerAddress:customerAddress);
          }));
        },
        child: ListTile(
          contentPadding: const EdgeInsets.all(15),
          leading: Image.network(
            product.PicUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
          title: Text(product.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.name),
              const Text("product.description"),
              const Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  Text("product.rating"),
                ],
              ),
            ],
          ),
          trailing: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "\$ ${product.CostETH}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTapDelete != null
                    ? Consumer(
                        builder: (BuildContext context, WidgetRef ref,
                            Widget? child) {
                          return IconButton(
                              onPressed: onTapDelete,
                              icon: const Icon(Icons.delete));
                        },
                      )
                    : const SizedBox.shrink()
              ]),
        ),
      ),
    );
  }
}
