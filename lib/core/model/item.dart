import 'package:json_annotation/json_annotation.dart';
import 'package:star_resonance_library/core/enum/item_category.dart';
import 'package:star_resonance_library/core/model/crafting.dart';
import 'package:star_resonance_library/core/model/raw_material.dart';

part 'item.g.dart';

@JsonSerializable()
class Item{
  String itemID;

  @JsonKey(defaultValue: '未知物品')
  String itemName;

  @JsonKey(defaultValue: ItemCategory.none)
  ItemCategory itemCategory;

  @JsonKey(defaultValue: '')
  String itemIconPath;

  @JsonKey(defaultValue: 0)
  int itemLevel;

  @JsonKey(defaultValue: false)
  bool isNoFocusConsumeItem;

  @JsonKey(defaultValue: 0)
  int perItemAssociationFreightValue;

  RawMaterial? rawMaterial;
  Crafting? crafting;


  Item(this.itemID, this.itemName, this.itemCategory, this.itemIconPath,
      this.itemLevel, this.isNoFocusConsumeItem,
      this.perItemAssociationFreightValue, this.rawMaterial, this.crafting);

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}



