import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'package:star_resonance_library/ui/router/router.dart';
import 'package:star_resonance_library/ui/state/dashboard_state.dart';

/// 程序入口，同时也属于ui类
void main() {
  runApp(
    ProviderScope(
      child: Main(),
    ),
  );
  doWhenWindowReady(() {
    final initialSize = Size(800, 480);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'ResourceHanRoundedCN',
        fontFamilyFallback: ['ResourceHanRoundedJP']),
    );
  }
}

class MainLayout extends StatelessWidget {
  final Widget child;
  const MainLayout({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WindowBorder(
          width: 3,
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top:20,bottom: 20,left: 10,right: 10),
                child: SizedBox(width: 170, child: Dashboard()),
              ),
              Padding(
                padding: EdgeInsets.only(top:20,bottom: 20),
                child: VerticalDivider(width: 1),
              ),
              Expanded(child: Column(
                children: [
                  WindowTitleBarBox(
                    child: Row(
                      children: [
                        Expanded(child: MoveWindow()),
                        WindowButtons(),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: child,
                      )
                  ),
                ],
              ))
            ],
          )
      ),
    );
  }
}

class Dashboard extends ConsumerWidget{
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: CustomNavigationRail()
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  WindowButtonColors getButtonColors(BuildContext context){
    return WindowButtonColors(
      iconNormal: Theme.of(context).colorScheme.secondary,
      mouseOver: Theme.of(context).colorScheme.tertiaryFixedDim,
      mouseDown: Theme.of(context).colorScheme.tertiaryFixedDim,
      iconMouseOver: Theme.of(context).colorScheme.onSecondary,
      iconMouseDown: Theme.of(context).colorScheme.onSecondary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: getButtonColors(context)),
        MaximizeWindowButton(colors: getButtonColors(context)),
        CloseWindowButton(colors: getButtonColors(context)),
      ],
    );
  }
}

class CustomNavigationRail extends ConsumerWidget  {

  const CustomNavigationRail({
    super.key,
  });

  void replaceRouter(BuildContext context,int i){
    switch (i) {
      case 0:
        context.replace('/info');
        break;
      case 1:
        context.replace('/auto_fishing');
        break;
      case 2:
        context.replace('/option');
        break;
      case _:
        log("不存在的路由");
    }
  }

  void onTap(BuildContext context,int index,WidgetRef ref){
    // 设置索引值
    ref.read(selectedIndexStateProvider.notifier).set(index);
    // 跳转路由
    replaceRouter(context, index);
  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final items = [
      (Icons.home, "主页"),
      (Icons.phishing, "自动钓鱼"),
      (Icons.settings, "设置")
    ];
    final selectedIndexState = ref.watch(selectedIndexStateProvider);
    return Container( // todo: 这里还要插入一个icon image
      color: Theme.of(context).colorScheme.surface,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(items.length, (index) {
          // 直接监听索引值，从而改变是否被选中状态
          final bool isSelected = index == selectedIndexState;
          final color = isSelected
              ? Theme.of(context).colorScheme.onSecondary
              : Theme.of(context).colorScheme.secondary;
          return InkWell(
            onTap: () => onTap(context,index,ref),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: BoxDecoration(
                color: isSelected ? Theme.of(context).colorScheme.tertiaryFixedDim : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(items[index].$1, color: color),
                  SizedBox(width: 4),
                  Text(
                    items[index].$2,
                    style: TextStyle(color: color, fontSize: 14),
                    textAlign: TextAlign.center,
                    // 超出显示...
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}