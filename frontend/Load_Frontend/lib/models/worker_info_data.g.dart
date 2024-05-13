// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker_info_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkerInfoData _$WorkerInfoDataFromJson(Map<String, dynamic> json) =>
    WorkerInfoData(
      name: json['name'] as String,
      areaName: json['areaName'] as String,
      conveyNo: (json['conveyNo'] as num).toInt(),
      carHeight: (json['carHeight'] as num).toInt(),
      carLength: (json['carLength'] as num).toInt(),
      carWidth: (json['carWidth'] as num).toInt(),
    );

Map<String, dynamic> _$WorkerInfoDataToJson(WorkerInfoData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'areaName': instance.areaName,
      'conveyNo': instance.conveyNo,
      'carHeight': instance.carHeight,
      'carLength': instance.carLength,
      'carWidth': instance.carWidth,
    };
