// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:http/http.dart' as http;

// const secretKey =
//     "sk_test_51MiM4vSHpSgMUUcXFqOT8j48lC5YYpvtblcRPrCLL8oPK63h1S6ZeG5nByxV5PccPS1a88wRJiM90M7xEgUnbKOU00kteDhG5S";
// const publishableKey =
//     "pk_test_51MiM4vSHpSgMUUcXOEAYjp7UUiMAMwXj0b984TspZ5TfEkRocNQlPiA7Yq0EZRic5leBXwUhgLBXB9DCXsB4aCOE00ysivF2gZ";

// Map<String, dynamic>? paymentIntent;
// Future<void> makePayment(int amount) async {
//   try {
//     //STEP 1: Create Payment Intent
//     paymentIntent = await createPaymentIntent(amount.toString(), 'INR');

//     //STEP 2: Initialize Payment Sheet
//     await Stripe.instance
//         .initPaymentSheet(
//             paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret:
//               paymentIntent!['client_secret'], //Gotten from payment intent
//           style: ThemeMode.light,
//         ))
//         .then((value) {});

//     //STEP 3: Display Payment sheet
//     displayPaymentSheet();
//   } catch (err) {
//     // print(err.toString());
//     print(1);
//     throw Exception(err);
//   }
// }

// calculateAmount(String amount) {
//   final calculatedAmout = (int.parse(amount)) * 100;
//   return calculatedAmout.toString();
// }

// createPaymentIntent(String amount, String currency) async {
//   try {
//     //Request body
//     Map<String, dynamic> body = {
//       'amount': calculateAmount(amount),
//       'currency': currency,
//     };

//     //Make post request to Stripe
//     var response = await http.post(
//       Uri.parse('https://api.stripe.com/v1/payment_intents'),
//       headers: {
//         'Authorization': 'Bearer $secretKey',
//         'Content-Type': 'application/x-www-form-urlencoded'
//       },
//       body: body,
//     );
//     return json.decode(response.body);
//   } catch (err) {
//     print(2);
//     throw Exception(err.toString());
//   }
// }

// displayPaymentSheet() async {
//   try {
//     await Stripe.instance.presentPaymentSheet().then((value) {
//       //Clear paymentIntent variable after successful payment
//       paymentIntent = null;
//     }).onError((error, stackTrace) {
//       throw Exception(error);
//     });
//   } on StripeException catch (e) {
//     print('Error is:---> $e');
//   } catch (e) {
//     print(3);
//     print('$e');
//   }
// }
