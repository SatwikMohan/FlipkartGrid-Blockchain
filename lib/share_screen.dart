import 'dart:math';

import 'package:flipgrid/services/EncryptionService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class ShareScreen extends StatefulWidget {
  late String ethId;
  ShareScreen(String ethId){
    this.ethId=ethId;
  }

  @override
  State<ShareScreen> createState() => _ShareScreenState(ethId);
}

class _ShareScreenState extends State<ShareScreen> {
  late String ethId;
  _ShareScreenState(String ethId){
    this.ethId=ethId;
  }
  String encryptedCode="";
  EncryptionClass encryptionClass=EncryptionClass();

  int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  void process() async{
    int r=random(100000,1000000);
    String secretKey=r.toString();
    String code=await encryptionClass.EncryptedEthId(ethId, secretKey);
    setState(() {
      encryptedCode=code;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    process();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Share With Friends'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              encryptedCode
            )
          ),
          SizedBox(height: 10,),
          ElevatedButton(onPressed: (){
            Clipboard.setData(ClipboardData(text: encryptedCode)).then((_){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sharable Code copied to clipboard")));
            });
          },
              child: Text('Copy to Share')
          )
        ],
      ),
    );
  }
}
