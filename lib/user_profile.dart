import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flipgrid/login_signup/new_login.dart';
import 'package:flipgrid/main.dart';
import 'package:flipgrid/my_coupons.dart';
import 'package:flipgrid/product_list_view.dart';
import 'package:flipgrid/services/EncryptionService.dart';
import 'package:flipgrid/services/functions.dart';
import 'package:flipgrid/share_screen.dart';
import 'package:flipgrid/text_field.dart';
import 'package:flipgrid/transactions_screen.dart';
import 'package:flipgrid/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:web3dart/web3dart.dart';

import 'follow_to_earn.dart';
import 'models/transaction.dart';
import 'models/user.dart';

class UserProfilePage extends ConsumerStatefulWidget {
  //const UserProfilePage({super.key, required});
  late bool isSignUp;
  late BuildContext c;
  late int dayDiff;

  UserProfilePage(int dayDiff, bool isSignUp, BuildContext c, {super.key}) {
    this.isSignUp = isSignUp;
    this.c = c;
    this.dayDiff = dayDiff;
  }

  @override
  ConsumerState<UserProfilePage> createState() =>
      _UserProfilePageState(dayDiff, isSignUp, c);
}

class _UserProfilePageState extends ConsumerState<UserProfilePage> {
  Client? client;
  Web3Client? ethClient;
  late bool isSignUp;
  late BuildContext c;
  late int dayDiff;
  bool isReloading = false;
  _UserProfilePageState(int dayDiff, bool isSignUp, BuildContext c) {
    this.isSignUp = isSignUp;
    this.c = c;
    this.dayDiff = dayDiff;
  }
  ServiceClass serviceClass = ServiceClass();
  EncryptionClass encryptionClass = EncryptionClass();

