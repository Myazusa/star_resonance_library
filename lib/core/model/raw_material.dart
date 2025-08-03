

import 'package:json_annotation/json_annotation.dart';

part 'raw_material.g.dart';

@JsonSerializable()
class RawMaterial{
  int focusValue;
  int perItemCollectingMinValue;
  int perItemCollectingMaxValue;

  RawMaterial(this.focusValue, this.perItemCollectingMinValue,
      this.perItemCollectingMaxValue);

  factory RawMaterial.fromJson(Map<String, dynamic> json) => _$RawMaterialFromJson(json);
  Map<String, dynamic> toJson() => _$RawMaterialToJson(this);
}