import 'package:json_annotation/json_annotation.dart';

import 'package:load_frontend/models/building_fraction.dart';

part 'delivery_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DeliveryData{
  const DeliveryData({
    required this.areaName,
    required this.total,
    required this.buildings,
  });

  final String areaName;
  final int total;
  final List<Buildings> buildings;

  // JSON 맵핑 메소드
  factory DeliveryData.fromJson(Map<String, dynamic> json) => _$DeliveryDataFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryDataToJson(this);

  @override
  String toString(){
    return("$areaName, $total, $buildings");
  }

}