import 'package:json_annotation/json_annotation.dart';

part 'vector3.g.dart';

@JsonSerializable()
class Vector3 {
  final double x, y, z;

  Vector3(this.x, this.y, this.z);

  @override
  String toString() => '(x: ${x.toStringAsFixed(2)} y: ${y.toStringAsFixed(2)}  z: ${z.toStringAsFixed(2)})';

  factory Vector3.fromJson(Map<String, dynamic> json) => _$Vector3FromJson(json);
  Map<String, dynamic> toJson() => _$Vector3ToJson(this);
}
