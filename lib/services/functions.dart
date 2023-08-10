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

String getUserData(String email,Web3Client ethClient){
  var response=callFunction('getUserData', [email], ethClient, owner_private_key);
  print('Function getUserData Called Successfully');
  print(response);
  return response.toString();
}