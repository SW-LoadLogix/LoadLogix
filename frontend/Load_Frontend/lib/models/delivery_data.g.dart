// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryData _$DeliveryDataFromJson(Map<String, dynamic> json) => DeliveryData(
      areaName: json['area_name'] as String,
      total: (json['total'] as num).toInt(),
      buildings: (json['buildings'] as List<dynamic>)
          .map((e) => Buildings.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DeliveryDataToJson(DeliveryData instance) =>
    <String, dynamic>{
      'area_name': instance.areaName,
      'total': instance.total,
      'buildings': instance.buildings,
    };
