// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:storys_apps/data/model/login_result.dart';
part 'user.g.dart';
part 'user.freezed.dart';

@Freezed()
class User with _$User{
  const factory User({
  required bool? error,
  required String? message,
  @JsonKey(name: "loginResult") required LoginResult? loginResult,
  }) = _User;


  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}


