import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flipgrid/login_signup/signup.dart';
import 'package:flipgrid/services/functions.dart';
import 'package:flipgrid/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:web3dart/web3dart.dart';

import '../text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userNameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController =
      TextEditingController();
  final TextEditingController ethidcontroller = TextEditingController();

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
          Text("You are awarded 2 SUPERCOINS"),
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
    // TODO: implement initState
    client = Client();
    ethClient = Web3Client(infura_url, client!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: height * 0.3,
              alignment: Alignment.center,
              child: const Text(
                'Get Well Soon!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: height * 0.7,
                padding: EdgeInsets.only(
                  right: width * 0.1,
                  left: width * 0.1,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.05),
                    ),
                    TextInputWidget(
                      controller: emailTextController,
                      texthint: "Enter Email",
                      textInputType: TextInputType.emailAddress,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.5 * 0.05),
                    ),
                    TextInputWidget(
                      controller: passwordTextController,
                      texthint: "Enter Password",
                      textInputType: TextInputType.text,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.5 * 0.05),
                    ),
                    TextInputWidget(
                      controller: ethidcontroller,
                      texthint: "Enter ETH id",
                      textInputType: TextInputType.text,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.5 * 0.1),
                    ),
                    loadingState
                        // ignore: dead_code
                        ? const SpinKitSpinningLines(
                            color: Colors.purple,
                            size: 64,
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  final credential = await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: emailTextController.text,
                                          password:
                                              passwordTextController.text);
                                  List<dynamic> userData;
                                  if (!credential.isNull) {
                                    userData = await serviceClass.getUserData(
                                        emailTextController.text, ethClient!);
                                    print(userData);
                                    final lastDateTimeresponse =
                                        await FirebaseFirestore.instance
                                            .collection("lastLogin")
                                            .doc(userData[0][1])
                                            .get();
                                    final lastDateTimeString =
                                        lastDateTimeresponse
                                            .data()?["lastLogin"];
                                    if (lastDateTimeString.length != 0) {
                                      final lastdatetime =
                                          DateTime.parse(lastDateTimeString);
                                      final currentDateTime = DateTime.now();
                                      final dayDifference = currentDateTime
                                          .difference(lastdatetime)
                                          .inDays;
                                      print(dayDifference);
                                      if (dayDifference == 1) {
                                        showDailyCheckInDialog();
                                        final response = await serviceClass
                                            .mintDailyCheckInLoyaltyPoints(
                                                userData[0][3].toString(),
                                                ethClient!);
                                        print(response);
                                      }
                                    }
                                    await FirebaseFirestore.instance
                                        .collection("lastLogin")
                                        .doc(userData[0][1])
                                        .set({
                                      "lastLogin": DateTime.now().toString()
                                    });
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: width * 0.55,
                                  padding: EdgeInsets.symmetric(
                                    // horizontal: width * 0.2,
                                    vertical: height * 0.5 * 0.05,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16),
                                    ),
                                  ),
                                  child: const Text(
                                    'Sign In',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              // Padding(
                              //     padding:
                              //         EdgeInsets.only(left: width * 0.06)),
                              // GestureDetector(
                              //     onTap: loginScreenVM.googleLogin,
                              //     child: const ButtonBox(
                              //         imagePath: 'lib/images/google.png')),
                            ],
                          ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'New Here?',
                            style: TextStyle(color: Colors.black),
                          ),
                          const Padding(padding: EdgeInsets.only(right: 8)),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                return const RegisterScreen();
                              }));
                            },
                            child: const Text(
                              'Create Account',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
