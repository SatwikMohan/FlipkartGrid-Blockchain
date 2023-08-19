import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
class EncryptionClass {
  Future<String> EncryptedEthId(String ethId,String secretKey) async {
    String baseurl = "https://encryption-api1.p.rapidapi.com/api/Cryptor/encryptstring?secretKey=$secretKey&plainText=$ethId&cryptAlgorithm=DES&cipherMode=CBC";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "X-RapidAPI-Key": "bdc14bb958mshc42209b7567c22bp1173ccjsn9790ef7e194d",
      "X-RapidAPI-Host": "encryption-api1.p.rapidapi.com"
    };
    try {
      http.Response res = await http.get(
        Uri.parse(baseurl),
        headers: headers,
      );
      var data = jsonDecode(res.body);
      print(data);
      return data['result'].toString();
    } catch (e) {
      print("Encryption Error=> " + e.toString());
      return "NULL";
    }
  }
  Future<String> DecryptCode(String code,String secretKey) async{
    String baseurl = "https://encryption-api1.p.rapidapi.com/api/Cryptor/decryptstring?secretKey=$secretKey&encryptedText=$code&cryptAlgorithm=DES&cipherMode=CBC";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "X-RapidAPI-Key": "bdc14bb958mshc42209b7567c22bp1173ccjsn9790ef7e194d",
      "X-RapidAPI-Host": "encryption-api1.p.rapidapi.com"
    };
    try {
      http.Response res = await http.get(
        Uri.parse(baseurl),
        headers: headers,
      );
      var data = jsonDecode(res.body);
      print(data);
      return data['result'].toString();
    } catch (e) {
      print("Decryption Error=> " + e.toString());
      return "NULL";
    }
  }
}