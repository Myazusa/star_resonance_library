class FocusCalculationModule{
  static FocusCalculationModule? _instance;
  factory FocusCalculationModule() {
    return _instance ??= FocusCalculationModule._internal();
  }

  static FocusCalculationModule get instance {
    return _instance ??= FocusCalculationModule._internal();
  }

  FocusCalculationModule._internal();
}