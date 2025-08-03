import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:star_resonance_toolkit/core/enum/item_category.dart';
import 'package:star_resonance_toolkit/core/enum/item_tag.dart';
import 'package:star_resonance_toolkit/core/model/item.dart';
import 'package:star_resonance_toolkit/core/model/item_entity.dart';
import 'package:star_resonance_toolkit/core/util/assets_util.dart';

class ItemDataModule{
  static ItemDataModule? _instance;
  List<Item> items = [];
  List<ItemEntity> itemEntities = [];

  factory ItemDataModule({bool isEnable = false}) {
    return _instance ??= ItemDataModule._internal();
  }
  static ItemDataModule get instance {
    return _instance ??= ItemDataModule._internal();
  }
  ItemDataModule._internal();

  Future<void> readItemDataFromJson() async{
    final jsonString = await rootBundle.loadString('assets/data/items.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);
    items = jsonList.map((e) => Item.fromJson(e)).toList();
  }
  Future<void> constructItemEntityData() async{
    final ByteData? noIcon = await AssetsUtil.loadImage('assets/images/item/item_none.png');
    assert(noIcon != null,"默认Item资源图片为空");

    // todo: （优化）这里是串行for读取，需要改成多线程
    for(final item in items){
      ByteData? itemIcon;
      try{
        itemIcon = await AssetsUtil.loadImage(item.itemIconPath);
      }catch(e){
        log("物品ID为 ${item.itemID} 的图片不存在");
      }
      itemIcon ??= noIcon;

      // todo: 物品model里里少个物品类别，矿物学植物学这种的
      List<ItemCategory> itemCategories = [];
      List<ItemTag> itemTags = [];
      if(item.crafting == null){
        //itemTags
      }


      ItemEntity itemEntity = ItemEntity(itemIcon!, itemCategories, itemTags, item, item.rawMaterial, item.crafting);
      itemEntities.add(itemEntity);
    }
  }
}