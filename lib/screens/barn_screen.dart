import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parallel_farm/constants/constants.dart';
import 'package:parallel_farm/models/animal_model.dart';
import 'package:parallel_farm/models/eggs_data.dart';
import 'package:parallel_farm/models/eggs_data_provider.dart';
import 'package:parallel_farm/screens/animal_market_chickens_screen.dart';
import 'package:parallel_farm/screens/buy_feed_screen.dart';
import 'package:parallel_farm/screens/redeem_eggs_screen.dart';
import 'package:parallel_farm/services/barn_service.dart';
import 'package:parallel_farm/services/feed_service.dart';
import 'package:provider/provider.dart';

class BarnPage extends StatefulWidget {
  static const String routeName = "barn-page";

  const BarnPage({super.key});

  @override
  State<BarnPage> createState() => _AnimalDetailsState();
}

int counter = 0;

class _AnimalDetailsState extends State<BarnPage> {
  final BarnService _barnService = BarnService();
  final FeedService _feedService = FeedService();
  List<Animal> myAnimals = [];
  int _animalCount = 0;
  bool isLoading = true;
  var _selectedAnimalId;
  bool _isButtonLoading = false;
  var feedAmount = "0";
  var feedMyAnimals;
  String loadingText = "Please wait";

  initializeFeedAmount() async {}

  @override
  void initState() {
    super.initState();
    startLoadingAnimation();
    loadAnimals();
  }

  void startLoadingAnimation() {
    Timer.periodic(const Duration(milliseconds: 400), (timer) {
      setState(() {
        loadingText += ".";
        if (loadingText.length > 14) {
          loadingText = "Please wait";
        }
      });
    });
  }

