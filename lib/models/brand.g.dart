// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Brand _$$_BrandFromJson(Map<String, dynamic> json) => _$_Brand(
      name: json['name'] as String,
      email: json['email'] as String?,
      brandAddress: json['brandAddress'] as String,
      PicUrl: json['PicUrl'] as String,
      CostETH: json['CostETH'] as String,
      currLoyalPoints: json['currLoyalPoints'] as int,
    );

Map<String, dynamic> _$$_BrandToJson(_$_Brand instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'brandAddress': instance.brandAddress,
      'PicUrl': instance.PicUrl,
      'CostETH': instance.CostETH,
      'currLoyalPoints': instance.currLoyalPoints,
    };
