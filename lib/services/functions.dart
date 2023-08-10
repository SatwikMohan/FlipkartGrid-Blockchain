import 'package:flipgrid/utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';

Future<DeployedContract> loadContract() async{
  String abi=await rootBundle.loadString('assets/abi.json');
  String contractAddress=contractAddress1;
  final contract=DeployedContract(ContractAbi.fromJson(abi, 'Election'), EthereumAddress.fromHex(contractAddress));
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