// import 'package:flutter/material.dart';

// import 'product_list_view.dart';
// import 'follow_to_earn.dart';

// class Explore extends StatefulWidget {
//   const Explore({super.key});

//   @override
//   State<Explore> createState() => _ExploreState();
// }

// class _ExploreState extends State<Explore> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//               return Scaffold(
//                 body: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       const SizedBox(height: 32),
//                       const FollowOnSocials(),
//                       ElevatedButton(
//                           onPressed: () {
//                             Navigator.push(context,
//                                 MaterialPageRoute(builder: (context) {
//                               return Scaffold(body: ProductListView());
//                             }));
//                           },
//                           child: const Text(
//                             "Buy with points!",
//                             style: TextStyle(fontSize: 16),
//                           )),
//                       const SizedBox(height: 8),
//                     ],
//                   ),
//                 ),
//               );
//             }));
//           },
//           child: const Text("Earn"),
//         ),
//         body: ProductListView());
//   }
// }
