import 'package:flutter/material.dart';

class UnorderedListItem extends StatefulWidget {
  UnorderedListItem({required this.state,required this.text});
  final String text;
  final bool state;

  @override
  State<UnorderedListItem> createState() => _UnorderedListItemState();
}

class _UnorderedListItemState extends State<UnorderedListItem> {
  @override
  Widget build(BuildContext context) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("• "),
        Expanded(
          child: Text(widget.text,
          style: TextStyle(fontWeight: FontWeight.w300,
          color: Colors.redAccent),),
        ),
      ],
    );
  }
}