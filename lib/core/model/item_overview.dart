import 'dart:typed_data';

class ItemOverview{
  String itemID;
  String itemName;
  ByteData itemIcon;

  ItemOverview(this.itemID, this.itemName, this.itemIcon);
}