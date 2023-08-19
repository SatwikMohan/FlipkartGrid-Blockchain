import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flipgrid/main.dart';
import 'package:flipgrid/models/coupons_model.dart';
import 'package:flipgrid/scratch_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyCoupons extends ConsumerStatefulWidget {
  const MyCoupons({super.key});
  @override
  ConsumerState<MyCoupons> createState() => _MyCouponsState();
}

class _MyCouponsState extends ConsumerState<MyCoupons> {
  List<CouponsModel> couponsList = [];
  void getUserCouponsFromFirebase() async {
    final response = await FirebaseFirestore.instance
        .collection("Coupons")
        .doc(ref.read(currentUserStateProvider).getCurrentUser.email)
        .collection("UserCoupons")
        .get();
    setState(() {
      couponsList =
          response.docs.map((e) => CouponsModel.fromJson(e.data())).toList();
    });
    print(couponsList);
  }

  @override
  void initState() {
    getUserCouponsFromFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Coupons'),
      ),
      body: Container(
        width: width,
        height: height,
        child: GridView.builder(
          itemCount: couponsList.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          itemBuilder: (BuildContext context, int index) {
            return MyScratchCard(coupon: couponsList[index]);
          },
        ),
      ),
    );
  }
}
