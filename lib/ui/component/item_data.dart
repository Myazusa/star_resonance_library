import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
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
          Image.memory(
            imageData.buffer.asUint8List(),
            height: 60,
            width: 60,
            fit: BoxFit.cover,
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