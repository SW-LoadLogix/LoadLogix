import 'package:json_annotation/json_annotation.dart';

part 'login_response_wrapper_data.g.dart'; // Generate this file with `flutter pub run build_runner build`

//@JsonSerializable() // 기본으로 카멜케이스를 사용
@JsonSerializable(fieldRename: FieldRename.snake) // 스네이크 케이스
class LoginResponseWrapperData {
  const LoginResponseWrapperData({
    required this.resultCode,
    required this.result,
  });

  final String resultCode;
  final LoginResponseResult result;

  factory LoginResponseWrapperData.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseWrapperDataFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseWrapperDataToJson(this);

  @override
  String toString() => 'LoginResponseWrapperData(result_code: $resultCode, result: $result)';
}

@JsonSerializable(fieldRename: FieldRename.snake) // 스네이크 케이스
class LoginResponseResult {
  const LoginResponseResult({
    required this.token,
  });

  final String token;

  factory LoginResponseResult.fromJson(Map<String, dynamic> json) => _$LoginResponseResultFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseResultToJson(this);

  @override
  String toString() => 'LoginResponseResult(token: $token)';
}
