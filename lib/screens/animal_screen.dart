// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:parallel_farm/screens/animal_market_chickens_screen.dart';
import 'package:parallel_farm/utils/utils.dart';

class AnimalMakert extends StatefulWidget {
  static const String routeName = "animal-market";
  const AnimalMakert({super.key});

  @override
  State<AnimalMakert> createState() => _AnimalMakertState();
}

class _AnimalMakertState extends State<AnimalMakert>
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
      body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/animal_market_back.jpg"),
                fit: BoxFit.cover),
          ),
        child:
          Container(
          padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             Container(
               child: GestureDetector(
                 onTap: () {
                   Navigator.of(context).pop(false);
                 },
                 child: const Icon(

                   color: Colors.white,
                   Icons.arrow_back,

                 ),
               ),
               alignment: Alignment.topLeft,
               padding: EdgeInsets.only(bottom: 20),
               width: screenWidth(context),
             ), 
              const Text(
                'ANIMAL MARKET',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color:  Color.fromARGB(255, 112, 30, 1),
                    fontSize: 35,

                    fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: const Text(
                  'Welcome to the market. Adopt an animal today',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color:  Color.fromARGB(255, 112, 30, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 40),
                itemCount: animalData.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if ('${animalData[index]['state']}' == '') {
                        Navigator.pushNamed(context, AnimalDetails.routeName,
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
                                  'assets/images/button_background.png'),
                              fit: BoxFit.fitWidth),
                          borderRadius: BorderRadius.circular(10))
                          : BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage(
                                  'assets/images/dull_button.png',
                              ),
                          fit: BoxFit.fitWidth),
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: SizedBox(
                        height: 120,

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            '${animalData[index]['state']}' == ''
                                ? Text(
                              '${animalData[index]['animalType']}',
                              style: const TextStyle(
                                fontSize: 25,
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
                  );
                },
              ),


            ],
          ),
        ),




      )
    );
  }
}
