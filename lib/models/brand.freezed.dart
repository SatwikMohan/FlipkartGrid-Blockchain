// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brand.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Brand _$BrandFromJson(Map<String, dynamic> json) {
  return _Brand.fromJson(json);
}

/// @nodoc
mixin _$Brand {
  String get name => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String get brandAddress => throw _privateConstructorUsedError;
  String get PicUrl => throw _privateConstructorUsedError;
  String get CostETH => throw _privateConstructorUsedError;
  int get currLoyalPoints => throw _privateConstructorUsedError;
  bool? get isuserloyaltobrand => throw _privateConstructorUsedError;
  String get description=>throw _privateConstructorUsedError;
  String get rating=>throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BrandCopyWith<Brand> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrandCopyWith<$Res> {
  factory $BrandCopyWith(Brand value, $Res Function(Brand) then) =
      _$BrandCopyWithImpl<$Res, Brand>;
  @useResult
  $Res call(
      {String name,
      String? email,
      String brandAddress,
      String PicUrl,
      String CostETH,
      int currLoyalPoints,
      bool? isuserloyaltobrand,
        String description,
        String rating
      });
}

/// @nodoc
class _$BrandCopyWithImpl<$Res, $Val extends Brand>
    implements $BrandCopyWith<$Res> {
  _$BrandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = freezed,
    Object? brandAddress = null,
    Object? PicUrl = null,
    Object? CostETH = null,
    Object? currLoyalPoints = null,
    Object? isuserloyaltobrand = freezed,
    Object? description=null,
    Object? rating=null
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      brandAddress: null == brandAddress
          ? _value.brandAddress
          : brandAddress // ignore: cast_nullable_to_non_nullable
              as String,
      PicUrl: null == PicUrl
          ? _value.PicUrl
          : PicUrl // ignore: cast_nullable_to_non_nullable
              as String,
      CostETH: null == CostETH
          ? _value.CostETH
          : CostETH // ignore: cast_nullable_to_non_nullable
              as String,
      currLoyalPoints: null == currLoyalPoints
          ? _value.currLoyalPoints
          : currLoyalPoints // ignore: cast_nullable_to_non_nullable
              as int,
      isuserloyaltobrand: freezed == isuserloyaltobrand
          ? _value.isuserloyaltobrand
          : isuserloyaltobrand // ignore: cast_nullable_to_non_nullable
              as bool?,
      description: null==description
        ?_value.description:description
        as String,
      rating: null==rating?
          _value.rating:rating as String
    ) as $Val
    );
  }
}

/// @nodoc
abstract class _$$_BrandCopyWith<$Res> implements $BrandCopyWith<$Res> {
  factory _$$_BrandCopyWith(_$_Brand value, $Res Function(_$_Brand) then) =
      __$$_BrandCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String? email,
      String brandAddress,
      String PicUrl,
      String CostETH,
      int currLoyalPoints,
      bool? isuserloyaltobrand,
        String description,
        String rating
      });
}

/// @nodoc
class __$$_BrandCopyWithImpl<$Res> extends _$BrandCopyWithImpl<$Res, _$_Brand>
    implements _$$_BrandCopyWith<$Res> {
  __$$_BrandCopyWithImpl(_$_Brand _value, $Res Function(_$_Brand) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = freezed,
    Object? brandAddress = null,
    Object? PicUrl = null,
    Object? CostETH = null,
    Object? currLoyalPoints = null,
    Object? isuserloyaltobrand = freezed,
    Object? description=null,
    Object? rating=null
  }) {
    return _then(_$_Brand(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      brandAddress: null == brandAddress
          ? _value.brandAddress
          : brandAddress // ignore: cast_nullable_to_non_nullable
              as String,
      PicUrl: null == PicUrl
          ? _value.PicUrl
          : PicUrl // ignore: cast_nullable_to_non_nullable
              as String,
      CostETH: null == CostETH
          ? _value.CostETH
          : CostETH // ignore: cast_nullable_to_non_nullable
              as String,
      currLoyalPoints: null == currLoyalPoints
          ? _value.currLoyalPoints
          : currLoyalPoints // ignore: cast_nullable_to_non_nullable
              as int,
      isuserloyaltobrand: freezed == isuserloyaltobrand
          ? _value.isuserloyaltobrand
          : isuserloyaltobrand // ignore: cast_nullable_to_non_nullable
              as bool?,
        description: null==description
            ?_value.description:description
        as String,
        rating: null==rating?
        _value.rating:rating as String
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Brand implements _Brand {
  const _$_Brand(
      {required this.name,
      required this.email,
      required this.brandAddress,
      required this.PicUrl,
      required this.CostETH,
      required this.currLoyalPoints,
      required this.isuserloyaltobrand,
        required this.description,
        required this.rating
      });

  factory _$_Brand.fromJson(Map<String, dynamic> json) =>
      _$$_BrandFromJson(json);

  @override
  final String name;
  @override
  final String? email;
  @override
  final String brandAddress;
  @override
  final String PicUrl;
  @override
  final String CostETH;
  @override
  final int currLoyalPoints;
  @override
  final bool? isuserloyaltobrand;
  @override
  final String description;
  @override
  final String rating;

  @override
  String toString() {
    return 'Brand(name: $name, email: $email, brandAddress: $brandAddress, PicUrl: $PicUrl, CostETH: $CostETH, currLoyalPoints: $currLoyalPoints, isuserloyaltobrand: $isuserloyaltobrand, description:$description,rating:$rating)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Brand &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.brandAddress, brandAddress) ||
                other.brandAddress == brandAddress) &&
            (identical(other.PicUrl, PicUrl) || other.PicUrl == PicUrl) &&
            (identical(other.CostETH, CostETH) || other.CostETH == CostETH) &&
            (identical(other.currLoyalPoints, currLoyalPoints) ||
                other.currLoyalPoints == currLoyalPoints) &&
            (identical(other.isuserloyaltobrand, isuserloyaltobrand) ||
                other.isuserloyaltobrand == isuserloyaltobrand))&&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.rating, rating) ||
                other.rating == rating);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, email, brandAddress,
      PicUrl, CostETH, currLoyalPoints, isuserloyaltobrand,description,rating);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BrandCopyWith<_$_Brand> get copyWith =>
      __$$_BrandCopyWithImpl<_$_Brand>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BrandToJson(
      this,
    );
  }
}

abstract class _Brand implements Brand {
  const factory _Brand(
      {required final String name,
      required final String? email,
      required final String brandAddress,
      required final String PicUrl,
      required final String CostETH,
      required final int currLoyalPoints,
      required final bool? isuserloyaltobrand,
      required final String description,
        required final String rating
      }) = _$_Brand;

  factory _Brand.fromJson(Map<String, dynamic> json) = _$_Brand.fromJson;

  @override
  String get name;
  @override
  String? get email;
  @override
  String get brandAddress;
  @override
  String get PicUrl;
  @override
  String get CostETH;
  @override
  int get currLoyalPoints;
  @override
  bool? get isuserloyaltobrand;
  @override
  String get description;
  @override
  String get rating;
  @override
  @JsonKey(ignore: true)
  _$$_BrandCopyWith<_$_Brand> get copyWith =>
      throw _privateConstructorUsedError;
}
