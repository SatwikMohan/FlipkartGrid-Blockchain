import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flipgrid/login_signup/new_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
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
  final TextEditingController controller = TextEditingController();
  bool isLoading = false;
  // final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  bool loadingState = false;
  Client? client;
  Web3Client? ethClient;
  ServiceClass serviceClass = ServiceClass();

  void isReferralPresent(String referralCode) async {
    final QuerySnapshot<Map<String, dynamic>> response;
    response = await FirebaseFirestore.instance
        .collection("ReferalCodes")
        .where("Code", isEqualTo: referralCode)
        .get();
    print(response.docs.toString());
    print(response.docs.map((e) => e.data()));
    //return response.docs.map((e) => e.data());
  }

  // void showReferalDialog() {
  //
  //   final TextEditingController controller=TextEditingController();
  //   print('1');
  //   QuickAlert.show(
  //     context: context,
  //     type: QuickAlertType.success,
  //     barrierDismissible: true,
  //     title: "Use Referral Code",
  //     widget: Column(
  //       children: [
  //         TextInputWidget(
  //           controller: controller,
  //           texthint: 'Paste your referral code here',
  //           textInputType: TextInputType.text,
  //         )
  //       ],
  //     ),
  //     confirmBtnText: "Claim Reward!",
  //     onConfirmBtnTap: () {
  //      // isReferralPresent(controller.text);
  //       Navigator.pop(context);
  //     },
  //   );
  //   // TextEditingController textEditingController=TextEditingController();
  //   // Alert(
  //   //   context: context,
  //   //   type: AlertType.info,
  //   //   title: "Use Referral Code",
  //   //   desc: "Welcome to Flipkart Family",
  //   //   content: TextField(
  //   //     controller: textEditingController,
  //   //     decoration: InputDecoration(
  //   //       hintText: 'Paste your Referral Code Here'
  //   //     ),
  //   //   ),
  //   //   buttons: [
  //   //     DialogButton(
  //   //       child: Text(
  //   //         "Confirm",
  //   //         style: TextStyle(color: Colors.white, fontSize: 20),
  //   //       ),
  //   //       onPressed: () {
  //   //         isReferralPresent(textEditingController.text);
  //   //         Navigator.pop(context);
  //   //       },
  //   //       color: Color.fromRGBO(0, 179, 134, 1.0),
  //   //     ),
  //   //     DialogButton(
  //   //       child: Text(
  //   //         "Cancel",
  //   //         style: TextStyle(color: Colors.white, fontSize: 20),
  //   //       ),
  //   //       onPressed: () {
  //   //
  //   //       },
  //   //       gradient: LinearGradient(colors: [
  //   //         Color.fromRGBO(116, 116, 191, 1.0),
  //   //         Color.fromRGBO(52, 138, 199, 1.0)
  //   //       ]),
  //   //     )
  //   //   ],
  //   // ).show();
  // }

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

    // void showReferalDialog() {
    //   final TextEditingController controller=TextEditingController();
    //   print('1');
    //   QuickAlert.show(
    //     context: globalNavigatorKey.currentContext??context,
    //     type: QuickAlertType.confirm,
    //     barrierDismissible: true,
    //     title: "Use Referral Code",
    //     widget: Column(
    //       children: [
    //         TextInputWidget(
    //           controller: controller,
    //           texthint: 'Paste your referral code here',
    //           textInputType: TextInputType.text,
    //         )
    //       ],
    //     ),
    //     confirmBtnText: "Claim Reward!",
    //     onConfirmBtnTap: () {
    //       isReferralPresent(controller.text);
    //       Navigator.of(context).pop();
    //     },
    //     cancelBtnText: "Cancel",
    //     onCancelBtnTap: (){
    //       Navigator.of(context).pop();
    //     }
    //   );
    // }

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
                  'https://cdn.pixabay.com/photo/2022/06/25/13/33/landscape-7283516_640.jpg'),
              //image: AssetImage('assets/background.jpeg'),
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
                                        setState(() {
                                          isLoading = true;
                                        });
                                        final userCredential =
                                            await FirebaseAuth.instance
                                                .createUserWithEmailAndPassword(
                                                    email: emailTextController
                                                        .text,
                                                    password:
                                                        passwordTextController
                                                            .text);
                                        //await userCredential.user?.updatePhotoURL("FakeETHid");
                                        final newCustomer = Customer(
                                          name: userNameTextController.text,
                                          email: emailTextController.text,
                                          password: passwordTextController.text,
                                          customerAddress: ethidcontroller.text,
                                          tokens: 0,
                                          loginStreak: 0,
                                          lastLogin: DateTime.now().toString(),
                                          fbFollowed: false,
                                          instaFollowed: false,
                                          twitterFollowed: false,
                                        );
                                        print('outside');
                                        print(userCredential.user.toString());
                                        print(userCredential.toString());
                                        if (userCredential.user != null) {
                                          print('inside');
                                          await serviceClass.addCustomer(
                                              userNameTextController.text,
                                              emailTextController.text,
                                              passwordTextController.text,
                                              ethidcontroller.text,
                                              ethClient!);
                                          user.setCurrentUser = newCustomer;
                                          print(user.getCurrentUser.toString());
                                          await FirebaseFirestore.instance
                                              .collection("Customers")
                                              .doc(emailTextController.text)
                                              .set(
                                                  user.getCurrentUser.toJson());
                                          //.then((value){
                                          setState(() {
                                            print('inside set state');
                                            isLoading = false;
                                            print('loading off');
                                          });
                                          // showReferalDialog();
                                          // print('Dialog ran');
                                          // globalNavigatorKey.currentState.pushReplacement(MaterialPageRoute(builder: (){
                                          //
                                          // }));
                                          globalNavigatorKey.currentState
                                              ?.pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UserProfilePage(0,
                                                              true, context)),
                                                  (route) => false);
                                          // Navigator.pushReplacement(
                                          //   context,
                                          //     MaterialPageRoute(builder: (BuildContext context) => UserProfilePage(),
                                          //         )
                                          // );
                                          //  });
                                        } else {
                                          setState(() {
                                            isLoading = false;
                                          });
                                        }
                                      },
                                      child: const Text(
                                        'Sign Up',
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
