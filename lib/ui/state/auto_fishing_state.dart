import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auto_fishing_state.g.dart';

@Riverpod(keepAlive: true)
class AutoFishingEnableState extends _$AutoFishingEnableState {
  @override
  bool build() => false;

  void set(bool value) => state = value;
}