import 'package:flutter/material.dart';
import 'package:overlay_tooltip/overlay_tooltip.dart';

import 'tooltip_component.dart';

class OverlayPage extends StatefulWidget {
  const OverlayPage({Key? key}) : super(key: key);

  @override
  _OverlayPageState createState() => _OverlayPageState();
}

class _OverlayPageState extends State<OverlayPage> {
  final TooltipController _controller = TooltipController();
  bool agree = false;
  bool done = false;

  @override
  void initState() {
    _controller.onDone(() {
      setState(() {
        done = true;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayTooltipScaffold(
      overlayColor: Colors.red.withOpacity(.4),
      tooltipAnimationCurve: Curves.linear,
      tooltipAnimationDuration: const Duration(milliseconds: 1000),
      controller: _controller,
      startWhen: (initializedWidgetLength) async {
        await Future.delayed(const Duration(milliseconds: 500));
        return initializedWidgetLength == 3 && !done;
      },
      preferredOverlay: GestureDetector(
        onTap: () {
          _controller.dismiss();
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.blue.withOpacity(.2),
        ),
      ),
      builder: (context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            OverlayTooltipItem(
                displayIndex: 1,
                tooltip: (controller) => Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: MTooltip(title: 'Button', controller: controller),
                    ),
                child: Text('pw'))
          ],
        ),
        floatingActionButton: OverlayTooltipItem(
          displayIndex: 2,
          tooltip: (controller) => Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: MTooltip(title: 'Floating button', controller: controller),
          ),
          tooltipVerticalPosition: TooltipVerticalPosition.TOP,
          child: Text('Agreed'),
        ),
        body: ListView(
          children: [
            ...[
              OverlayTooltipItem(
                displayIndex: 0,
                tooltip: (controller) => Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: MTooltip(title: 'Text Tile', controller: controller),
                ),
                child: TextButton(
                    onPressed: () {
                      OverlayTooltipScaffold.of(context)?.controller.start();
                    },
                    child: const Text('How the App Work')),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
