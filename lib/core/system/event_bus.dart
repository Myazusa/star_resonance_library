import 'dart:async';

import 'package:event_bus/event_bus.dart' as ev;

/// 强加载单例
class EventBus {
  EventBus._internal();

  static final EventBus _instance = EventBus._internal();

  static final Map<String, List<StreamSubscription>> _subscriptions = {};
  static EventBus get instance {
    return _instance;
  }


  final ev.EventBus _bus = ev.EventBus();

  /// 发送事件
  /// [event] 传入事件对象，可以自定义
  void sendEvent<T>(T event) {
    _bus.fire(event);
  }

  /// 订阅事件
  /// [key] 这个事件的名称
  /// [handler] 传入一个回调函数，函数里面写事件触发后要做什么事情
  StreamSubscription<T> subscribeEvent<T>(String key,void Function(T) handler) {
    final subscription = _bus.on<T>().listen(handler);
    _subscriptions.putIfAbsent(key, () => []).add(subscription);
    return subscription;
  }

  /// 取消订阅事件
  /// [key] 事件名称
  /// [sub] 持有的订阅
  Future<void> cancelSubscription(String key, StreamSubscription sub) async {
    await sub.cancel();
    _subscriptions[key]?.remove(sub);
  }

  /// 取消某个key下所有订阅
  Future<void> cancelAllByKey(String key) async {
    if (_subscriptions[key] != null) {
      for (final sub in _subscriptions[key]!) {
        await sub.cancel();
      }
      _subscriptions.remove(key);
    }
  }

  /// 取消所有订阅
  Future<void> cancelAll() async {
    for (final subs in _subscriptions.values) {
      for (final sub in subs) {
        await sub.cancel();
      }
    }
    _subscriptions.clear();
  }
}