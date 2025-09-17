enum ItemTag{
  synthesizable, // 可合成
  syntheticChain, // 有合成链
  participateSynthesis,  // 参与合成
  nonSynthetic,  // 不可合成
  gatherings,  // 采集获取
  noConsumeFocus  // 不消耗专注
}

extension ItemTagExtension on ItemTag{
  String get displayName {
    switch (this) {
      case ItemTag.synthesizable:
        return "可合成";
      case ItemTag.syntheticChain:
        return "有合成链";
      case ItemTag.participateSynthesis:
        return "参与合成";
      case ItemTag.nonSynthetic:
        return "不可合成";
      case ItemTag.gatherings:
        return "采集获取";
      case ItemTag.noConsumeFocus:
        return "不消耗专注";
    }
  }
}