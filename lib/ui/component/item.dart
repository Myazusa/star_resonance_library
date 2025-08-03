import 'package:flutter/material.dart';

class Item extends StatelessWidget{
  final String title;
  final Widget items;
  static const TextStyle titleFontStyle = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 20
  );

  const Item({super.key,required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            width: double.infinity,
            child: Text(title,
                style: titleFontStyle.copyWith(color: Theme.of(context).colorScheme.secondary),
                textAlign: TextAlign.start)
        ),
        Padding(
          padding: EdgeInsets.only(top:5,right: 400),
          child: Divider(height: 1),
        ),
        Padding(
            padding: EdgeInsets.only(top: 15,bottom: 30),
            child: items
        )
      ],
    );
  }
}