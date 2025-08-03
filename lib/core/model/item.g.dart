// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
  json['itemID'] as String,
  json['itemName'] as String? ?? '未知物品',
  json['itemIconPath'] as String? ?? '',
  (json['itemLevel'] as num?)?.toInt() ?? 0,
  json['isNoFocusConsumeItem'] as bool? ?? false,
  (json['perItemAssociationFreightValue'] as num?)?.toInt() ?? 0,
  json['rawMaterial'] == null
      ? null
      : RawMaterial.fromJson(json['rawMaterial'] as Map<String, dynamic>),
  json['crafting'] == null
      ? null
      : Crafting.fromJson(json['crafting'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
  'itemID': instance.itemID,
  'itemName': instance.itemName,
  'itemIconPath': instance.itemIconPath,
  'itemLevel': instance.itemLevel,
  'isNoFocusConsumeItem': instance.isNoFocusConsumeItem,
  'perItemAssociationFreightValue': instance.perItemAssociationFreightValue,
  'rawMaterial': instance.rawMaterial,
  'crafting': instance.crafting,
};
