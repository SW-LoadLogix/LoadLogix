// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Goods _$GoodsFromJson(Map<String, dynamic> json) => Goods(
      goodsId: (json['goods_id'] as num).toInt(),
      boxType: json['box_type'] as String,
      boxHeight: (json['box_height'] as num).toInt(),
      boxLength: (json['box_length'] as num).toInt(),
      boxWidth: (json['box_width'] as num).toInt(),
      detailAddress: json['detail_address'] as String,
      weight: (json['weight'] as num).toInt(),
    );

Map<String, dynamic> _$GoodsToJson(Goods instance) => <String, dynamic>{
      'goods_id': instance.goodsId,
      'box_type': instance.boxType,
      'box_height': instance.boxHeight,
      'box_length': instance.boxLength,
      'box_width': instance.boxWidth,
      'detail_address': instance.detailAddress,
      'weight': instance.weight,
    };
