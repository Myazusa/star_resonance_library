import 'dart:typed_data';

import 'package:star_resonance_toolkit/core/model/item_entity.dart';
import 'package:star_resonance_toolkit/core/module/common/item_data_module.dart';

class FocusCalculationModule{
  static FocusCalculationModule? _instance;
  factory FocusCalculationModule() {
    return _instance ??= FocusCalculationModule._internal();
  }

  static FocusCalculationModule get instance {
    return _instance ??= FocusCalculationModule._internal();
  }

  FocusCalculationModule._internal();

  /// 返回物品名，物品图标
  (String?,ByteData?) getItemPrecis(String itemID){
    final itemEntity = ItemDataModule.instance.itemEntities[itemID];

    return (itemEntity?.item.itemName,itemEntity?.itemIcon);
  }

  /// 返回列表的物品名，物品图标
  List<(String?,ByteData?)> getItemPrecisList(){
    List<(String?,ByteData?)> itemDetailList = [];

    ItemDataModule.instance.itemEntities.forEach((key,value){
      itemDetailList.add((value.item.itemName,value.itemIcon));
    });

    return itemDetailList;
  }

  ItemEntity? getItemDetail(String itemID){
    final itemEntity = ItemDataModule.instance.itemEntities[itemID];
    return itemEntity;
  }

  // todo: 记得计算总耗费专注值
  /// 返回键值对的<物品ID，物品craftingTable对象>
  Map<String,Map<String,int>>? getItemSyntheticChain(ItemEntity itemEntity){
    // 创建每一层的List，里面装有每一个要合成的东西的craftingTable
    Map<String,Map<String,int>> layerMap = {};

    // 添加最高层的合成表，也就是当前物品的合成表
    //layerMap.putIfAbsent(itemEntity.item.itemID,()=>itemEntity.crafting!.craftingTable);

    // 内联的递归id函数
    void dfs(String currentItemId) {
      // 不允许递归已经递归过的id，否则会循环依赖
      if (layerMap[currentItemId] != null ) return;

      // 检查当前的物品id是否存在并且有craftingTable，没有就返回，有就记录并继续看子物品
      final craftingTable = _getItemCraftingTable(currentItemId);
      if(craftingTable == null){
        return;
      }
      layerMap.putIfAbsent(currentItemId, ()=>craftingTable);

      // 因为存在了crafting对象，所以必定有craftingTable，遍历它获取子物品id
      for(final entity in itemEntity.crafting!.craftingTable.entries){
        // 这个id存在并且有craftingTable就递归，不存在就跳过
        final craftingTable = _getItemCraftingTable(entity.key);
        if(craftingTable == null){
          continue;
        }
        dfs(entity.key);
      }
    }

    // 开始递归，传入要递归的物品的id
    dfs(itemEntity.item.itemID);

    return layerMap;
  }

  Map<String, int>? _getItemCraftingTable(String itemID){
    final itemDetail = getItemDetail(itemID);
    if(itemDetail == null){
      return null;
    }

    if(itemDetail.crafting != null){
      return itemDetail.crafting!.craftingTable;
    }

    return null;
  }
}