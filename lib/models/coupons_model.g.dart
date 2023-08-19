// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupons_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CouponsModel _$$_CouponsModelFromJson(Map<String, dynamic> json) =>
    _$_CouponsModel(
      value: json['value'] as int,
      isClaimed: json['isClaimed'] as bool,
      creationDateTime: json['creationDateTime'] as String,
    );

Map<String, dynamic> _$$_CouponsModelToJson(_$_CouponsModel instance) =>
    <String, dynamic>{
      'value': instance.value,
      'isClaimed': instance.isClaimed,
      'creationDateTime': instance.creationDateTime,
    };
