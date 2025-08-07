class FocusConsumptionItem{
  String itemID;
  double consumeFocusValue;
  int consumeItemAmount;
  bool hasCrafting;

  FocusConsumptionItem(this.itemID, this.consumeFocusValue,
      this.consumeItemAmount,{this.hasCrafting=false});

}