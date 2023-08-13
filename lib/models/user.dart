import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@Freezed()
class Customer with _$Customer {
  const factory Customer({
    required String name,
    required String email,
    required String password,
    required String customerAddress,
    required String lastLogin,
    required int tokens,
    required int loginStreak,
  }) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
}
