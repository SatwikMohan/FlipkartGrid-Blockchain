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
                  widget.coupon.imageUrl,
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
                    widget.coupon.imageUrl,
                    fit: BoxFit.fill,
                  ),
                  onChange: (value) => print("Scratch progress: $value%"),
                  onThreshold: () async {

                    _controller.play();
                    await FirebaseFirestore.instance
                        .collection("Coupons")
                        .doc(ref
                        .read(currentUserStateProvider)
                        .getCurrentUser
                        .email)
                        .collection("UserCoupons")
                        .doc(widget.coupon.key)
                        .set(CouponsModel(
                      key: widget.coupon.key,
                      value: widget.coupon.value,
                      isClaimed: true,
                      creationDateTime: DateTime.now().toString(),
                      imageUrl: widget.coupon.imageUrl,
                    ).toJson());
                    final currentUser = ref.read(currentUserStateProvider);
                    await FirebaseFirestore.instance
                        .doc(currentUser.getCurrentUser.email)
                        .set(currentUser.getCurrentUser.toJson());
                    currentUser.setCurrentUser = currentUser.getCurrentUser
                        .copyWith(
                        tokens: currentUser.getCurrentUser.tokens +
                            widget.coupon.value);
                    await FirebaseFirestore.instance.collection("Customers")
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
                    await ServiceClass().mintLoyaltyPoints(
                      currentUser.getCurrentUser.email,
                      BigInt.from(widget.coupon.value),
                      ethClient!,
                    );



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
                          widget.coupon.imageUrl,
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
