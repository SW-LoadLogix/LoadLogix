// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker_info_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkerInfoData _$WorkerInfoDataFromJson(Map<String, dynamic> json) =>
    WorkerInfoData(
      name: json['name'] as String,
      areaName: json['area_name'] as String,
      conveyNo: (json['convey_no'] as num).toInt(),
      carHeight: (json['car_height'] as num).toInt(),
      carLength: (json['car_length'] as num).toInt(),
      carWidth: (json['car_width'] as num).toInt(),
    );

Map<String, dynamic> _$WorkerInfoDataToJson(WorkerInfoData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'area_name': instance.areaName,
      'convey_no': instance.conveyNo,
      'car_height': instance.carHeight,
      'car_length': instance.carLength,
      'car_width': instance.carWidth,
    };
