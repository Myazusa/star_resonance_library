// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
  json['itemID'] as String,
  json['itemName'] as String,
  json['itemIconPath'] as String,
  (json['itemLevel'] as num).toInt(),
  json['isNoFocusConsumeItem'] as bool,
  (json['perItemAssociationFreightValue'] as num).toInt(),
  RawMaterial.fromJson(json['rawMaterial'] as Map<String, dynamic>),
  Crafting.fromJson(json['crafting'] as Map<String, dynamic>),
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
