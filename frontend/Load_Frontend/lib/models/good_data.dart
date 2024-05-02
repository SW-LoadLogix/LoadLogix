

import 'package:json_annotation/json_annotation.dart';
import 'package:load_frontend/models/vector3.dart';

part 'good_data.g.dart';

@JsonSerializable()
class GoodData{
  const GoodData({
    required this.goodsId,
    required this.type,
    required this.position,
    required this.weight,
    required this.areaId,
    required this.detailAddress,
  });


  final int goodsId;
  final String type;//S1 to S6
  final Vector3 position;
  final int weight;
  final int areaId;
  final String detailAddress;

  // JSON 맵핑 메소드
  factory GoodData.fromJson(Map<String, dynamic> json) => _$GoodDataFromJson(json);
  Map<String, dynamic> toJson() => _$GoodDataToJson(this);

  @override
  String toString() => 'GoodData($goodsId, $type, $position, $weight, $areaId, $detailAddress)';

}