import 'package:flutter/material.dart';
class ShareScreen extends StatefulWidget {
  const ShareScreen({Key? key}) : super(key: key);

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Share With Friends'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          TextField(

          ),
          SizedBox(height: 10,),
          TextField(

          ),
          SizedBox(height: 10,),
          ElevatedButton(onPressed: (){

          },
              child: Text('Share')
          )
        ],
      ),
    );
  }
}
