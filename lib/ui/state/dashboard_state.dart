import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_state.g.dart';

@Riverpod(keepAlive: true)
class SelectedIndexState extends _$SelectedIndexState {
  @override
  int build() => 0;

  void set(int value) => state = value;
}