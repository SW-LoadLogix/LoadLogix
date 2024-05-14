// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building_fraction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Buildings _$BuildingsFromJson(Map<String, dynamic> json) => Buildings(
      topAddress: json['top_address'] as String,
      buildingAddress: json['building_address'] as String,
      totalGoods: (json['total_goods'] as num).toInt(),
      totalPercentage: (json['total_percentage'] as num).toInt(),
      goods: (json['goods'] as List<dynamic>)
          .map((e) => Goods.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BuildingsToJson(Buildings instance) => <String, dynamic>{
      'top_address': instance.topAddress,
      'building_address': instance.buildingAddress,
      'total_goods': instance.totalGoods,
      'total_percentage': instance.totalPercentage,
      'goods': instance.goods,
    };
