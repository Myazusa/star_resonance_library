import 'package:json_annotation/json_annotation.dart';
import 'package:star_resonance_toolkit/core/model/crafting.dart';
import 'package:star_resonance_toolkit/core/model/raw_material.dart';

part 'item.g.dart';

@JsonSerializable()
class Item{
  String itemID;
  String itemName;
  String itemIconPath;
  int itemLevel;
  bool isNoFocusConsumeItem;
  int perItemAssociationFreightValue;
  RawMaterial rawMaterial;
  Crafting crafting;

  Item(this.itemID, this.itemName, this.itemIconPath, this.itemLevel,
      this.isNoFocusConsumeItem, this.perItemAssociationFreightValue,
      this.rawMaterial, this.crafting);

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}



