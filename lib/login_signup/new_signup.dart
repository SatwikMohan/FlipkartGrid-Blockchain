import 'dart:js_interop';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flipgrid/login_signup/new_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:web3dart/web3dart.dart';

import '../main.dart';
import '../models/user.dart';
import '../services/functions.dart';
import '../user_profile.dart';
import '../utils/constants.dart';
import 'auth_input_text.dart';

class NewSignUp extends StatefulWidget {
  const NewSignUp({super.key});

  @override
  State<NewSignUp> createState() => _NewSignUpState();
}

class _NewSignUpState extends State<NewSignUp> {
  final TextEditingController userNameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController ethidcontroller = TextEditingController();
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
                            "Let's Get Started",
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
                            height: 380,
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
                                      left: 20, right: 20, top: 15),
                                  child: AuthInputText(
                                    textEditingController:
                                        userNameTextController,
                                    labelText: "User Name",
                                    hintText: "",
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 15),
                                  child: AuthInputText(
                                    textEditingController: emailTextController,
                                    hintText: "enter email here",
                                    labelText: "Email",
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 15),
                                  child: AuthInputText(
                                    textEditingController:
                                        passwordTextController,
                                    labelText: "Password",
                                    hintText: "********",
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 15),
                                  child: AuthInputText(
                                    textEditingController: ethidcontroller,
                                    labelText: "Eth Id",
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
                                        final userCredential =
                                            await FirebaseAuth.instance
                                                .createUserWithEmailAndPassword(
                                                    email: emailTextController
                                                        .text,
                                                    password:
                                                        passwordTextController
                                                            .text);
                                        await userCredential.user
                                            ?.updatePhotoURL("FakeETHid");
                                        final newCustomer = Customer(
                                            name: userNameTextController.text,
                                            email: emailTextController.text,
                                            password:
                                                passwordTextController.text,
                                            customerAddress:
                                                ethidcontroller.text,
                                            tokens: 0,
                                            loginStreak: 0,
                                            lastLogin:
                                                DateTime.now().toString());
                                        if (!userCredential.isNull) {
                                          serviceClass.addCustomer(
                                              userNameTextController.text,
                                              emailTextController.text,
                                              passwordTextController.text,
                                              ethidcontroller.text,
                                              ethClient!);
                                          user.setCurrentUser = newCustomer;
                                          FirebaseFirestore.instance
                                              .collection("Customers")
                                              .doc(emailTextController.text)
                                              .set(newCustomer.toJson())
                                              .then((value) =>
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                    return const UserProfilePage();
                                                  })));

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
                                    "Already A Member? ",
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
                                          return const NewLogin();
                                        }));
                                      },
                                      child: const Text(
                                        "LoginHere!",
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
