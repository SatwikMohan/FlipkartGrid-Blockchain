// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coupons_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CouponsModel _$CouponsModelFromJson(Map<String, dynamic> json) {
  return _CouponsModel.fromJson(json);
}

/// @nodoc
mixin _$CouponsModel {
  int get value => throw _privateConstructorUsedError;
  bool get isClaimed => throw _privateConstructorUsedError;
  String get creationDateTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CouponsModelCopyWith<CouponsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CouponsModelCopyWith<$Res> {
  factory $CouponsModelCopyWith(
          CouponsModel value, $Res Function(CouponsModel) then) =
      _$CouponsModelCopyWithImpl<$Res, CouponsModel>;
  @useResult
  $Res call({int value, bool isClaimed, String creationDateTime});
}

/// @nodoc
class _$CouponsModelCopyWithImpl<$Res, $Val extends CouponsModel>
    implements $CouponsModelCopyWith<$Res> {
  _$CouponsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? isClaimed = null,
    Object? creationDateTime = null,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      isClaimed: null == isClaimed
          ? _value.isClaimed
          : isClaimed // ignore: cast_nullable_to_non_nullable
              as bool,
      creationDateTime: null == creationDateTime
          ? _value.creationDateTime
          : creationDateTime // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CouponsModelCopyWith<$Res>
    implements $CouponsModelCopyWith<$Res> {
  factory _$$_CouponsModelCopyWith(
          _$_CouponsModel value, $Res Function(_$_CouponsModel) then) =
      __$$_CouponsModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int value, bool isClaimed, String creationDateTime});
}

/// @nodoc
class __$$_CouponsModelCopyWithImpl<$Res>
    extends _$CouponsModelCopyWithImpl<$Res, _$_CouponsModel>
    implements _$$_CouponsModelCopyWith<$Res> {
  __$$_CouponsModelCopyWithImpl(
      _$_CouponsModel _value, $Res Function(_$_CouponsModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? isClaimed = null,
    Object? creationDateTime = null,
  }) {
    return _then(_$_CouponsModel(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      isClaimed: null == isClaimed
          ? _value.isClaimed
          : isClaimed // ignore: cast_nullable_to_non_nullable
              as bool,
      creationDateTime: null == creationDateTime
          ? _value.creationDateTime
          : creationDateTime // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CouponsModel implements _CouponsModel {
  const _$_CouponsModel(
      {required this.value,
      required this.isClaimed,
      required this.creationDateTime});

  factory _$_CouponsModel.fromJson(Map<String, dynamic> json) =>
      _$$_CouponsModelFromJson(json);

  @override
  final int value;
  @override
  final bool isClaimed;
  @override
  final String creationDateTime;

  @override
  String toString() {
    return 'CouponsModel(value: $value, isClaimed: $isClaimed, creationDateTime: $creationDateTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CouponsModel &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.isClaimed, isClaimed) ||
                other.isClaimed == isClaimed) &&
            (identical(other.creationDateTime, creationDateTime) ||
                other.creationDateTime == creationDateTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, value, isClaimed, creationDateTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CouponsModelCopyWith<_$_CouponsModel> get copyWith =>
      __$$_CouponsModelCopyWithImpl<_$_CouponsModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CouponsModelToJson(
      this,
    );
  }
}

abstract class _CouponsModel implements CouponsModel {
  const factory _CouponsModel(
      {required final int value,
      required final bool isClaimed,
      required final String creationDateTime}) = _$_CouponsModel;

  factory _CouponsModel.fromJson(Map<String, dynamic> json) =
      _$_CouponsModel.fromJson;

  @override
  int get value;
  @override
  bool get isClaimed;
  @override
  String get creationDateTime;
  @override
  @JsonKey(ignore: true)
  _$$_CouponsModelCopyWith<_$_CouponsModel> get copyWith =>
      throw _privateConstructorUsedError;
}
