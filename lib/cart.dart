import 'package:flipgrid/main.dart';
import 'package:flipgrid/models/brand.dart';
import 'package:flipgrid/product_list_view.dart';
import 'package:flipgrid/services/functions.dart';
import 'package:flipgrid/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

final cartProductsProvider = Provider<List<Brand>>((ref) => []);

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  double totalAmount = 0;
  double userBalance = 0;
  Client? client;
  Web3Client? ethClient;
  List<Brand> cartProducts = [];
  @override
  void initState() {
    client = Client();
    ethClient = Web3Client(infura_url, client!);
    cartProducts = ref.read(cartProductsProvider);
    totalAmount = cartProducts.fold(0,
        (previousValue, element) => previousValue + int.parse(element.CostETH));
    userBalance =
        (ref.read(currentUserStateProvider).getCurrentUser.tokens) as double;
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
              ListView.builder(
                shrinkWrap: true,
                // itemCount: productsTest.length,
                itemCount: cartProducts.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: cartProducts[index],
                    onTapDelete: () {
                      setState(() {
                        cartProducts.remove(cartProducts[index]);
                      });
                    },
                  );
                  // return ProductCard(product: productsTest[index]);
                },
              ),
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
                        ServiceClass().buyUsingFungibleToken(
                            "0xE504F1aDE6B4d28ccFf9a29EE90cd5C82e16e55b",
                            ref
                                .read(currentUserStateProvider)
                                .getCurrentUser
                                .customerAddress,
                            totalAmount as int,
                            ethClient!);
                      }
                    : null,
                child: totalAmount <= userBalance
                    ? const Text('Buy Now')
                    : const Text("Insufficient Balance"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
