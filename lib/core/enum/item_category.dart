import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum ItemCategory{
  none,
  mineralogy, // 矿物学
  gastronomy, // 烹饪学
  botany,  // 植物学
  technology, // 工艺学
  alchemy, // 炼金学
  carpentry, // 木作学
  forging,  // 锻造学
  cottonocracy,  // 纺织学
  crystallography // 晶石学
}