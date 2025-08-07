import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_resonance_library/ui/component/bottom_tips.dart';
import 'package:star_resonance_library/ui/state/auto_fishing_state.dart';
import 'package:star_resonance_library/ui/component/item.dart';

class FishingPage extends ConsumerWidget {
  const FishingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Item(title: '功能',items: EnableAutoFishing()),
            Item(title: '钓鱼设置',items: AutoFishingSetting())
          ],
        ),
      )
    );
  }
}



class EnableAutoFishing extends ConsumerWidget{
  const EnableAutoFishing({super.key});

  static const TextStyle labelFontStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 15
  );

  Future<void> changeAutoFishingEnableState(BuildContext context,WidgetRef ref,bool value) async {
    ref.read(autoFishingEnableStateProvider.notifier).set(value);
    if(value){
      ScaffoldMessenger.of(context).showSnackBar(
          BottomTips.getBottomTipsBar(context,'成功开启自动钓鱼，注意不要有任何窗口遮挡游戏，3秒后将最小化此窗口')
      );
      await Future.delayed(const Duration(seconds: 3));
      appWindow.minimize();
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          BottomTips.getBottomTipsBar(context,'已关闭自动钓鱼')
      );
    }
  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Container(
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryFixed,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(78, 78, 78, 0.3),
              blurRadius: 1,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
            padding: EdgeInsets.only(top: 5,bottom: 5,left: 24,right: 24),
          child: Row(
            children: [
              Text("启用自动钓鱼",
                  style: labelFontStyle.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryFixedVariant,
                  )
              ),
              Spacer(),
              Switch(value: ref.watch(autoFishingEnableStateProvider), onChanged: (value) async {
                await changeAutoFishingEnableState(context, ref, value);
              })
            ],
          )
        ),
      );
  }
}

class AutoFishingSetting extends ConsumerWidget{
  const AutoFishingSetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text("暂时没有可用设置");
  }
}