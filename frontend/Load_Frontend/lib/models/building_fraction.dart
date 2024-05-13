import 'package:json_annotation/json_annotation.dart';

import 'package:load_frontend/models/goods.dart';

part 'building_fraction.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Buildings {
  final String topAddress;
  final String buildingAddress;
  final int totalGoods;
  final int totalPercentage;
  final List<Goods> goods;

  const Buildings({
    required this.topAddress,
    required this.buildingAddress,
    required this.totalGoods,
    required this.totalPercentage,
    required this.goods,
  });

  // JSON 맵핑 메소드
  factory Buildings.fromJson(Map<String, dynamic> json) => _$BuildingsFromJson(json);
  Map<String, dynamic> toJson() => _$BuildingsToJson(this);
  @override
  String toString(){
    return ("$topAddress, $buildingAddress, $totalGoods, $totalPercentage, $goods");
  }
}