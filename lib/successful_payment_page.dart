import 'dart:ui';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class PaymentSuccessfulPage extends StatefulWidget {
  const PaymentSuccessfulPage({super.key});

  @override
  State<PaymentSuccessfulPage> createState() => _PaymentSuccessfulPageState();
}

class _PaymentSuccessfulPageState extends State<PaymentSuccessfulPage> {
  late ConfettiController _controller;

  @override
  void initState() {
    _controller = ConfettiController(
      duration: const Duration(seconds: 2),
    );
    Future.delayed(const Duration(microseconds: 100))
        .then((value) => _controller.play());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Successful'),
      ),
      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.all(
              //   Radius.circular(24),
              // ),
              image: DecorationImage(
                image: NetworkImage(
                    'https://cdn.pixabay.com/photo/2022/06/25/13/33/landscape-7283516_640.jpg'),
                // image: AssetImage('assets/background.jpeg'),
                fit: BoxFit.cover,
                opacity: 0.7,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                      size: 100,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Payment Successful',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Thank you for your payment!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // Implement any action you want, like navigating back to home screen.
                      },
                      child: const Text('Back to Home'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
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
          ),
        ],
      ),
    );
  }
}
