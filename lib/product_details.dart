import 'dart:html';

import 'package:flipgrid/cart.dart';
import 'package:flipgrid/models/brand.dart';
import 'package:flipgrid/services/functions.dart';
import 'package:flipgrid/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Brand product;

  // final ProductTest product;
  late String customerAddress;

  ProductDetailsScreen(
      {super.key, required this.product, required String customerAddress}) {
    this.customerAddress = customerAddress;
  }
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailScreenState(product,customerAddress);
}

class _ProductDetailScreenState extends State<ProductDetailsScreen>{

  late Brand product;
  late String customerAddress;
  _ProductDetailScreenState(Brand product,String customerAddress){
    this.product=product;
    this.customerAddress=customerAddress;
  }

  bool loyalty=false;
  ServiceClass serviceClass=ServiceClass();
  void process() async{
    Client? client=Client();
    Web3Client ethClient=Web3Client(infura_url, client);
    var res=await serviceClass.getBrandAddress(product.email!, ethClient);
    String brandAddress=res[0].toString();
    var response=await serviceClass.isCustomerMyLoyalCustomer(brandAddress, customerAddress, ethClient);
    setState(() {
      loyalty=bool.parse(response[0].toString());
      product = product.copyWith(isuserloyaltobrand : loyalty);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    process();
    super.initState();
  }



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
                    product.email!,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$ ${product.CostETH}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      Text(product.rating),
                    ],
                  ),
                  const SizedBox(height: 9),

                  !loyalty?Text('Become Our loyal customer by buying our products worth at leat \$ 10')
                      :ElevatedButton(onPressed: (){

                  },
                      child:Text('Use tokens to get Discount') ),

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
