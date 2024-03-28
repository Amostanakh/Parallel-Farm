import 'package:flutter/material.dart';
import 'package:parallel_farm/utils/utils.dart';

class GlobalDialog extends StatelessWidget {
  final String dialogTitle;
  final Color titleColor;
  final Widget dialogBody;
  final List<Widget> actions;
  final double contentPadding;

  const GlobalDialog(
      {super.key,
      required this.dialogTitle,
      required this.dialogBody,
      required this.actions,
      this.contentPadding = 0,
      this.titleColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        titlePadding: const EdgeInsets.all(0.0),
        title: Container(
          height: 50,
          width: screenWidth(context),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          ),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    // color: contrastColor,
                    size: 30,
                  )),
              Expanded(
                  child: Row(
                children: [
                  addHorizontalSpace(20),
                  Text(
                    dialogTitle.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ))
            ],
          ),
        ),
        content: SingleChildScrollView(child: dialogBody),
        contentPadding: EdgeInsets.all(contentPadding),
        actions: actions);
  }
}
