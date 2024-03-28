import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parallel_farm/constants/constants.dart';
import 'package:parallel_farm/services/streak_services.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';

class SimpleProgressIndicatorsApp extends StatefulWidget {
  const SimpleProgressIndicatorsApp({Key? key}) : super(key: key);

  @override
  State<SimpleProgressIndicatorsApp> createState() =>
      _SimpleProgressIndicatorsAppState();
}

class _SimpleProgressIndicatorsAppState
    extends State<SimpleProgressIndicatorsApp> {
  StreakServices streakDataService = StreakServices();
  bool full = false;
  List mystreakDataList = [];

  @override
  void initState() {
    // TODO: implement initState
    getMyStreakData();
    super.initState();
  }

  Future<dynamic> getMyStreakData() async {
    final mystreakData = await streakDataService.getStreakService();
    mystreakDataList.add(mystreakData);
  }

  @override
  Widget build(BuildContext context) {
    var myStreakDailyOpen =
        (((mystreakDataList[0]['totalNumberOfDaysOpened'] / 30) * 100) / 10);
    var myData = myStreakDailyOpen.toStringAsFixed(1);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Simple Progress Indicator Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AnimatedProgressBar(
                onEnd: () {
                  Fluttertoast.showToast(
                    msg: "Day 30 Today",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey,
                    textColor: Colors.white,
                    fontSize: 15.0,
                  );
                },
                width: double.infinity,
                height: 50,
                value: double.parse(myData),
                duration: const Duration(seconds: 3),
                gradient: const LinearGradient(
                  colors: [
                    greenColor,
                    Colors.black12,
                    greenColor,
                    Colors.black,
                    Colors.black12,
                    greenColor,
                    Colors.black,
                  ],
                ),
                backgroundColor: Colors.grey.withOpacity(0.4),
              ),
            ],
          ),
        ));
  }
}




// AnimatedProgressBar(
//                     value: full ? 1.0 : 0.0,
//                     height: 30,
//                     duration: Duration(seconds: 2),
//                     gradient: LinearGradient(
//                       colors: [
//                         greenColor,
//                         Colors.grey,
//                         greenColor,
//                         Colors.grey,
//                         greenColor,
//                         Colors.grey,
//                         greenColor,
//                         Colors.grey,
//                         greenColor,
//                         Colors.grey,
//                         greenColor,
//                         Colors.grey,
//                         greenColor,
//                         Colors.grey,
//                         greenColor,
//                         Colors.grey,
//                         Colors.yellow,
//                         Colors.yellow,
//                         Colors.yellow
//                       ],
//                     ),
//                     backgroundColor: Colors.brown,
//                   ),