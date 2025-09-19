

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:star_resonance_library/core/model/item_overview.dart';
import 'package:star_resonance_library/core/module/focus_calculation_module.dart';

part 'item_data_state.g.dart';

@Riverpod(keepAlive: true)
class ItemDataState extends _$ItemDataState{

  @override
  List<ItemOverview> build() => FocusCalculationModule.instance.getItemPrecisList();

  void set(List<ItemOverview> list) => state = list;
}