// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuildingData _$BuildingDataFromJson(Map<String, dynamic> json) => BuildingData(
      buildingId: (json['building_id'] as num).toInt(),
      buildingName: json['building_name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      totalGoods: (json['total_goods'] as num).toInt(),
    );

Map<String, dynamic> _$BuildingDataToJson(BuildingData instance) =>
    <String, dynamic>{
      'building_id': instance.buildingId,
      'building_name': instance.buildingName,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'total_goods': instance.totalGoods,
    };
