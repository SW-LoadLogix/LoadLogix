// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'good_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodsData _$GoodsDataFromJson(Map<String, dynamic> json) => GoodsData(
      goodsId: (json['goods_id'] as num).toInt(),
      type: json['type'] as String,
      position: Vector3.fromJson(json['position'] as Map<String, dynamic>),
      weight: (json['weight'] as num).toInt(),
      buildingId: (json['building_id'] as num).toInt(),
      buildingName: json['building_name'] as String,
      detailAddress: json['detail_address'] as String,
    );

Map<String, dynamic> _$GoodsDataToJson(GoodsData instance) => <String, dynamic>{
      'goods_id': instance.goodsId,
      'type': instance.type,
      'position': instance.position,
      'weight': instance.weight,
      'building_id': instance.buildingId,
      'building_name': instance.buildingName,
      'detail_address': instance.detailAddress,
    };
