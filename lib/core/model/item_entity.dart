import 'dart:typed_data';

import 'package:star_resonance_toolkit/core/enum/item_category.dart';
import 'package:star_resonance_toolkit/core/enum/item_tag.dart';
import 'package:star_resonance_toolkit/core/model/crafting.dart';
import 'package:star_resonance_toolkit/core/model/raw_material.dart';

class ItemEntity{
  String itemID;
  String itemName;
  ByteBuffer itemIcon;
  ItemCategory itemCategory;
  ItemTag itemTag;
  RawMaterial rawMaterial;
  Crafting crafting;

  ItemEntity(this.itemID, this.itemName, this.itemIcon, this.itemCategory,
      this.itemTag, this.rawMaterial, this.crafting);

}