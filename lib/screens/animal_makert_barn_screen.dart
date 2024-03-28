// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:parallel_farm/screens/animal_market_chickens_screen.dart';
import 'package:parallel_farm/screens/barn_screen.dart';

class AnimalMarketBarnScreen extends StatefulWidget {
  static const String routeName = "animal_market_barn_screen";
  const AnimalMarketBarnScreen({super.key});

  @override
  State<AnimalMarketBarnScreen> createState() => _AnimalMarketBarnScreenState();
}

class _AnimalMarketBarnScreenState extends State<AnimalMarketBarnScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<Map> animalData = [
    {'id': 123, 'animalType': 'CHICKEN', 'state': ''},
    {'id': 123, 'animalType': 'COW', 'state': 'COMING SOON'},
    {'id': 123, 'animalType': 'SHEEP', 'state': 'COMING SOON'},
  ];

  final snackBar = SnackBar(
    content: const Text('This animal is coming soon'),
    action: SnackBarAction(
      label: 'cancel',
      onPressed: () {},
    ),
  );
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DecoratedBox(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/barn_background.jpg"),
                    fit: BoxFit.cover),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 250),
                itemCount: animalData.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if ('${animalData[index]['state']}' == '') {
                        Navigator.pushNamed(context, BarnPage.routeName,
                            arguments: (route) => false);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Container(
                      decoration: '${animalData[index]['state']}' == ''
                          ? BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/button_background.png')),
                              borderRadius: BorderRadius.circular(10))
                          : BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/dull_button.png')),
                              borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                      child: SizedBox(
                        height: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              '${animalData[index]['state']}' == ''
                                  ? Text(
                                      '${animalData[index]['animalType']}',
                                      style: const TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                  : Text(
                                      '${animalData[index]['animalType']}',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.grey.shade400,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                              '${animalData[index]['state']}' == ''
                                  ? Text(
                                      '${animalData[index]['state']}',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    )
                                  : Text(
                                      '${animalData[index]['state']}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )),
          Positioned(
              left: 20,
              top: 70,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(false);
                },
                child: const Icon(
                  color: Color.fromARGB(255, 112, 30, 1),
                  Icons.arrow_back,
                  size: 40,
                ),
              )),
          Container(
            padding: const EdgeInsets.fromLTRB(40, 100, 40, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'MY ANIMALS',
                  style: TextStyle(
                      color: Color.fromARGB(255, 112, 30, 1),
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                Center(
                  child: Container(
                    // padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                    alignment: Alignment.center, // Center the text horizontally
                    child: const Text(
                      'SEE ALL YOUR ANIMALS',
                      style: TextStyle(
                        color: Color.fromARGB(255, 112, 30, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
