import 'package:json_annotation/json_annotation.dart';

part 'crafting.g.dart';

@JsonSerializable()
class Crafting{
  int focusValue;
  Map<String,int> craftingTable;
  double resultProbability;
  int resultMinValue;
  int resultMaxValue;

  Crafting(this.focusValue, this.craftingTable, this.resultProbability,
      this.resultMinValue, this.resultMaxValue);

  factory Crafting.fromJson(Map<String, dynamic> json) => _$CraftingFromJson(json);
  Map<String, dynamic> toJson() => _$CraftingToJson(this);
}