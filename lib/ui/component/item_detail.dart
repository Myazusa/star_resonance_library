import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_resonance_library/core/enum/item_category.dart';
import 'package:star_resonance_library/core/enum/item_tag.dart';
import 'package:star_resonance_library/core/module/focus_calculation_module.dart';

class ItemDetail extends ConsumerWidget{
  final String itemID;
  const ItemDetail(this.itemID, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemEntity = FocusCalculationModule.instance.getItemDetail(itemID)!;
    final itemTotalFocus = FocusCalculationModule.instance.getTotalFocusConsumption(itemID);
    var itemFocusValue = 0;
    if(itemEntity.rawMaterial != null){
      itemFocusValue = itemEntity.rawMaterial!.focusValue;
    }
    return Container(
      padding: EdgeInsets.only(left: 40,top: 30,right: 40,bottom: 30),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
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
                    fit: BoxFit.cover
                  ),
                )
              ]
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
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 5,
                    children: [
                      for (var i = 0; i < itemEntity.itemTags.length; i++)
                        IntrinsicWidth(
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 10,right: 10,top: 2,bottom: 2),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(216, 190, 58, 1.0),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Text(itemEntity.itemTags[i].displayName, style: const TextStyle(color: Colors.white)),
                          ),
                        ),
                      IntrinsicWidth(
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 10,right: 10,top: 2,bottom: 2),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(161, 115, 248, 1.0),
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Text(itemEntity.item.itemCategory.displayName, style: const TextStyle(color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                  if(itemEntity.rawMaterial != null) const SizedBox(height: 8),
                  if(itemEntity.rawMaterial != null) Row(
                    children: [
                      Text("每次采集消耗",style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),),
                      SizedBox(width: 60),
                      Text(itemFocusValue.toString(),style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                          fontSize: 15,
                          fontWeight: FontWeight.w500))
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text("协会运货价值",style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),),
                      SizedBox(width: 60),
                      Text(itemEntity.item.perItemAssociationFreightValue.toString(),style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                          fontSize: 15,
                          fontWeight: FontWeight.w500))
                    ],
                  ),
                  if(itemTotalFocus != 0) const SizedBox(height: 8),
                  if(itemTotalFocus != 0) Row(
                    children: [
                      Text("合成链总消耗专注",style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),),
                      SizedBox(width: 60),
                      Text(itemTotalFocus.ceil().toString(),style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                          fontSize: 15,
                          fontWeight: FontWeight.w500))
                    ],
                  ),
                ]
            )
          )
        ]
    ),
    );
  }
}