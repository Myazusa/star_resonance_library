import 'dart:typed_data';

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

  (String?,ByteData?) getItemDetail(String itemID){
    final itemEntity = ItemDataModule.instance.itemEntities[itemID];

    return (itemEntity?.item.itemName,itemEntity?.itemIcon);
  }

  List<(String?,ByteData?)> getItemDetailList(){
    List<(String?,ByteData?)> itemDetailList = [];

    ItemDataModule.instance.itemEntities.forEach((key,value){
      itemDetailList.add((value.item.itemName,value.itemIcon));
    });

    return itemDetailList;
  }
}