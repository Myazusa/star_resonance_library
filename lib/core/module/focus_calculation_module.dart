import 'dart:typed_data';

import 'package:star_resonance_library/core/model/focus_consumption_item.dart';
import 'package:star_resonance_library/core/model/item_entity.dart';
import 'package:star_resonance_library/core/module/common/item_data_module.dart';

class FocusCalculationModule{
  static FocusCalculationModule? _instance;

  List<String> craftingItems = [];

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

  /// 返回计算总消耗专注。注意：里面会调用递归物品合成的方法
  double? getTotalFocusConsumption(String itemID){
    double totalFocusConsumption = 0;

    final precisList = getItemSyntheticChain(itemID);

    final rootItem = getItemDetail(itemID);
    final rootMap = rootItem?.crafting?.craftingTable;

    for(final id in precisList){
      final itemEntity = getItemDetail(id);
      final focusValue = itemEntity?.crafting?.focusValue;
      final resultMinValue = itemEntity?.crafting?.resultMinValue;

      if(resultMinValue != null && focusValue != null){
        final focusValuePerResultMinValue = focusValue / resultMinValue;
        if(id != itemID && rootMap != null){
          final shuliang = rootMap[id]!;
          // todo:还需要显示计算物品的表达式
          //print('${itemEntity?.item.itemName}(${focusValue}) ÷ ${resultMinValue} × ${shuliang}');
          totalFocusConsumption += focusValuePerResultMinValue * shuliang;
        }else{
          totalFocusConsumption += focusValuePerResultMinValue;
          //print('${itemEntity?.item.itemName}(${focusValue}) ÷ ${resultMinValue}');
        }
      }
    }

    return totalFocusConsumption;
  }

  /// 返回的是物品ID的列表，该方法用于获取显示合成链的物品合成表，不涉及计算专注消耗
  List<String> getItemSyntheticChain(String itemID){
    // 创建每一层的List，里面装有每一个要合成的东西的craftingTable
    if(craftingItems.isNotEmpty){
      craftingItems = [];
    }

    // 添加最高层的合成表，也就是当前物品的合成表
    //layerMap.putIfAbsent(itemEntity.item.itemID,()=>itemEntity.crafting!.craftingTable);

    // 内联的递归id函数
    void dfs(String currentItemId) {
      // 不允许递归已经递归过的id，否则会循环依赖
      if (craftingItems.contains(currentItemId)) return;

      // 检查当前的物品id是否存在并且有craftingTable，没有就返回，有就记录并继续看子物品
      final itemEntity = _getItemIfHasCraftingTable(currentItemId);
      if(itemEntity == null){
        return;
      }
      craftingItems.add(currentItemId);

      // 因为存在了crafting对象，所以必定有craftingTable，遍历它获取子物品id
      for(final entity in itemEntity.crafting!.craftingTable.entries){
        // 这个id存在并且有craftingTable就递归，不存在就跳过
        final i = _getItemIfHasCraftingTable(entity.key);
        if(i == null){
          continue;
        }
        dfs(entity.key);
      }
    }

    // 开始递归，传入要递归的物品的id
    dfs(itemID);

    return craftingItems;
  }

  ItemEntity? _getItemIfHasCraftingTable(String itemID){
    final itemDetail = getItemDetail(itemID);
    if(itemDetail == null){
      return null;
    }

    if(itemDetail.crafting != null){
      return itemDetail;
    }

    return null;
  }
}