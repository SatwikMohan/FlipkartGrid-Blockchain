import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flipgrid/services/EncryptionService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_glow/flutter_glow.dart';
class ShareScreen extends StatefulWidget {
  late String ethId;
  late String email;
  ShareScreen(String ethId,String email){
    this.ethId=ethId;
    this.email=email;
  }

  @override
  State<ShareScreen> createState() => _ShareScreenState(ethId,email);
}

class _ShareScreenState extends State<ShareScreen> {
  late String ethId;
  late String email;
  _ShareScreenState(String ethId,String email){
    this.ethId=ethId;
    this.email=email;
  }
  String encryptedCode="";
  EncryptionClass encryptionClass=EncryptionClass();

  int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  void sendCodeToFirebaseFirestore(String code,String secretKey) async{
    await FirebaseFirestore.instance.collection('ReferalCodes').doc(email).set({
      'Code':code,
      'SecretKey':secretKey
    });
  }

  void process() async{
    int r=random(1000000,10000000);
    String secretKey=r.toString();
    String code=await encryptionClass.EncryptedEthId(ethId, secretKey);
    setState(() {
      encryptedCode=code;
      sendCodeToFirebaseFirestore(code,secretKey);
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Copy the Referral Code and Share With Friends'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.all(
          //   Radius.circular(24),
          // ),
          image: DecorationImage(
            image: NetworkImage(
                'https://cdn.pixabay.com/photo/2022/06/25/13/33/landscape-7283516_640.jpg'),
            // image: AssetImage('assets/background.jpeg'),
            fit: BoxFit.cover,
            opacity: 0.7,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.all(12),
                child: GlowText(
                  encryptedCode,
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
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
        ),
      ),
    );
  }
}
