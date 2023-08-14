import 'dart:js_interop';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flipgrid/main.dart';
import 'package:flutter/material.dart';
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
          Text("5 days streak!"),
          Text("You are awarded 1 SUPERCOINS"),
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
                  // "data:image/jpeg;base64,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"),
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
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.center,
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
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(20)),
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
                                  return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          // backgroundColor: Colors.purple,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 131, vertical: 20)),
                                      onPressed: () async {
                                        isLoading = true;
                                        final credential = await FirebaseAuth
                                            .instance
                                            .signInWithEmailAndPassword(
                                                email: emailTextController.text,
                                                password: passwordTextController
                                                    .text);
                                        List<dynamic> ethUserData;
                                        if (!credential.isNull) {
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
                                                      lastLogin: DateTime.now()
                                                          .toString());
                                              print(response);
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
                                              return const UserProfilePage();
                                            }));
                                          });
                                          isLoading = false;
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
                          Text(
                            "Earn - Buy - Repeat!",
                            style: GoogleFonts.actor(
                              textStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15),
                            ),
                          ),
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
