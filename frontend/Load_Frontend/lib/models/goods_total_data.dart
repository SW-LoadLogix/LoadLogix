import 'package:json_annotation/json_annotation.dart';

part 'goods_total_data.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake)
class GoodsTotalDataWrapper{
  const GoodsTotalDataWrapper({
    required this.amount,
  });
  final List<GoodsTotalData> amount;
  factory GoodsTotalDataWrapper.fromJson(Map<String, dynamic> json) => _$GoodsTotalDataWrapperFromJson(json);
  Map<String, dynamic> toJson() => _$GoodsTotalDataWrapperToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class GoodsTotalData{
  const GoodsTotalData({
    required this.date,
    required this.total,
  });

  final DateTime date;
  final int total;

  // JSON 맵핑 메소드
  factory GoodsTotalData.fromJson(Map<String, dynamic> json) => _$GoodsTotalDataFromJson(json);
  Map<String, dynamic> toJson() => _$GoodsTotalDataToJson(this);

}