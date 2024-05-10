// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_response_wrapper_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupResponseWrapperData _$SignupResponseWrapperDataFromJson(
        Map<String, dynamic> json) =>
    SignupResponseWrapperData(
      result_code: json['result_code'] as String,
      result:
          SignupResponseResult.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignupResponseWrapperDataToJson(
        SignupResponseWrapperData instance) =>
    <String, dynamic>{
      'result_code': instance.result_code,
      'result': instance.result,
    };

SignupResponseResult _$SignupResponseResultFromJson(
        Map<String, dynamic> json) =>
    SignupResponseResult(
      id: (json['id'] as num).toInt(),
      userId: json['userId'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$SignupResponseResultToJson(
        SignupResponseResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
    };
