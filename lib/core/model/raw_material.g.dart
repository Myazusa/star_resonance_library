// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_material.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RawMaterial _$RawMaterialFromJson(Map<String, dynamic> json) => RawMaterial(
  (json['focusValue'] as num).toInt(),
  (json['perItemCollectingMinValue'] as num).toInt(),
  (json['perItemCollectingMaxValue'] as num).toInt(),
);

Map<String, dynamic> _$RawMaterialToJson(RawMaterial instance) =>
    <String, dynamic>{
      'focusValue': instance.focusValue,
      'perItemCollectingMinValue': instance.perItemCollectingMinValue,
      'perItemCollectingMaxValue': instance.perItemCollectingMaxValue,
    };
