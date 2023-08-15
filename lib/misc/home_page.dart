import 'dart:ui';

import 'package:flipgrid/follow_to_earn.dart';
import 'package:flipgrid/main.dart';
import 'package:flipgrid/product_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final employeeModel = ref.watch(currentUserStateProvider).getCurrentUser;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: IconButton(
          onPressed: () {
            //TODO: implement logout
            // ref.read(homeScreenVMProvider).logout(context);
          },
          icon: const Icon(Icons.logout)),
      body: LiquidPullToRefresh(
        animSpeedFactor: 2,
        showChildOpacityTransition: false,
        onRefresh: () {
          return Future.delayed(Duration.zero);
          //TODO: Implement refresh logic
          // return ref.read(homeScreenVMProvider).refreshCurrentUserState();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 24,
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: SizedBox(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.075),
                    ),
                    ClipOval(
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(height * 0.125), // Image radius
                        child: Image.network(
                            'https://cdn.pixabay.com/photo/2016/03/05/23/02/blur-1239439_960_720.jpg',
                            fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.025),
                    ),
                    Text(
                      employeeModel.name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.0125),
                    ),
                    Text(
                      employeeModel.customerAddress,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text("Loyality Points : "),
                      Text(
                        employeeModel.tokens.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ]),
                    // const FollowToEarn(),
                    const FollowOnSocials(),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const Scaffold(body: ProductListView());
                          }));
                        },
                        child: const Text("Buy with points!")),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
