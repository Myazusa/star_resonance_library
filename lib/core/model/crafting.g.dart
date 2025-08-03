// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crafting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Crafting _$CraftingFromJson(Map<String, dynamic> json) => Crafting(
  (json['focusValue'] as num).toInt(),
  Map<String, int>.from(json['craftingTable'] as Map),
  (json['resultProbability'] as num).toDouble(),
  (json['resultMinValue'] as num).toInt(),
  (json['resultMaxValue'] as num).toInt(),
);

Map<String, dynamic> _$CraftingToJson(Crafting instance) => <String, dynamic>{
  'focusValue': instance.focusValue,
  'craftingTable': instance.craftingTable,
  'resultProbability': instance.resultProbability,
  'resultMinValue': instance.resultMinValue,
  'resultMaxValue': instance.resultMaxValue,
};
