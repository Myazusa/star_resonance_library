import 'dart:typed_data';

import 'package:star_resonance_toolkit/core/enum/item_category.dart';
import 'package:star_resonance_toolkit/core/enum/item_tag.dart';
import 'package:star_resonance_toolkit/core/model/crafting.dart';
import 'package:star_resonance_toolkit/core/model/item.dart';
import 'package:star_resonance_toolkit/core/model/raw_material.dart';

class ItemEntity{
  ByteData itemIcon;
  List<ItemCategory> itemCategories;
  List<ItemTag> itemTags;
  Item item;
  RawMaterial? rawMaterial;
  Crafting? crafting;

  ItemEntity(this.itemIcon, this.itemCategories,this.itemTags, this.item, this.rawMaterial, this.crafting);

}