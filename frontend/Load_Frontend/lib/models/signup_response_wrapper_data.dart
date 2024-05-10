import 'package:json_annotation/json_annotation.dart';

part 'signup_response_wrapper_data.g.dart'; // Generate this file with `flutter pub run build_runner build`

//@JsonSerializable() // 기본으로 카멜케이스를 사용
@JsonSerializable(fieldRename: FieldRename.snake) // 스네이크 케이스
class SignupResponseWrapperData {
  const SignupResponseWrapperData({
    required this.result_code,
    required this.result,
  });

  final String result_code;
  final SignupResponseResult result;

  factory SignupResponseWrapperData.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseWrapperDataFromJson(json);
  Map<String, dynamic> toJson() => _$SignupResponseWrapperDataToJson(this);
  @override
  String toString() => 'SignupResponseWrapperData(resultCode: $result_code, result: $result)';
}

@JsonSerializable()
class SignupResponseResult {
  const SignupResponseResult({
    required this.id,
    required this.userId,
    required this.name,
  });

  final int id;
  final String userId;
  final String name;

  factory SignupResponseResult.fromJson(Map<String, dynamic> json) => _$SignupResponseResultFromJson(json);
  Map<String, dynamic> toJson() => _$SignupResponseResultToJson(this);
  @override
  String toString() => 'SignupResponseResult(id: $id, userId: $userId, name: $name)';
}
