import 'package:json_annotation/json_annotation.dart';

part 'goods.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Goods {
  final int goodsId;
  final String boxType;
  final int boxHeight;
  final int boxLength;
  final int boxWidth;
  final String detailAddress;
  final int weight;

  const Goods({
    required this.goodsId,
    required this.boxType,
    required this.boxHeight,
    required this.boxLength,
    required this.boxWidth,
    required this.detailAddress,
    required this.weight,
  });

  // JSON 맵핑 메소드
  factory Goods.fromJson(Map<String, dynamic> json) => _$GoodsFromJson(json);
  Map<String, dynamic> toJson() => _$GoodsToJson(this);

  @override
  String toString(){
    return("$goodsId, $boxType, $boxHeight, $boxLength, $boxWidth, $detailAddress, $weight");
  }
}