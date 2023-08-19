// import 'package:flutter/material.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// import 'main.dart';
// import 'models/user.dart';

// class PaymentService {
  // void pay(int amount, Customer customer) {
  //   final razorpay = Razorpay();
  //   razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
  //   razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentFaliure);
  //   razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  //   var options = {
  //     'key': 'rzp_test_UuklICOwK0rFvs',
  //     'amount': amount * 100,
  //     'name': customer.name,
  //     'description': 'Bought Cart Items',
  //     'prefill': {'email': customer.email},
  //   };
  //   razorpay.open(options);
  // }

  // void handlePaymentSuccess(PaymentSuccessResponse response) {
  //   scaffoldMessengerKey.currentState
  //       ?.showSnackBar(const SnackBar(content: Text("Payment Successful")));
  // }

  // void handlePaymentFaliure(PaymentFailureResponse response) {
  //   scaffoldMessengerKey.currentState?.showSnackBar(
  //       SnackBar(content: Text(response.message ?? 'some error occured')));
  // }

  // void handleExternalWallet(ExternalWalletResponse response) {}
// }
