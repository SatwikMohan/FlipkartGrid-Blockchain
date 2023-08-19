import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:flipgrid/main.dart';
import 'package:flipgrid/models/coupons_model.dart';
import 'package:flipgrid/models/transaction.dart';
import 'package:flipgrid/services/functions.dart';
import 'package:flipgrid/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:scratcher/widgets.dart';
import 'package:web3dart/web3dart.dart';

class MyScratchCard extends StatefulWidget {
  const MyScratchCard({super.key, required this.coupon});
  final CouponsModel coupon;

  @override
  _MyScratchCardState createState() => _MyScratchCardState();
}

class _MyScratchCardState extends State<MyScratchCard> {
  late ConfettiController _controller;
  Web3Client? ethClient;
  Client? client;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(
      duration: const Duration(seconds: 2),
    );
    client = Client();
    ethClient = Web3Client(infura_url, client!);
  }

  @override
  Widget build(BuildContext context) {
    return widget.coupon.isClaimed
        ? Container(
            height: 300,
            width: 300,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  "https://images.unsplash.com/photo-1574169208507-84376144848b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60",
                  fit: BoxFit.contain,
                  width: 150,
                  height: 150,
                ),
                Column(
                  children: [
                    ConfettiWidget(
                      blastDirectionality: BlastDirectionality.explosive,
                      confettiController: _controller,
                      particleDrag: 0.05,
                      emissionFrequency: 0.05,
                      numberOfParticles: 100,
                      gravity: 0.05,
                      shouldLoop: false,
                      colors: const [
                        Colors.green,
                        Colors.red,
                        Colors.yellow,
                        Colors.blue,
                      ],
                    ),
                    const Text(
                      "You won",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      "${widget.coupon.value} tokens",
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        : Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return Center(
                child: Scratcher(
                  brushSize: 50,
                  threshold: 60,
                  color: Colors.red,
                  image: Image.network(
                    "https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&w=1000&q=80",
                    fit: BoxFit.fill,
                  ),
                  onChange: (value) => print("Scratch progress: $value%"),
                  onThreshold: () async {
                    final currentUser = ref.read(currentUserStateProvider);
                    await ServiceClass().mintLoyaltyPoints(
                      currentUser.getCurrentUser.email,
                      widget.coupon.value,
                      ethClient!,
                    );
                    currentUser.setCurrentUser = currentUser.getCurrentUser
                        .copyWith(
                            tokens: currentUser.getCurrentUser.tokens +
                                widget.coupon.value);
                    FirebaseFirestore.instance
                        .doc(currentUser.getCurrentUser.email)
                        .set(currentUser.getCurrentUser.toJson());
                    final transaction = TransactionAppModel(
                        title: "Coupon Reward",
                        customerEmail: currentUser.getCurrentUser.email,
                        dateTime: DateTime.now(),
                        amountRecieved: null,
                        tokensRecieved: widget.coupon.value,
                        tokensSpent: null,
                        amountSpent: null,
                        senderAdress: null,
                        recieverAress:
                            currentUser.getCurrentUser.customerAddress);
                    await FirebaseFirestore.instance
                        .collection("Transactions")
                        .doc()
                        .set(transaction.toJson());
                    _controller.play();
                  },
                  child: Container(
                    height: 300,
                    width: 300,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          "https://images.unsplash.com/photo-1574169208507-84376144848b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60",
                          fit: BoxFit.contain,
                          width: 150,
                          height: 150,
                        ),
                        Column(
                          children: [
                            ConfettiWidget(
                              blastDirectionality:
                                  BlastDirectionality.explosive,
                              confettiController: _controller,
                              particleDrag: 0.05,
                              emissionFrequency: 0.05,
                              numberOfParticles: 100,
                              gravity: 0.05,
                              shouldLoop: false,
                              colors: const [
                                Colors.green,
                                Colors.red,
                                Colors.yellow,
                                Colors.blue,
                              ],
                            ),
                            const Text(
                              "You won",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 25,
                              ),
                            ),
                            Text(
                              "${widget.coupon.value} tokens",
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
