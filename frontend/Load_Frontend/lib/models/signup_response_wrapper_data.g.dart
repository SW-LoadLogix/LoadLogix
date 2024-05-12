// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_response_wrapper_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupResponseWrapperData _$SignupResponseWrapperDataFromJson(
        Map<String, dynamic> json) =>
    SignupResponseWrapperData(
      resultCode: json['result_code'] as String,
      result:
          SignupResponseResult.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignupResponseWrapperDataToJson(
        SignupResponseWrapperData instance) =>
    <String, dynamic>{
      'result_code': instance.resultCode,
      'result': instance.result,
    };

SignupResponseResult _$SignupResponseResultFromJson(
        Map<String, dynamic> json) =>
    SignupResponseResult(
      id: (json['id'] as num).toInt(),
      userId: json['user_id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$SignupResponseResultToJson(
        SignupResponseResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
    };
