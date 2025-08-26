import 'package:flutter_test/flutter_test.dart';
import 'package:star_resonance_library/core/core.dart';
import 'package:star_resonance_library/core/module/focus_calculation_module.dart';

void main() {
  group('bbb', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    test('aaa', () async {
      // 测试获取带合成表的物品列表
      await Init.initItemData();

      final itemID = 'item_yuxianrongyan_2';
      final precisList = FocusCalculationModule.instance.getItemSyntheticChain(itemID);

      final rootItem = FocusCalculationModule.instance.getItemDetail(itemID);
      final rootMap = rootItem?.crafting?.craftingTable;

      double totalFocusConsumption = 0;

      for(final id in precisList){
        final itemEntity = FocusCalculationModule.instance.getItemDetail(id);
        final x = itemEntity?.crafting?.focusValue;
        final t = itemEntity?.crafting?.resultMinValue;
        if(t != null && x != null){
          final f = x / t;
          print('物品id为：${itemEntity?.item.itemName} 的每做一份消耗专注是：${f}');
          if(id != itemID && rootMap != null){
           final shuliang = rootMap[id]!;
           totalFocusConsumption += f * shuliang;
          }else{
            totalFocusConsumption += f;
          }
        }
        //print('物品id为：${itemEntity?.item.itemName} 的消耗专注是：${itemEntity?.crafting?.focusValue}');
      }
      print('制作这个物品总消耗的专注是：${totalFocusConsumption.toString()}');
      print(precisList);
    });
  });
}