// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_total_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodsTotalDataWrapper _$GoodsTotalDataWrapperFromJson(
        Map<String, dynamic> json) =>
    GoodsTotalDataWrapper(
      amount: (json['amount'] as List<dynamic>)
          .map((e) => GoodsTotalData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GoodsTotalDataWrapperToJson(
        GoodsTotalDataWrapper instance) =>
    <String, dynamic>{
      'amount': instance.amount,
    };

GoodsTotalData _$GoodsTotalDataFromJson(Map<String, dynamic> json) =>
    GoodsTotalData(
      date: DateTime.parse(json['date'] as String),
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$GoodsTotalDataToJson(GoodsTotalData instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'total': instance.total,
    };
