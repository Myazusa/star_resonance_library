import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemData extends ConsumerWidget{
  final ByteData imageData;
  final String text;

  const ItemData({
    super.key,
    required this.imageData,
    required this.text,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.red, width: 4),
            ),
            clipBehavior: Clip.hardEdge,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5)
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.memory(
                imageData.buffer.asUint8List(),
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          )
        ],
      )
    );
  }
}