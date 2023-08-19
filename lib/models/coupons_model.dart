import 'package:freezed_annotation/freezed_annotation.dart';

part 'coupons_model.freezed.dart';
part 'coupons_model.g.dart';

@Freezed()
class CouponsModel with _$CouponsModel {
  const factory CouponsModel({
    required int value,
    required bool isClaimed,
    required String creationDateTime,
    required String imageUrl,
    required String key,
  }) = _CouponsModel;

  factory CouponsModel.fromJson(Map<String, dynamic> json) =>
      _$CouponsModelFromJson(json);
}
