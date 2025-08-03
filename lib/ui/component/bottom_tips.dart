import 'package:flutter/material.dart';

class BottomTips{
  static SnackBar getBottomTipsBar(BuildContext context,String showText,{int detentionTime=5}) {
    return SnackBar(
      content: Text(showText,
        style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary
        ),),
      duration: Duration(seconds: detentionTime),
      backgroundColor: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.5),
    );
  }
  static SnackBar getBottomErrorTipsBar(BuildContext context,String showText,{int detentionTime=5}) {
    return SnackBar(
      content: Text(showText,
        style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary
        ),),
      duration: Duration(seconds: detentionTime),
      backgroundColor: Theme.of(context).colorScheme.error.withValues(alpha: 0.5),
    );
  }
}