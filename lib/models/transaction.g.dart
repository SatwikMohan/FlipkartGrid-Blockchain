// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TransactionAppModel _$$_TransactionAppModelFromJson(
        Map<String, dynamic> json) =>
    _$_TransactionAppModel(
      title: json['title'] as String,
      customerEmail: json['customerEmail'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      amountRecieved: json['amountRecieved'] as int?,
      tokensRecieved: json['tokensRecieved'] as int?,
      tokensSpent: json['tokensSpent'] as int?,
      amountSpent: json['amountSpent'] as int?,
      senderAdress: json['senderAdress'] as String?,
      recieverAress: json['recieverAress'] as String?,
    );

Map<String, dynamic> _$$_TransactionAppModelToJson(
        _$_TransactionAppModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'customerEmail': instance.customerEmail,
      'dateTime': instance.dateTime.toIso8601String(),
      'amountRecieved': instance.amountRecieved,
      'tokensRecieved': instance.tokensRecieved,
      'tokensSpent': instance.tokensSpent,
      'amountSpent': instance.amountSpent,
      'senderAdress': instance.senderAdress,
      'recieverAress': instance.recieverAress,
    };
