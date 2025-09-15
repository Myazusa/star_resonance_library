import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_resonance_library/core/module/focus_calculation_module.dart';

class ItemDetail extends ConsumerWidget{
  final String itemID;
  const ItemDetail(this.itemID, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemEntity = FocusCalculationModule.instance.getItemDetail(itemID)!;
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
                  clipBehavior: Clip.hardEdge,
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
          Column(
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
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  runSpacing: 5,
                  children: [
                    for (var i = 0; i < itemEntity.itemTags.length; i++)
                      Container(
                        height: 20,
                        color: Colors.blue,
                        alignment: Alignment.center,
                        child: Text(itemEntity.itemTags[i].name, style: const TextStyle(color: Colors.white)),
                      ),
                  ],
                )
              ]
          )
        ]
    ),
    );
  }
}