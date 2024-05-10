

import 'package:json_annotation/json_annotation.dart';
import 'package:load_frontend/models/vector3.dart';

part 'good_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
//@JsonSerializable()
class GoodsData{
  const GoodsData({
    required this.goodsId,
    required this.type,
    required this.position,
    required this.weight,
    required this.buildingId,
    required this.buildingName,
    required this.detailAddress,
  });


  final int goodsId;
  final String type;//S1 to S6
  final Vector3 position;
  final int weight;
  final int buildingId;
  final String buildingName;
  final String detailAddress;

  // JSON 맵핑 메소드
  factory GoodsData.fromJson(Map<String, dynamic> json) => _$GoodsDataFromJson(json);
  Map<String, dynamic> toJson() => _$GoodsDataToJson(this);

  @override
  String toString() => 'GoodsData($goodsId, $type, $position, $weight, $buildingId,$buildingName, $detailAddress)';

}