// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRequestModel _$UserRequestModelFromJson(Map<String, dynamic> json) =>
    UserRequestModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String?,
      password: json['password'] as String?,
      birthYear: json['birthYear'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$UserRequestModelToJson(UserRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'birthYear': instance.birthYear,
      'gender': instance.gender,
      'password': instance.password,
    };
