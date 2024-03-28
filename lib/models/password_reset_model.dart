import 'package:json_annotation/json_annotation.dart';

part 'password_reset_model.g.dart';

@JsonSerializable()
class PasswordResetModel {
  final String currentPassword;
  final String  newPassword;
  final String confirmPassword;

  PasswordResetModel({required this.currentPassword, required this.newPassword, required this.confirmPassword});



  factory PasswordResetModel.fromJson(Map<String, dynamic> json) => _$PasswordResetModelFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordResetModelToJson(this);
}