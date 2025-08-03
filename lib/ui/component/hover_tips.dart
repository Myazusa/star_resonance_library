import 'package:flutter/material.dart';

class HoverTips{
  static Widget getHoverTips(BuildContext context,String showText) {
    return Padding(
      padding: EdgeInsets.only(left: 3),
      child: Tooltip(
        message: showText,
        waitDuration: Duration(microseconds: 500),
        child: Icon(
          size: 16,
          Icons.help,
          color: Theme.of(context).colorScheme.primary.withAlpha(100),
        )
    ),);
  }
}