  void isReferralPresent(String referralCode) async {
    final QuerySnapshot<Map<String, dynamic>> response;
    response = await FirebaseFirestore.instance
        .collection("ReferalCodes")
        .where("Code", isEqualTo: referralCode)
        .get();
    print(response.docs.toString());
    print(response.docs.map((e) => e.data()));
    if (response.docs.isNotEmpty) {
      final user = ref.read(currentUserStateProvider);
      // late Map<String, dynamic> data;
      // response.docs.map((e) {
      //   data = e.data();
      // });
      // print(data['Code']);
      // print(data['SecretKey']);
      //String senderAddress=await encryptionClass.DecryptCode(data['Code'], data['SecretKey']);
      user.setCurrentUser = user.getCurrentUser.copyWith(
        tokens: user.getCurrentUser.tokens+1,
      );
      await FirebaseFirestore.instance
          .collection('Customers')
          .doc(user.getCurrentUser.email)
          .update({'tokens': user.getCurrentUser.tokens});
      await FirebaseFirestore.instance
          .collection("Customers")
          .where("customerAddress", isEqualTo: "0x89084484B22C7c398899b0f80E611057e27BccCd")
          .get().then((value) async{
            final data=await value.docs;
            data.forEach((element) async{
              await FirebaseFirestore.instance
                  .collection('Customers')
                  .doc(element['email'])
                  .update({'tokens': element['tokens']+1});
            });
      });
      await serviceClass.mintDailyCheckInLoyaltyPoints(
          "0x89084484B22C7c398899b0f80E611057e27BccCd", ethClient!);
      await serviceClass.mintDailyCheckInLoyaltyPoints(
          user.getCurrentUser.customerAddress, ethClient!);
      // final ethUserData =
      //     await serviceClass.getUserData(user.getCurrentUser.email, ethClient!);
      // user.setCurrentUser = user.getCurrentUser.copyWith(
      //     tokens: int.parse(ethUserData[0][5].toString()) ==
      //             user.getCurrentUser.tokens
      //         ? int.parse(ethUserData[0][5].toString()) + 1
      //         : int.parse(ethUserData[0][5].toString()));
      // user.setCurrentUser = user.getCurrentUser.copyWith(
      //   tokens: user.getCurrentUser.tokens+1,
      // );
      // await FirebaseFirestore.instance
      //     .collection('Customers')
      //     .doc(user.getCurrentUser.email)
      //     .update({'tokens': user.getCurrentUser.tokens});
      // if (int.parse(ethUserData[0][5].toString()) ==
      //     user.getCurrentUser.tokens) {
        final transaction = TransactionAppModel(
            dateTime: DateTime.now(),
            amountRecieved: null,
            tokensRecieved: 1,
            tokensSpent: null,
            amountSpent: null,
            senderAdress: null,
            recieverAress: user.getCurrentUser.customerAddress,
            customerEmail: user.getCurrentUser.email,
            title: 'daily login reward');
        await FirebaseFirestore.instance
            .collection("Transactions")
            .doc()
            .set(transaction.toJson());
      // }
    }
    //return response.docs.map((e) => e.data());
  }

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
      confirmBtnText: "OK",
      onConfirmBtnTap: () {
        Navigator.pop(context);
      },
      barrierDismissible: false,
    );
  }

  void showReferalDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    print('1');
    QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        barrierDismissible: false,
        title: "Use Referral Code",
        widget: Column(
          children: [
            TextInputWidget(
              controller: controller,
              texthint: 'Paste your referral code here',
              textInputType: TextInputType.text,
            )
          ],
        ),
        confirmBtnText: "Claim Reward!",
        onConfirmBtnTap: () {
          isReferralPresent(controller.text);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pop();
          });
        },
        cancelBtnText: "Cancel",
        onCancelBtnTap: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pop();
          });
        });
  }

  void showReferralSheet() {
    TextEditingController controller = TextEditingController();
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Use Referral Code'),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: controller,
                      decoration:
                          const InputDecoration(hintText: 'Paste Code Here'),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: GlowButton(
                            color: Colors.white,
                            splashColor: Colors.redAccent,
                            borderRadius: BorderRadius.circular(10),
                            width: 131,
                            child: const Text('Confirm'),
                            onPressed: () {
                              isReferralPresent(controller.text);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: GlowButton(
                            color: Colors.white,
                            splashColor: Colors.redAccent,
                            width: 140,
                            height: 40,
                            child: const Text('Close'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void decayTokenDialog() async {
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
    Future.delayed(Duration.zero).then((value) {
      if (isSignUp) {
        //showReferralSheet();
        showReferalDialog(context);
      }
      if (dayDiff == 1) {
        showDailyCheckInDialog();
      }
      if(dayDiff>=15){
        decayTokenDialog();
      }
    });
    super.initState();
  }

  TextEditingController transferAmountController = TextEditingController();
  TextEditingController friendEthIdController = TextEditingController();

  void showTransferDialog() async {
    await QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      title: "Transfer To Friend",
      widget: Column(
        children: [
          TextInputWidget(
              controller: transferAmountController,
              texthint: "Enter Amount",
              textInputType: TextInputType.number),
          const SizedBox(
            height: 8,
          ),
          TextInputWidget(
              controller: friendEthIdController,
              texthint: "Enter Reciever Id",
              textInputType: TextInputType.none),
        ],
      ),
      confirmBtnText: "Send Gift!",
      onConfirmBtnTap: ()async {
        final user = ref.read(currentUserStateProvider);
        user.setCurrentUser = user.getCurrentUser
            .copyWith(
            tokens:user.getCurrentUser.tokens -
                int.parse(transferAmountController.text) );
        await FirebaseFirestore.instance.collection('Customers').doc(user.getCurrentUser.email).update({
          'tokens':user.getCurrentUser.tokens
        });
        await FirebaseFirestore.instance
            .collection("Customers")
            .where("customerAddress", isEqualTo: friendEthIdController.text).get()
            .then((value) async{
          final data=await value.docs;
          data.forEach((element) async{
            await FirebaseFirestore.instance
                .collection('Customers')
                .doc(element['email'])
                .update({'tokens': element['tokens']+int.parse(transferAmountController.text)});
            final transaction = TransactionAppModel(
                title: "Token Transfer",
                customerEmail: element['email'],
                dateTime: DateTime.now(),
                amountRecieved: null,
                tokensRecieved: int.parse(transferAmountController.text),
                tokensSpent: null,
                amountSpent: null,
                senderAdress: user.getCurrentUser.customerAddress,
                recieverAress:element['customerAddress']);
            await FirebaseFirestore.instance
                .collection("Transactions")
                .doc()
                .set(transaction.toJson());
          });
        });
        final transaction = TransactionAppModel(
            title: "Token Transfer",
            customerEmail: user.getCurrentUser.email,
            dateTime: DateTime.now(),
            amountRecieved: null,
            tokensRecieved: null,
            tokensSpent: int.parse(transferAmountController.text),
            amountSpent: null,
            senderAdress: user.getCurrentUser.customerAddress,
            recieverAress:null);
        await FirebaseFirestore.instance
            .collection("Transactions")
            .doc()
            .set(transaction.toJson());
        Future.delayed(Duration(seconds: 3)).then((value){
          Navigator.pop(context);
        });
        await ServiceClass().transferToMyLoyalCustomer(friendEthIdController.text,
            BigInt.from(int.parse(transferAmountController.text)), ethClient!);
        Navigator.pop(context);
      },
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: IconButton(
          onPressed: () async {
            FirebaseAuth.instance.signOut();
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return const NewLogin();
            }));
          },
          icon: const Icon(Icons.logout)),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.replay_outlined),
          onPressed: () async {
            try {
              setState(() {
                isReloading = true;
              });
              final user = ref.read(currentUserStateProvider);
              final firebaseUserResponse = await FirebaseFirestore.instance
                  .collection("Customers")
                  .doc(user.getCurrentUser.email)
                  .get();

              final dbuserData = firebaseUserResponse.data();
              user.setCurrentUser = Customer.fromJson(dbuserData!);
              setState(() {
                isReloading = false;
              });
            } catch (e) {
              setState(() {
                isReloading = false;
              });
            }
          },
        ),
        title: const Text('User Profile'),
        backgroundColor: Colors.blue,
        actions: [
          GlowButton(
            color: Colors.white,
            splashColor: Colors.purple,
            borderRadius: BorderRadius.circular(10),
            width: 200,
            height: 40,
            onPressed: () {
              showTransferDialog();
            },
            child: const Text("Transfer Tokens"),
          ),
          const SizedBox(width: 13),
          Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final user = ref.watch(currentUserStateProvider).getCurrentUser;
            return Padding(
              padding: const EdgeInsets.all(12),
              child: GlowButton(
                  color: Colors.white,
                  splashColor: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10),
                  width: 140,
                  height: 40,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ProductListView(user.customerAddress);
                    }));
                  },
                  child: const Text(
                    "Start Shopping",
                    style: TextStyle(fontSize: 16),
                  )),
            );
          }),
        ],
      ),
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
            child: isReloading
                ? const CircularProgressIndicator()
                : Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      final user =
                          ref.watch(currentUserStateProvider).getCurrentUser;
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                    "https://pixabay.com/images/search/user/"),
                              ),
                              const SizedBox(height: 16),
                              GlowText(
                                user.name,
                                style: const TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              GlowText(
                                'Ethereum Wallet: ${user.customerAddress}',
                                style: const TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              GlowText(
                                'Your Tokens: ${user.tokens}',
                                style: const TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              GlowText(
                                'Login Streak: ${user.loginStreak}',
                                style: const TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 32),
                              // GlowButton(
                              //   color: Colors.white,
                              //   splashColor: Colors.purple,
                              //   borderRadius: BorderRadius.circular(10),
                              //   width: 200,
                              //   height: 40,
                              //   onPressed: () {
                              //     showTransferDialog();
                              //   },
                              //   child: const Text("Transfer Tokens"),
                              // ),
                              // const SizedBox(height: 10),
                              const FollowOnSocials(),
                              // ElevatedButton(
                              //     onPressed: () {
                              //       Navigator.push(context,
                              //           MaterialPageRoute(builder: (context) {
                              //         return ProductListView(user.customerAddress);
                              //       }));
                              //     },
                              //     child: const Text(
                              //       "Buy with points!",
                              //       style: TextStyle(fontSize: 16),
                              //     )),
                              const SizedBox(height: 8),
                              GlowButton(
                                color: Colors.white,
                                splashColor: Colors.purple,
                                borderRadius: BorderRadius.circular(10),
                                width: 200,
                                height: 40,
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const MyCoupons();
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  'My Coupons',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 8),
                              GlowButton(
                                color: Colors.white,
                                splashColor: Colors.purple,
                                borderRadius: BorderRadius.circular(10),
                                width: 200,
                                height: 40,
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const TransactionScreen();
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Transaction History',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 8),
                              GlowButton(
                                color: Colors.white,
                                splashColor: Colors.purple,
                                borderRadius: BorderRadius.circular(10),
                                width: 200,
                                height: 40,
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ShareScreen(
                                            user.customerAddress, user.email);
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Share with friends',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ]),
    );
  }
}
