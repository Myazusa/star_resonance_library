import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfoPage extends ConsumerWidget{
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          Text("暂时没有消息")
        ],
      ),
    );
  }
}