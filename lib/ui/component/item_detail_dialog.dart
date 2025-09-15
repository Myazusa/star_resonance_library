import 'package:flutter/material.dart';
import 'package:star_resonance_library/ui/component/item_detail.dart';

class ItemDetailDialog{
  static Future<void> showFullScreenDialog(BuildContext context, String itemID) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.all(40),
          backgroundColor: Colors.transparent,
          child: ItemDetail(itemID),
        );
      },
    );
  }
}