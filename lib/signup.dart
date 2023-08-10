import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../text_field.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController userNameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController ethidcontroller = TextEditingController();
  // final TextEditingController confirmPasswordTextController =
  //     TextEditingController();
  bool loadingState = false;

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
              height: height * 0.2,
              alignment: Alignment.center,
              child: const Text(
                'Get Started!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: height * 0.8,
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
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.05),
                    ),
                    TextInputWidget(
                      controller: userNameTextController,
                      texthint: "Enter User Name",
                      textInputType: TextInputType.name,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.5 * 0.05),
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
                    // TextInputWidget(
                    //   controller: confirmPasswordTextController,
                    //   texthint: "Confirm Password",
                    //   textInputType: TextInputType.text,
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.only(top: height * 0.5 * 0.1),
                    // ),
                    TextInputWidget(
                      controller: ethidcontroller,
                      texthint: "Enter ETH Id",
                      textInputType: TextInputType.text,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.5 * 0.1),
                    ),
                    loadingState
                        ? const SpinKitSpinningLines(
                            color: Colors.lightBlue,
                            size: 32,
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  //TODO : IMPLEMENT LOGIN
                                  // registerScreenVM.emailRegister();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: width * 0.55,
                                  padding: EdgeInsets.symmetric(
                                    // horizontal: width * 0.2,
                                    vertical: height * 0.5 * 0.04,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16),
                                    ),
                                  ),
                                  child: const Text(
                                    'Sign Up',
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
                              //     onTap: () {
                              //       registerScreenVM.googleRegister();
                              //     },
                              //     child: const ButtonBox(
                              //         imagePath: 'lib/images/google.png')),
                            ],
                          ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already Have An Account?',
                            style: TextStyle(color: Colors.black),
                          ),
                          const Padding(padding: EdgeInsets.only(right: 8)),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                return const LoginScreen();
                              }));
                            },
                            child: const Text(
                              'Login',
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
