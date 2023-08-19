import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flipgrid/login_signup/new_signup.dart';
import 'package:flipgrid/main.dart';
import 'package:flipgrid/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:web3dart/web3dart.dart';

import '../models/user.dart';
import '../services/functions.dart';
import '../user_profile.dart';
import '../utils/constants.dart';
import 'auth_input_text.dart';

class NewLogin extends StatefulWidget {
  const NewLogin({super.key});

  @override
  State<NewLogin> createState() => _NewLoginState();
}

class _NewLoginState extends State<NewLogin> {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  bool isLoading = false;

  bool loadingState = false;
  Client? client;
  Web3Client? ethClient;
  ServiceClass serviceClass = ServiceClass();

  void showDailyCheckInDialog() async {
    await QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: "Daily Check Reward",
      widget: const Column(
        children: [
          Text("Daily streak!"),
          Text("You are awarded 1 Token"),
          Text("Come back again for more!"),
        ],
      ),
      confirmBtnText: "Claim Reward!",
      onConfirmBtnTap: () {
        Navigator.pop(context);
      },
      barrierDismissible: false,
    );
  }

  void decayTokenDialog() async{
    await QuickAlert.show(
      context: context,
      type: QuickAlertType.warning,
      title: "Decay Token Alert",
      widget: const Column(
        children: [
          Text("You lost a few tokens due to inactivity"),
        ],
      ),
      confirmBtnText: "Ok",
      onConfirmBtnTap: () {
        Navigator.pop(context);
      },
      barrierDismissible: false,
    );
  }

  @override
  void initState() {
    client = Client();
    ethClient = Web3Client(infura_url, client!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(children: [
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
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6_exHmF8VzFYReizoVMZAA3eDp6NSgY0-Xw&usqp=CAU'),
              fit: BoxFit.cover,
              opacity: 0.7,
            ),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: SafeArea(
            child: Center(
              child: isLoading
                  ? const CircularProgressIndicator()
                  : SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Text(
                            "Login To Continue",
                            style: GoogleFonts.pacifico(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 280,
                            width: MediaQuery.of(context).size.width / 1.1 < 500
                                ? MediaQuery.of(context).size.width / 1.1
                                : 500,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 20, top: 20),
                                  child: AuthInputText(
                                    textEditingController: emailTextController,
                                    hintText: "enter email here",
                                    labelText: "Email",
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: AuthInputText(
                                    textEditingController:
                                        passwordTextController,
                                    labelText: "Password",
                                    hintText: "********",
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Consumer(builder: (BuildContext context,
                                    WidgetRef ref, Widget? child) {
                                  final user =
                                      ref.watch(currentUserStateProvider);
                                  return GlowButton(
                                    color: Colors.white,
                                      splashColor: Colors.blue,
                                      borderRadius: BorderRadius.circular(10),
                                      width: 131,
                                      // style: ElevatedButton.styleFrom(
                                      //     shape: RoundedRectangleBorder(
                                      //         borderRadius:
                                      //             BorderRadius.circular(10.0)),
                                      //     // backgroundColor: Colors.purple,
                                      //     padding: const EdgeInsets.symmetric(
                                      //         horizontal: 131, vertical: 20)),
                                      onPressed: () async {
                                        // setState(() {
                                        //   isLoading = true;
                                        // });
                                        final credential = await FirebaseAuth
                                            .instance
                                            .signInWithEmailAndPassword(
                                                email: emailTextController.text,
                                                password: passwordTextController
                                                    .text);
                                        List<dynamic> ethUserData;
                                        if (credential.user != null) {
                                          final firebaseUserResponse =
                                              await FirebaseFirestore.instance
                                                  .collection("Customers")
                                                  .doc(emailTextController.text)
                                                  .get();

                                          final dbuserData =
                                              firebaseUserResponse.data();
                                          if (dbuserData?.isNotEmpty ?? false) {
                                            // user.setCurrentUser = Customer(
                                            //   name: userData[0][0],
                                            //   email: userData[0][0],
                                            //   password: userData[0][0],
                                            //   customerAddress: userData[0][0],
                                            //   loginStreak: null,
                                            //   tokens: null,
                                            // );
                                            user.setCurrentUser =
                                                Customer.fromJson(dbuserData!);
                                            print(
                                                "firebase data : ${user.getCurrentUser.toJson()}");
                                          }
                                          ethUserData =
                                              await serviceClass.getUserData(
                                                  emailTextController.text,
                                                  ethClient!);
                                          user.setCurrentUser =
                                              user.getCurrentUser.copyWith(
                                                  tokens: int.parse(
                                                      ethUserData[0][5]
                                                          .toString()));

                                          print(ethUserData[0].toString());

                                          final String lastDateTimeString =
                                              user.getCurrentUser.lastLogin;
                                          if (lastDateTimeString.isNotEmpty) {
                                            final lastdatetime = DateTime.parse(
                                                lastDateTimeString);
                                            final currentDateTime =
                                                DateTime.now();
                                            final dayDifference =
                                                currentDateTime
                                                    .difference(lastdatetime)
                                                    .inDays;
                                            print(dayDifference);
                                            if (dayDifference == 1) {
                                              showDailyCheckInDialog();
                                              user.setCurrentUser =
                                                  user.getCurrentUser.copyWith(
                                                      tokens: user
                                                              .getCurrentUser
                                                              .tokens +
                                                          1);
                                              final response = await serviceClass
                                                  .mintDailyCheckInLoyaltyPoints(
                                                      ethUserData[0][3]
                                                          .toString(),
                                                      ethClient!);
                                              user.setCurrentUser =
                                                  user.getCurrentUser.copyWith(
                                                      lastLogin: currentDateTime
                                                          .toString());
                                              final transaction =
                                                  TransactionAppModel(
                                                      dateTime: currentDateTime,
                                                      amountRecieved: null,
                                                      tokensRecieved: 1,
                                                      tokensSpent: null,
                                                      amountSpent: null,
                                                      senderAdress: null,
                                                      recieverAress: user
                                                          .getCurrentUser
                                                          .customerAddress,
                                                      customerEmail: user
                                                          .getCurrentUser.email,
                                                      title:
                                                          'daily login reward');
                                              await FirebaseFirestore.instance
                                                  .collection("Transactions")
                                                  .doc()
                                                  .set(transaction.toJson());
                                              print(response);
                                            }
                                            if(dayDifference>=15){
                                              user.setCurrentUser =
                                                  user.getCurrentUser.copyWith(
                                                      lastLogin: currentDateTime
                                                          .toString());
                                              int loss=user.getCurrentUser.tokens/15 as int;
                                              await serviceClass.decayTokens(user.getCurrentUser.customerAddress, BigInt.from(loss), ethClient!);
                                              decayTokenDialog();
                                              user.setCurrentUser =
                                                  user.getCurrentUser.copyWith(
                                                      tokens: user
                                                          .getCurrentUser
                                                          .tokens -
                                                          loss);
                                            }
                                          }
                                          await FirebaseFirestore.instance
                                              .collection("Customers")
                                              .doc(emailTextController.text)
                                              .set(user.getCurrentUser.toJson())
                                              .then((value) {
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                              return UserProfilePage(
                                                  false, context);
                                            }));
                                          });

                                          // setState(() {
                                          //   isLoading = false;
                                          // });
                                        }
                                      },
                                      child: const Text(
                                        'Log In',
                                        style: TextStyle(fontSize: 17),
                                      ));
                                })
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Column(children: [
                            Text(
                              "Earn - Buy - Repeat!",
                              style: GoogleFonts.actor(
                                textStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15),
                              ),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "New Here? ",
                                    style: GoogleFonts.actor(
                                      textStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.8),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 15),
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(builder:
                                                (BuildContext context) {
                                          return const NewSignUp();
                                        }));
                                      },
                                      child: const Text(
                                        "Get Started!",
                                        style: TextStyle(color: Colors.blue),
                                      ))
                                ]),
                          ]),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ]),
    );
  }
}
