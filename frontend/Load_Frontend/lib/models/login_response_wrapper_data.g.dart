// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_wrapper_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseWrapperData _$LoginResponseWrapperDataFromJson(
        Map<String, dynamic> json) =>
    LoginResponseWrapperData(
      resultCode: json['result_code'] as String,
      result:
          LoginResponseResult.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseWrapperDataToJson(
        LoginResponseWrapperData instance) =>
    <String, dynamic>{
      'result_code': instance.resultCode,
      'result': instance.result,
    };

LoginResponseResult _$LoginResponseResultFromJson(Map<String, dynamic> json) =>
    LoginResponseResult(
      token: json['token'] as String,
    );

Map<String, dynamic> _$LoginResponseResultToJson(
        LoginResponseResult instance) =>
    <String, dynamic>{
      'token': instance.token,
    };
