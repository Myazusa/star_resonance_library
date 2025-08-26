import 'package:flutter_test/flutter_test.dart';
import 'package:star_resonance_library/core/core.dart';
import 'package:star_resonance_library/core/module/focus_calculation_module.dart';

void main() {
  group('a', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    test('aa', () async {
      // 测试获取带合成表的物品列表专注值的计算
      await Init.initItemData();

      final itemID = 'item_yuxianrongyan_2';
      final precisList = FocusCalculationModule.instance.getItemSyntheticChain(itemID);

      final rootItem = FocusCalculationModule.instance.getItemDetail(itemID);
      final rootMap = rootItem?.crafting?.craftingTable;

      double totalFocusConsumption = 0;
      print('物品计算公式为：');
      for(final id in precisList){
        final itemEntity = FocusCalculationModule.instance.getItemDetail(id);
        final focusValue = itemEntity?.crafting?.focusValue;
        final resultMinValue = itemEntity?.crafting?.resultMinValue;

        if(resultMinValue != null && focusValue != null){
          final focusValuePerResultMinValue = focusValue / resultMinValue;
          //print('每做一份 ${itemEntity?.item.itemName} 所消耗专注是：${f}');
          if(id != itemID && rootMap != null){
           final shuliang = rootMap[id]!;
           print('${itemEntity?.item.itemName}(${focusValue}) ÷ ${resultMinValue} × ${shuliang}');
           totalFocusConsumption += focusValuePerResultMinValue * shuliang;
          }else{
            totalFocusConsumption += focusValuePerResultMinValue;
            print('${itemEntity?.item.itemName}(${focusValue}) ÷ ${resultMinValue}');
          }
        }
        //print('物品id为：${itemEntity?.item.itemName} 的消耗专注是：${itemEntity?.crafting?.focusValue}');
      }
      print('制作1个这个物品总消耗的专注是：${totalFocusConsumption}');
      //print(precisList);
    });
  });
}