  loadAnimals() async {
    int count = 0;
    feedAmount = await _feedService.getFeedAmount();
    List<Animal> animals = await _barnService.getAnimals();
    for (var i = 0; i < animals.length; i++) {
      count += animals[i].numberOfAnimals;
    }

    setState(() {
      myAnimals = animals;
      _animalCount = count;
      if (_animalCount == 0) {
        Fluttertoast.showToast(
          msg: "You have no animals in your barn",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 20.0,
        );

        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AnimalDetails()),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/barn_background.jpg"),
                fit: BoxFit.cover)),
        height: screenHeight,
        width: screenWidth,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 20, 300,0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.brown,
                            size: 40,
                          ),
                        ),
                      ),
                      const Text(
                        'BARN',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 131, 61, 4),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: const FractionalOffset(0.1, 0.5),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          'CHICKENS: $_animalCount',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Align(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          'FEED: $feedAmount kgs',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                myAnimals.isEmpty
                    ? SizedBox(
                        height: screenHeight * 0.72,
                        width: screenWidth,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Getting animals in your barn",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                      height:
                                          10), // Add some spacing between the lines
                                  Text(loadingText),
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   height: 10, // Adjust the height as needed
                            //   child: Center(
                            //     child: AuthLoading(
                            //       message: '',
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      )
                    : SizedBox(
                        height: screenHeight * 0.72,
                        width: screenWidth,
                        child: ListView.builder(
                            itemCount: myAnimals.length,
                            itemBuilder: (context, index) {
                              final getMyAnimal = myAnimals[index];
                              final age = getMyAnimal.age;
                              var animalImage = '';
                              if (age <= 0) {
                                animalImage = 'assets/images/egg.png';
                              } else if (age >= 1 && age <= 2) {
                                animalImage = 'assets/images/chick.png';
                              } else if (age >= 3) {
                                animalImage = 'assets/images/chicken.png';
                              }
                              return Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12)),
                                margin: const EdgeInsets.all(10),
                                child: SizedBox(
                                  height: 170,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CircleAvatar(
                                                radius: 40,
                                                backgroundImage:
                                                    AssetImage(animalImage)),
                                            Text(
                                              '${getMyAnimal.age}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Container(
                                                      height: 40,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                        color: greenColor,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                3),
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          'QUANTITY',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 11,
                                                            color: Colors.white,
                                                            // fontWeight:
                                                            //     FontWeight.bold
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 2),
                                                    Container(
                                                      height: 40,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                        color: greenColor,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                3),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          '${getMyAnimal.numberOfAnimals}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: const TextStyle(
                                                              fontSize: 11,
                                                              color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Container(
                                                      height: 40,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                        color: greenColor,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                3),
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          'EXPIRY',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 11,
                                                            color: Colors.white,
                                                            // fontWeight:
                                                            //     FontWeight.bold
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 2),
                                                    Container(
                                                      height: 40,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                        color: greenColor,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                3),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          _barnService.addTwoMonths(
                                                              getMyAnimal
                                                                  .createdAt,
                                                              getMyAnimal
                                                                  .contractLength),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: const TextStyle(
                                                              fontSize: 11,
                                                              color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            SizedBox(
                                                width: 100,
                                                height: 15,
                                                child: LinearProgressIndicator(
                                                  value:
                                                      _barnService.divideByFour(
                                                          getMyAnimal.animalLife),
                                                  backgroundColor: Colors.grey,
                                                  valueColor: AlwaysStoppedAnimation<
                                                          Color>(
                                                      _barnService.getColor(
                                                          _barnService.divideByFour(
                                                              getMyAnimal
                                                                  .animalLife))),
                                                ))
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _sendAnimalId(getMyAnimal.id);
                                            setState(() {
                                              _selectedAnimalId = getMyAnimal.id;
                                              _isButtonLoading = true;
                                            });
                                          },
                                          child: Container(
                                            height: 50,
                                          width: 60,
                                            decoration: BoxDecoration(
                                              color: redColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: _isButtonLoading &&
                                                      getMyAnimal.id ==
                                                          _selectedAnimalId
                                                  ? const SpinKitCircle(
                                                      color: Color.fromARGB(
                                                          255, 242, 250, 241),
                                                    )
                                                  : const Text(
                                                      'Feed',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                        ),
                                        _barnService.redeemDateCalculation(
                                                getMyAnimal.lastRedemptionDate,
                                                getMyAnimal.numberOfEggs)
                                            ? GestureDetector(
                                                onTap: () {
                                                  var payload = RedeemedEggsData(
                                                    userId: getMyAnimal.userId,
                                                    animalId: getMyAnimal.id,
                                                    numberOfEggs:
                                                        getMyAnimal.numberOfEggs,
                                                    amount: _barnService
                                                        .calculateAmount(
                                                            getMyAnimal
                                                                .numberOfEggs),
                                                  );
                                                  Provider.of<RedeemedEggsProvider>(
                                                          context,
                                                          listen: false)
                                                      .setData(payload);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          RedemedEggsPage(
                                                              data: payload),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                    color: greenColor,
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                  ),
                                                  child: const Center(
                                                      child: Text('Redeem',
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                ),
                                              )
                                            : Container(
                                                height: 50,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: const Center(
                                                    child: Text('Redeem',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.white,
                                                            fontWeight: FontWeight
                                                                .bold))),
                                              )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })),
                myAnimals.isEmpty
                    ? Container()
                    : Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/images/greenbutton.webp")),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BuyFeed()),
                            );
                          },
                          child: const Center(
                              child: Text('BUY FEEDS',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> getFeedAmountAndSetState() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      String feedAmount = await _feedService.getFeedAmount();
      setState(() {
        _isButtonLoading = false;
        this.feedAmount = feedAmount;
      });
      return feedAmount;
    } catch (error) {
      return "0";
    }
  }

  void _sendAnimalId(String animalId) async {
    FeedService feedService = FeedService();
    var postResponse = await feedService.feedAnimalGroup(animalId);
    if (postResponse == 201) {
      getFeedAmountAndSetState();
      Fluttertoast.showToast(
        msg: "Thank you for feeding us",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      setState(() {
        _isButtonLoading = false;
      });
      Fluttertoast.showToast(
        msg: "You didn't get enough feed for us",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
