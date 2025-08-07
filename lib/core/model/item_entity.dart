import 'dart:typed_data';

import 'package:star_resonance_library/core/enum/item_tag.dart';
import 'package:star_resonance_library/core/model/crafting.dart';
import 'package:star_resonance_library/core/model/item.dart';
import 'package:star_resonance_library/core/model/raw_material.dart';

class ItemEntity{
  ByteData itemIcon;
  List<ItemTag> itemTags;
  Item item;
  RawMaterial? rawMaterial;
  Crafting? crafting;

  ItemEntity(this.itemIcon,this.itemTags, this.item, this.rawMaterial, this.crafting);

}