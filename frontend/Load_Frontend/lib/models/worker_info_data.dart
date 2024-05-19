import 'package:json_annotation/json_annotation.dart';

part 'worker_info_data.g.dart';
// WorkerInfoResponse RestAPI 리턴 구조 객체 모델
// @JsonSerializable()
@JsonSerializable(fieldRename: FieldRename.snake)
class WorkerInfoData{
  final String name;
  final String areaName;
  final int conveyNo;
  final int carHeight;
  final int carLength;
  final int carWidth;

  WorkerInfoData({
    required this.name,
    required this.areaName,
    required this.conveyNo,
    required this.carHeight,
    required this.carLength,
    required this.carWidth,
  });

  //API 호출 시 json 형태를 객체로 변환
  factory WorkerInfoData.fromJson(Map<String, dynamic> json) =>
      _$WorkerInfoDataFromJson(json);
  Map<String, dynamic> toJson() => _$WorkerInfoDataToJson(this);
  @override
  String toString(){
    return("WorkerInfoData(name: $name, areaName: $areaName, conveyNo: $conveyNo, carHeight: $carHeight, carLength: $carLength, carWidth: $carWidth)");
  }
}