import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_resonance_toolkit/ui/component/hover_tips.dart';

import 'package:star_resonance_toolkit/core/module/option_module.dart';
import 'package:star_resonance_toolkit/ui/component/item.dart';
import 'package:star_resonance_toolkit/ui/component/bottom_tips.dart';
import 'package:star_resonance_toolkit/ui/state/game_screen_state.dart';

class OptionPage extends ConsumerWidget{
  const OptionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Item(title: '游戏窗口设置',items: SelectGameScreen())
            ],
          ),
        )
    );
  }
}

class SelectGameScreen extends ConsumerWidget{
  const SelectGameScreen({super.key});

  static const TextStyle labelFontStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 15
  );

  void handleGetGameScreenInfo(BuildContext context,WidgetRef ref){
    int isFinish = OptionModule.instance.getGameScreenInfo(ref);
    switch (isFinish) {
      case 0: {
        ScaffoldMessenger.of(context).showSnackBar(
            BottomTips.getBottomTipsBar(context,'获取窗口成功')
        );
        break;
      }
      case 1:{
        ScaffoldMessenger.of(context).showSnackBar(
            BottomTips.getBottomErrorTipsBar(context,'找不到游戏窗口，获取失败')
        );
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = ref.watch(gameScreenStateProvider);
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Text("游戏屏幕尺寸",
                  style: labelFontStyle.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryFixedVariant,
                  )
              ),
              HoverTips.getHoverTips(context,"是不包含窗口标题栏的游戏屏幕区域，如果在游戏内修改了分辨率请再次捕获"),
              Spacer(),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(20),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondaryFixedDim,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('${info.width} x ${info.height}')
              )
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Text("游戏屏幕左上角锚点",
                  style: labelFontStyle.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryFixedVariant,
                  )
              ),
              HoverTips.getHoverTips(context,"用于定位游戏位于屏幕什么位置的锚点，如果窗口移动请再次捕获"),
              Spacer(),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(20),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondaryFixedDim,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('${info.point.x} , ${info.point.y}')
              )
            ],
          ),
          SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => handleGetGameScreenInfo(context,ref),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12)
                ),
                child: Text('捕获窗口'),
              )
            ],
          )
        ],
      ),
    );
  }
}