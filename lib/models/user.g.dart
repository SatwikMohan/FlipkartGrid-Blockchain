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
      lastLogin: json['lastLogin'] as String,
      tokens: json['tokens'] as int,
      loginStreak: json['loginStreak'] as int,
      instaFollowed: json['instaFollowed'] as bool,
      fbFollowed: json['fbFollowed'] as bool,
      twitterFollowed: json['twitterFollowed'] as bool,
    );

Map<String, dynamic> _$$_CustomerToJson(_$_Customer instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'customerAddress': instance.customerAddress,
      'lastLogin': instance.lastLogin,
      'tokens': instance.tokens,
      'loginStreak': instance.loginStreak,
      'instaFollowed': instance.instaFollowed,
      'fbFollowed': instance.fbFollowed,
      'twitterFollowed': instance.twitterFollowed,
    };
