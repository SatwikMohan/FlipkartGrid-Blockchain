import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flipgrid/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web3dart/web3dart.dart';

import '../services/functions.dart';
import '../utils/constants.dart';

Future<void> _launchSocialMediaAppIfInstalled({
  required String url,
}) async {
  try {
    bool launched =
        await launch(url, forceSafariVC: false); // Launch the app if installed!

    if (!launched) {
      launch(url); // Launch web view if app is not installed!
    }
  } catch (e) {
    launch(url); // Launch web view if app is not installed!
  }
}

const List<String> socialMediaUrls = [
  "https://www.facebook.com/avinave.agrwal/",
  "https://www.facebook.com/avinave.agrwal/",
  "https://www.facebook.com/avinave.agrwal/",
];
const List<String> socialMediaPlatforms = ["Instagram", "Facebook", "Twitter"];

class FollowToEarn extends StatefulWidget {
  // final String title;
  const FollowToEarn({super.key});

  @override
  State<FollowToEarn> createState() => _FollowToEarnState();
}

class _FollowToEarnState extends State<FollowToEarn> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: width * 0.6,
          height: height * 0.6,
          child: const SingleChildScrollView(child: FollowOnSocials()),
        ),
      ),
    );
  }
}

class FollowOnSocials extends StatefulWidget {
  const FollowOnSocials({super.key});

  @override
  State<FollowOnSocials> createState() => _FollowOnSocialsState();
}

class _FollowOnSocialsState extends State<FollowOnSocials> {
  Client? client;
  Web3Client? ethClient;

  @override
  void initState() {
    client = Client();
    ethClient = Web3Client(infura_url, client!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Follow Us On : "),
        const Padding(padding: EdgeInsets.only(top: 8)),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Column(children: [
                Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    final user =
                        ref.read(currentUserStateProvider).getCurrentUser;
                    return ElevatedButton(
                      onPressed: () async {
                        _launchSocialMediaAppIfInstalled(
                            url: socialMediaUrls[index]);
                        if (user.instaFollowed && index == 0) {
                          ref.read(currentUserStateProvider).setCurrentUser =
                              ref
                                  .read(currentUserStateProvider)
                                  .getCurrentUser
                                  .copyWith(instaFollowed: true);
                          ServiceClass().mintDailyCheckInLoyaltyPoints(
                              user.customerAddress, ethClient!);
                          await FirebaseFirestore.instance
                              .collection("Customers")
                              .doc(user.email)
                              .set(user.toJson());
                        } else if (user.fbFollowed && index == 1) {
                          ref.read(currentUserStateProvider).setCurrentUser =
                              ref
                                  .read(currentUserStateProvider)
                                  .getCurrentUser
                                  .copyWith(fbFollowed: true);
                          ServiceClass().mintDailyCheckInLoyaltyPoints(
                              user.customerAddress, ethClient!);
                          await FirebaseFirestore.instance
                              .collection("Customers")
                              .doc(user.email)
                              .set(user.toJson());
                        } else if (user.twitterFollowed && index == 2) {
                          ref.read(currentUserStateProvider).setCurrentUser =
                              ref
                                  .read(currentUserStateProvider)
                                  .getCurrentUser
                                  .copyWith(twitterFollowed: true);
                          ServiceClass().mintDailyCheckInLoyaltyPoints(
                              user.customerAddress, ethClient!);
                          await FirebaseFirestore.instance
                              .collection("Customers")
                              .doc(user.email)
                              .set(user.toJson());
                        }
                      },
                      child: Text(socialMediaPlatforms[index]),
                    );
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 8)),
              ]);
            })
      ],
    );
  }
}
