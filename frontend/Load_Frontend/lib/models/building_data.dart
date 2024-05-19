
import 'package:json_annotation/json_annotation.dart';

part 'building_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BuildingData{
  const BuildingData({
    required this.buildingId,
    required this.buildingName,
    required this.latitude,
    required this.longitude,
    required this.totalGoods,
  });


  final int buildingId;
  final String buildingName;//S1 to S6
  final double latitude;
  final double longitude;
  final int totalGoods;


  // JSON 맵핑 메소드
  factory BuildingData.fromJson(Map<String, dynamic> json) => _$BuildingDataFromJson(json);
  Map<String, dynamic> toJson() => _$BuildingDataToJson(this);

  @override
  String toString(){
    return("BuildingData(buildingId: $buildingId, buildingName: $buildingName, latitude: $latitude, longitude: $longitude, totalGoods: $totalGoods)");
  }
}