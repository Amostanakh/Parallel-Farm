// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_reset_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordResetModel _$PasswordResetModelFromJson(Map<String, dynamic> json) =>
    PasswordResetModel(
      newPassword: json['phoneNumber'] as String,
      currentPassword: json['password'] as String,
      confirmPassword: json['confirmPassword'] as String,
    );

Map<String, dynamic> _$PasswordResetModelToJson(PasswordResetModel instance) =>
    <String, dynamic>{
      "  newPassword": instance.newPassword,
      "  currentPassword": instance.currentPassword,
      "confirmPassword": instance.confirmPassword,
    };
