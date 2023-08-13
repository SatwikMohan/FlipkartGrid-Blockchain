// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Customer _$$_CustomerFromJson(Map<String, dynamic> json) => _$_Customer(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      customerAddress: json['customerAddress'] as String,
      tokens: json['tokens'] as int?,
      loginStreak: json['loginStreak'] as int?,
    );

Map<String, dynamic> _$$_CustomerToJson(_$_Customer instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'customerAddress': instance.customerAddress,
      'tokens': instance.tokens,
      'loginStreak': instance.loginStreak,
    };
