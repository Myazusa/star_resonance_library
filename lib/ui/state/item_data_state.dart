
import 'dart:typed_data';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:star_resonance_library/core/module/focus_calculation_module.dart';

part 'item_data_state.g.dart';

@Riverpod(keepAlive: true)
class ItemDataState extends _$ItemDataState{

  @override
  List<(String?,ByteData?)> build() => FocusCalculationModule.instance.getItemPrecisList();

  void set(List<(String?,ByteData?)> list) => state = list;
}