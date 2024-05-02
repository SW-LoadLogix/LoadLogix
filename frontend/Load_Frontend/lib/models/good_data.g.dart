// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'good_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodData _$GoodDataFromJson(Map<String, dynamic> json) => GoodData(
      goodsId: (json['goodsId'] as num).toInt(),
      type: json['type'] as String,
      position: Vector3.fromJson(json['position'] as Map<String, dynamic>),
      weight: (json['weight'] as num).toInt(),
      areaId: (json['areaId'] as num).toInt(),
      detailAddress: json['detailAddress'] as String,
    );

Map<String, dynamic> _$GoodDataToJson(GoodData instance) => <String, dynamic>{
      'goodsId': instance.goodsId,
      'type': instance.type,
      'position': instance.position,
      'weight': instance.weight,
      'areaId': instance.areaId,
      'detailAddress': instance.detailAddress,
    };
