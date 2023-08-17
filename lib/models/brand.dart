import 'package:freezed_annotation/freezed_annotation.dart';

part 'brand.freezed.dart';
part 'brand.g.dart';

@Freezed()
class Brand with _$Brand {
  const factory Brand({
    required String name,
    required String? email,
    required String brandAddress,
    required String PicUrl,
    required String CostETH,
    required int currLoyalPoints,
    required bool? isuserloyaltobrand,
    required String description,
    required String rating
  }) = _Brand;

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);
}
