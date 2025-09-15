import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_resonance_library/core/module/focus_calculation_module.dart';

class ItemDetail extends ConsumerWidget{
  final String itemID;
  const ItemDetail(this.itemID, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemEntity = FocusCalculationModule.instance.getItemDetail(itemID)!;
    return Row(
      children: [
        Column(
          children: [
            Container(
              padding: EdgeInsetsGeometry.directional(start: 10,end: 50,top: 10,bottom: 10),
              child: Image.memory(
                      itemEntity.itemIcon.buffer.asUint8List(),
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover
                  ),
            )
          ]
        ),
        Column(
          children: [
            Text(
              itemEntity.item.itemName,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis
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
    );
  }

}