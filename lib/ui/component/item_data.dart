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
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Color.fromRGBO(212, 145, 253, 1.0), width: 4),
            ),
            clipBehavior: Clip.antiAlias,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.memory(
                imageData.buffer.asUint8List(),
                height: 60,
                width: 60,
                fit: BoxFit.cover,
                color: Colors.white.withOpacity(0.9),
                colorBlendMode: BlendMode.modulate
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