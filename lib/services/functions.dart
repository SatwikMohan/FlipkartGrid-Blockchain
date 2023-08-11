
import 'dart:convert';

import 'package:flipgrid/utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';

Future<DeployedContract> loadContract() async{
  String abi=await rootBundle.loadString('assets/abi.json');
  String contractAddress=contractAddress1;
  final contract=DeployedContract(ContractAbi.fromJson(abi, 'FungibleToken'), EthereumAddress.fromHex(contractAddress));
  return contract;
}

Future<String> callFunction(String functionName,List<dynamic> args,Web3Client ethClient,String privateKey) async{
  EthPrivateKey credential=EthPrivateKey.fromHex(privateKey);
  DeployedContract contract=await loadContract();
  final ethFunction=contract.function(functionName);
  final result=await ethClient.sendTransaction(credential, Transaction.callContract(contract: contract, function: ethFunction, parameters: args)
      ,chainId: null,fetchChainIdFromNetworkId: true);
  return result;
}

Future<String> addCustomer(String name,String email,String password,String customerAddress,Web3Client ethClient){
  var response=callFunction('addCustomer', [name,email,password,EthereumAddress.fromHex(customerAddress)], ethClient, owner_private_key);
  print('Function addCustomer Called Successfully');
  return response;
}

Future<List<dynamic>> ask(String functionName,List<dynamic> args,Web3Client ethClient) async{
  DeployedContract contract=await loadContract();
  final ethFunction=contract.function(functionName);
  final result=await ethClient.call(contract: contract, function: ethFunction, params: args);
  return result;
}

Future<List<dynamic>> getUserData(String email,Web3Client ethClient) async{
  var response=await ask('getUserData', [email], ethClient);
  print('Function getUserData Called Successfully');
  print("=>"+response[0].toString());
  return response;
}

Future<String> mintDailyCheckInLoyaltyPoints(String customerAddress,Web3Client ethClient){
  var response=callFunction('mintDailyCheckInLoyaltyPoints', [EthereumAddress.fromHex(customerAddress)], ethClient, owner_private_key);
  print('Function mintDailyCheckInLoyaltyPoints Called Successfully');
  return response;
}

Future<String> mintLoyaltyPoints(String customerAddress,int points,Web3Client ethClient){
  var response=callFunction('mintLoyaltyPoints', [EthereumAddress.fromHex(customerAddress),points], ethClient, owner_private_key);
  print('Function mintLoyaltyPoints Called Successfully');
  return response;
}

Future<String> makeCustomerLoyal(String customerAddress,Web3Client ethClient){
  var response=callFunction('makeCustomerLoyal', [EthereumAddress.fromHex(customerAddress)], ethClient, owner_private_key);
  print('Function makeCustomerLoyal Called Successfully');
  return response;
}