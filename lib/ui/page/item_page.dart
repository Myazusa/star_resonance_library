
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_resonance_library/ui/component/item_data.dart';
import 'package:star_resonance_library/ui/component/item_detail_dialog.dart';
import 'package:star_resonance_library/ui/state/item_data_state.dart';

class ItemPage extends ConsumerWidget{

  const ItemPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemDataStateProvider);
    return Scaffold(
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return GestureDetector(
              onTap: (){
                ItemDetailDialog.showFullScreenDialog(context,item.itemID);
              },
              child: ItemData(
                  text: item.itemName,
                  imageData: item.itemIcon),
            );
          }
      ),
    );
  }

}