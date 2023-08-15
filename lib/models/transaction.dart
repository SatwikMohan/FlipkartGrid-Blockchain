import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

@Freezed()
class TransactionAppModel with _$TransactionAppModel {
  const factory TransactionAppModel({
    required String title,
    required String customerEmail,
    required DateTime dateTime,
    required int? amountRecieved,
    required int? tokensRecieved,
    required int? tokensSpent,
    required int? amountSpent,
    required String? senderAdress,
    required String? recieverAress,
  }) = _TransactionAppModel;

  factory TransactionAppModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionAppModelFromJson(json);
}
