import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_resonance_library/core/enum/item_category.dart';
import 'package:star_resonance_library/core/enum/item_tag.dart';
import 'package:star_resonance_library/core/module/focus_calculation_module.dart';
import 'package:star_resonance_library/ui/component/item_data.dart';

class ItemDetail extends ConsumerWidget {
  final String itemID;

  const ItemDetail(this.itemID, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const double spaceValue = 8.0;
    const double textSpaceValue = 16.0;
    final TextStyle operatorsTextStyle = TextStyle(
      color: Theme.of(context).colorScheme.onPrimaryContainer,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );

    final itemEntity = FocusCalculationModule.instance.getItemDetail(itemID)!;

    final itemTotalFocus = FocusCalculationModule.instance
        .getTotalFocusConsumption(itemID);
    var itemCraftingList = [];
    if (itemTotalFocus != 0) {
      itemCraftingList = FocusCalculationModule.instance.getItemSyntheticChain(
        itemID,
      );
    }

    var itemFocusValue = 0;
    if (itemEntity.rawMaterial != null) {
      itemFocusValue = itemEntity.rawMaterial!.focusValue;
    }

    double associationFreightFocusValue = 1;
    if(itemTotalFocus != 0){
      associationFreightFocusValue = itemTotalFocus;
    }else if(itemEntity.rawMaterial != null){
      associationFreightFocusValue = itemEntity.rawMaterial!.focusValue / itemEntity.rawMaterial!.perItemCollectingMinValue;
    }
    final associationFreightItemQuantity = FocusCalculationModule.instance.getAssociationFreightItemQuantity(itemEntity.item.perItemAssociationFreightValue);

    return Container(
      padding: EdgeInsets.only(left: 40, top: 30, right: 40, bottom: 30),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.memory(
                        itemEntity.itemIcon.buffer.asUint8List(),
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        itemEntity.item.itemName,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: spaceValue),
                      Wrap(
                        spacing: 8,
                        runSpacing: 5,
                        children: [
                          for (var i = 0; i < itemEntity.itemTags.length; i++)
                            IntrinsicWidth(
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: 2,
                                  bottom: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(216, 190, 58, 1.0),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  itemEntity.itemTags[i].displayName,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          IntrinsicWidth(
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 2,
                                bottom: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(161, 115, 248, 1.0),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                itemEntity.item.itemCategory.displayName,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (itemEntity.rawMaterial != null)
                        const SizedBox(height: spaceValue),
                      if (itemEntity.rawMaterial != null)
                        Row(
                          children: [
                            Text(
                              "每次采集消耗",
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: textSpaceValue),
                            Text(
                              itemFocusValue.toString(),
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      if (itemEntity.rawMaterial != null)
                        const SizedBox(height: spaceValue),
                      if (itemEntity.rawMaterial != null)
                        Row(
                          children: [
                            Text(
                              "每次最少获得个数",
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: textSpaceValue),
                            Text(
                              itemEntity.rawMaterial!.perItemCollectingMinValue
                                  .toString(),
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: spaceValue),
                      Row(
                        children: [
                          Text(
                            "协会运货价值",
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: textSpaceValue),
                          Text(
                            itemEntity.item.perItemAssociationFreightValue
                                .toString(),
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      if (associationFreightItemQuantity != null)
                        const SizedBox(height: spaceValue),
                      if (associationFreightItemQuantity != null)
                        Row(
                          children: [
                            Text(
                              "协会运货所需数量",
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: textSpaceValue),
                            Text(
                              associationFreightItemQuantity.toString(),
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      if (itemTotalFocus != 0)
                        const SizedBox(height: spaceValue),
                      if (itemTotalFocus != 0)
                        Row(
                          children: [
                            Text(
                              "合成链总消耗专注",
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: textSpaceValue),
                            Text(
                              itemTotalFocus.toStringAsFixed(2),
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      if (itemTotalFocus != 0 && associationFreightItemQuantity != null)
                        const SizedBox(height: spaceValue),
                      if (itemTotalFocus != 0 && associationFreightItemQuantity != null)
                        Row(
                          children: [
                            Text(
                              "协会运货所需消耗专注",
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: textSpaceValue),
                            Text(
                              (associationFreightItemQuantity * itemTotalFocus).toStringAsFixed(2),
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      if (associationFreightItemQuantity != null)
                        const SizedBox(height: spaceValue),
                      if (associationFreightItemQuantity != null)
                        Row(
                          children: [
                            Text(
                              "该协会运货金钱专注比为",
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: textSpaceValue),
                            Text(
                              "${(18000 / (associationFreightItemQuantity * associationFreightFocusValue)).toStringAsFixed(2)} 金钱每专注",
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
            if (itemCraftingList.isNotEmpty)
              Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    "合成链表",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: itemCraftingList.map((craftingItemID) {
                        final itemEntity = FocusCalculationModule.instance
                            .getItemDetail(craftingItemID);
                        final rawMaterialItemMap =
                            itemEntity!.crafting!.craftingTable;
                        List<Row> rows = [];
                        final tItem = FocusCalculationModule.instance
                            .getItemPrecis(craftingItemID)!;
                        rows.add(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                itemEntity.crafting!.resultMinValue.toString(),
                                textAlign: TextAlign.center,
                                style: operatorsTextStyle,
                              ),
                              Text(
                                "×",
                                textAlign: TextAlign.center,
                                style: operatorsTextStyle,
                              ),
                              ItemData(
                                imageData: tItem.itemIcon,
                                text: tItem.itemName,
                              ),
                              Text(
                                "=",
                                textAlign: TextAlign.center,
                                style: operatorsTextStyle,
                              ),
                            ],
                          ),
                        );
                        for (var item in rawMaterialItemMap.entries) {
                          // 获取该物品图像
                          final ovItem = FocusCalculationModule.instance
                              .getItemPrecis(item.key);
                          if (ovItem != null) {
                            rows.add(
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    item.value.toString(),
                                    textAlign: TextAlign.center,
                                    style: operatorsTextStyle,
                                  ),
                                  Text(
                                    "×",
                                    textAlign: TextAlign.center,
                                    style: operatorsTextStyle,
                                  ),
                                  ItemData(
                                    imageData: ovItem.itemIcon,
                                    text: ovItem.itemName,
                                  ),
                                  if (item.key != rawMaterialItemMap.keys.last)
                                    Text(
                                      "+",
                                      textAlign: TextAlign.center,
                                      style: operatorsTextStyle,
                                    ),
                                ],
                              ),
                            );
                          } else {
                            rows.add(
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    item.value.toString(),
                                    textAlign: TextAlign.center,
                                    style: operatorsTextStyle,
                                  ),
                                  Text(
                                    "×",
                                    textAlign: TextAlign.center,
                                    style: operatorsTextStyle,
                                  ),
                                  Text("未知物品"),
                                  if (item.key != rawMaterialItemMap.keys.last)
                                    Text(
                                      "+",
                                      textAlign: TextAlign.center,
                                      style: operatorsTextStyle,
                                    ),
                                ],
                              ),
                            );
                          }
                        }
                        return Container(
                          margin: EdgeInsets.only(top: 20, bottom: 20),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: rows,
                          ),),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
