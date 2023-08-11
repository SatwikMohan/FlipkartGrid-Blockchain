// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      name: json['name'] as String,
      password: json['password'] as String,
      address: json['address'] as String,
      loginStreak: json['loginStreak'] as int?,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'name': instance.name,
      'password': instance.password,
      'address': instance.address,
      'loginStreak': instance.loginStreak,
    };
