import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parallel_farm/constants/gameConstants.dart';
import 'package:parallel_farm/game/screens/main_screen.dart';
import 'package:parallel_farm/models/animal_model.dart';
import 'package:parallel_farm/services/streak_services.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';

import '../services/barn_service.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home_screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _loading = true;
  late FlameGame _game;

  StreakServices streakDataService = StreakServices();

  String animalsFeed = '';
  bool full = false;

  List mystreakDataList = [];
  List claimReward = [];

  bool isLoading = false;

  void _handleButtonPress() async {
    setState(() {
      isLoading = true;
    });

    final myClaimRewardData = await streakDataService.claimRewardService();
    myClaimRewardData;
    if (myClaimRewardData[0] == 200) {
      Fluttertoast.showToast(
        msg: myClaimRewardData[1],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 7,
        backgroundColor: const Color.fromARGB(255, 32, 32, 32),
        textColor: Colors.white,
        fontSize: 15.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'An error occured, try again later',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 7,
        backgroundColor: const Color.fromARGB(255, 32, 32, 32),
        textColor: Colors.white,
        fontSize: 15.0,
      );
    }

    // Perform your asynchronous operation here (e.g., network request)
    await Future.delayed(const Duration(seconds: 2)); // Simulate some work

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getMyStreakData().then((_) {
      getAnimals().then((value) {
        _game = ParrallelFarm(context, value);
        setState(() {
          _loading = false;
        });
      });
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> getMyStreakData() async {
    final mystreakData = await streakDataService.getStreakService();
    final myActiveRewardData = await streakDataService.activeRewardService();
    claimReward.add(myActiveRewardData);
    mystreakDataList.add(mystreakData);
  }

  Future<List<Animal>> getAnimals() async {
    var barnService = BarnService();
    return await barnService.getAnimals();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: _loading
          ? Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/splashbackground.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitCircle(
                      color: Color.fromARGB(
                          255, 24, 248, 16), 
                      size: 150.0, // Size of the spinner
                    ),
                  ],
                ),
              ),
            )
          : mystreakDataList.isNotEmpty
              ? GameWidget(
                  game: _game,
                  overlayBuilderMap: {
                    GameConstants.how: (BuildContext context, FlameGame game) {
                      return Center(
                          child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: GestureDetector(
                          onTap: () {
                            game.overlays.remove(GameConstants.how);
                          },
                          child: Image.asset(
                              'assets/images/howToPlayDialog.png',
                              scale: 0.3),
                        ),
                      ));
                    },
                    GameConstants.streak: (BuildContext context,
                        FlameGame game) {
                      int backendValue =
                          mystreakDataList[0]['numberOfStreakReward'];
                      int activeRewardValue =
                          claimReward[0]['numberOfDayslnStreak'];
                      double backendTobeusedValue = backendValue.toDouble();
                      double minValue = 0.0;
                      double maxValue = activeRewardValue.toDouble();
                      double calculatedValue =
                          (backendTobeusedValue - minValue) /
                              (maxValue - minValue);
                      double progressValue =
                          calculatedValue.clamp(0.0, 1.0);
                      return GestureDetector(
                        onTap: () {
                          game.overlays.remove(GameConstants.streak);
                        },
                        child: AlertDialog(
                          backgroundColor:
                              Colors.white.withOpacity(0.5),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          content: Container(
                            width: 150,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: AnimatedProgressBar(
                              backgroundColor:
                                  Colors.brown.withOpacity(0.5),
                              width: double.infinity,
                              height: 50,
                              value: progressValue,
                              duration: const Duration(seconds: 3),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.lightGreen,
                                  Colors.yellow.shade700,
                                  Colors.lightGreen,
                                  Colors.yellow.shade700,
                                  Colors.lightGreen,
                                  Colors.yellow.shade700,
                                  Colors.lightGreen,
                                ],
                              ),
                            ),
                          ),
                          actions: <Widget>[
                            mystreakDataList[0]['numberOfStreakReward'] == 30
                                ? Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          opacity: 100,
                                          image: AssetImage(
                                              "assets/images/greenbutton.webp")),
                                    ),
                                    child: GestureDetector(
                                      onTap: isLoading
                                          ? null
                                          : _handleButtonPress,
                                      child: Center(
                                          child: isLoading
                                              ? const Center(
                                                  child: SpinKitCircle(
                                                  size: 20,
                                                  color: Color.fromARGB(
                                                      255,
                                                      240,
                                                      243,
                                                      240),
                                                ))
                                              : const Text('CLAIM REWARD',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                    ),
                                  )
                                : Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          opacity: 0.50,
                                          image: AssetImage(
                                              "assets/images/greenbutton.webp")),
                                    ),
                                    child: GestureDetector(
                                      onTap: () async {
                                        Fluttertoast.showToast(
                                          msg: "Reward not available yet.",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.TOP,
                                          timeInSecForIosWeb: 7,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 15.0,
                                        );
                                      },
                                      child: const Center(
                                          child: Text('CLAIM REWARD',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                  ),
                          ],
                        ),
                      );
                    },
                    GameConstants.feed: (BuildContext context,
                        FlameGame game) {
                      return Center(
                          child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: GestureDetector(
                            onTap: () {
                              game.overlays.remove(GameConstants.feed);
                            },
                            child: const Text('')),
                      ));
                    },
                  },
                )
              : Container(
                  
                ),
    );
  }
}
