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

extension ItemCategoryExtension on ItemCategory {
  String get displayName {
    switch (this) {
      case ItemCategory.none:
        return "无";
      case ItemCategory.mineralogy:
        return "矿物学";
      case ItemCategory.gastronomy:
        return "烹饪学";
      case ItemCategory.botany:
        return "植物学";
      case ItemCategory.technology:
        return "工艺学";
      case ItemCategory.alchemy:
        return "炼金学";
      case ItemCategory.carpentry:
        return "木作学";
      case ItemCategory.forging:
        return "锻造学";
      case ItemCategory.cottonocracy:
        return "纺织学";
      case ItemCategory.crystallography:
        return "晶石学";
    }
  }
}