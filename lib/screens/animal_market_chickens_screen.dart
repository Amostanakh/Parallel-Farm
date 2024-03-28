import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parallel_farm/constants/constants.dart';
import 'package:parallel_farm/models/animal_market_model.dart';
import 'package:parallel_farm/screens/adopt_animal_screen.dart';
import 'package:parallel_farm/services/animal_service.dart';

class AnimalDetails extends StatefulWidget {
  static const String routeName = "animal-details";

  const AnimalDetails({super.key});

  @override
  State<AnimalDetails> createState() => _AnimalDetailsState();
}

class _AnimalDetailsState extends State<AnimalDetails> {
  final AnimalService _animalService = AnimalService();

  late List<Map<String, dynamic>> _availableAnimals = [];
  late List<int> _numberOfAnimals;
  late List<bool> _isDone;
  late bool isLoading = false;
  late List<num> _returnOnInvestment;

  final List<AnimalMarketModel> animalDetailsData = [
    AnimalMarketModel(
        name: 'Eggs',
        image: 'assets/images/egg.png',
        contractLength: 8,
        age: 0),
    AnimalMarketModel(
        name: '1 MONTH OLD',
        image: 'assets/images/onemonth.jpg',
        contractLength: 6,
        age: 1),
    AnimalMarketModel(
        name: '2 MONTHS OLD',
        image: 'assets/images/chick.png',
        contractLength: 5,
        age: 2),
    AnimalMarketModel(
        name: '3 MONTHS OLD',
        image: 'assets/images/3months.jpeg',
        contractLength: 4,
        age: 3),
    AnimalMarketModel(
        name: '4 MONTHS OLD',
        image: 'assets/images/chicken.png',
        contractLength: 3,
        age: 4),
  ];

  @override
  void initState() {
    _numberOfAnimals = List.filled(5, 0);
    _isDone = List.filled(5, true);
    _returnOnInvestment = List.filled(5, 0);
    _getAvailableAnimals();
    super.initState();
  }

  void _getAvailableAnimals() async {
    setState(() {
      isLoading = true;
    });

    final res = await _animalService.getBatches();

    setState(() {
      _availableAnimals = res ?? [];
      isLoading = false;
    });
  }

  @override
  void dispose() {
    // Dispose controllers or other resources if needed
    super.dispose();
  }

  Widget buildIconContainer(IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 30,
      ),
    );
  }

  Widget buildAnimalsNumberTextField(int index) {
    return SizedBox(
      width: 150,
      child: _isDone[index]
          ? GestureDetector(
              onTap: () {
                setState(() {
                  _isDone[index] = false;
                });
              },
              child: Text(_numberOfAnimals[index].toString()),
            )
          : TextFormField(
              initialValue: _numberOfAnimals[index].toString(),
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly,
              ],
              autofocus: false,
              onChanged: (value) {
                setState(() {
                  _numberOfAnimals[index] = int.parse(value);
                  _returnOnInvestment[index] = (12 * _numberOfAnimals[index]) -
                      ((animalDetailsData[index].contractLength *
                              0.8 *
                              _numberOfAnimals[index]) +
                          (_availableAnimals[index]['price'] *
                              _numberOfAnimals[index]));
                });
              },
              onEditingComplete: () {
                setState(() {
                  _isDone[index] = true;
                });
              },
              onTapOutside: (event) {
                setState(() {
                  _isDone[index] = true;
                });
              },
              style: const TextStyle(fontSize: 15.0, color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: const EdgeInsets.only(
                  left: 14.0,
                  bottom: 6.0,
                  top: 8.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(0.0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
            ),
    );
  }

  Widget itemColumn(String name, dynamic value) {
    Widget buildContainer(String text) {
      return Container(
        height: 38,
        width: 60,
        decoration: BoxDecoration(
          color: greenColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        buildContainer(name),
        const SizedBox(height: 2),
        buildContainer('$value'),
      ],
    );
  }

  Widget buildAnimalContainer(int index) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 80,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              AssetImage(animalDetailsData[index].image),
                        ),
                      ),
                      Text(
                        animalDetailsData[index].name.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${isLoading ? 'Loading...' : _availableAnimals[index]['remainingAnimals']} Left',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  itemColumn(
                      'COST',
                      isLoading
                          ? 'Loading...'
                          : _availableAnimals[index]['price']),
                  itemColumn('CYCLE',
                      '${animalDetailsData[index].contractLength} MNS'),
                  itemColumn('FEED',
                      (animalDetailsData[index].age * 0.8).toStringAsFixed(2)),
                  itemColumn(
                      'PROFIT', _returnOnInvestment[index].toStringAsFixed(2)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_numberOfAnimals[index] > 0) {
                          _numberOfAnimals[index]--;

                          _returnOnInvestment[index] =
                              (12 * _numberOfAnimals[index]) -
                                  ((animalDetailsData[index].contractLength *
                                          0.8 *
                                          _numberOfAnimals[index]) +
                                      (_availableAnimals[index]['price'] *
                                          _numberOfAnimals[index]));
                        }
                      });
                    },
                    child: buildIconContainer(Icons.remove, redColor),
                  ),
                  const SizedBox(width: 20),
                  buildAnimalsNumberTextField(index),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _numberOfAnimals[index]++;
                        _returnOnInvestment[index] =
                            (12 * _numberOfAnimals[index]) -
                                ((animalDetailsData[index].contractLength *
                                        0.8 *
                                        _numberOfAnimals[index]) +
                                    (_availableAnimals[index]['price'] *
                                        _numberOfAnimals[index]));
                      });
                    },
                    child: buildIconContainer(Icons.add, greenColor),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/mainBg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        height: screenHeight,
        width: screenWidth,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // New Code
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(2, 30, 8, 5),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.brown,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0.0, 40, 20, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'ADOPTION CENTER',
                              style: TextStyle(
                                color: Color.fromRGBO(92, 31, 0, 1),
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(0),
                              child: const Text(
                                'CHICKENS',
                                style: TextStyle(
                                  color: Color.fromRGBO(92, 31, 0, 1),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),

              // Old code
              // Container(
              //   padding: const EdgeInsets.only(top: 40),
              //   child: Column(
              //     children: [
              //       const Text(
              //         'ADOPTION CENTER',
              //         style: TextStyle(
              //           color: Color.fromRGBO(92, 31, 0, 1),
              //           fontSize: 25,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //       Container(
              //         padding: const EdgeInsets.all(0),
              //         child: const Text(
              //           'CHICKENS',
              //           style: TextStyle(
              //             color: Color.fromRGBO(92, 31, 0, 1),
              //             fontSize: 20,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              SizedBox(
                height: screenHeight * 0.78,
                width: screenWidth,
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  // itemCount: _availableAnimals.length,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return buildAnimalContainer(index);
                  },
                ),
              ),
              Container(
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage("assets/images/green_button.png"),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GestureDetector(
                  onTap: () {
                    var animalsChosen = [];
                    num allAdoptedTotalCost = 0;

                    for (int i = 0; i < _availableAnimals.length; i++) {
                      final animal = _availableAnimals[i];

                      allAdoptedTotalCost +=
                          _numberOfAnimals[i] * animal['price'];

                      if (_numberOfAnimals[i] > 0) {
                        animalsChosen.add({
                          "batchId": animal['_id'],
                          "batchName": animal['batchName'],
                          "age": animal['age'],
                          "price": animal['price'],
                          "numberOfAnimals": _numberOfAnimals[i],
                          "picId": "pictughdhggdhs",
                          "batchNumber": animal['batchNumber'],
                          "contractLength":
                              animalDetailsData[animal['age']].contractLength,
                          "animalLife": 43,
                          'totalCost': _numberOfAnimals[i] * animal['price'],
                          "allAdoptedTotalCost": allAdoptedTotalCost,
                          "dateLastFed": "2024-01-26T09:02:50.568Z",
                          "isContractActive": true,
                        });
                      }
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdoptAnimal(
                          animalsSelected: animalsChosen,
                        ),
                      ),
                    );
                  },
                  child: const Center(
                    child: Text(
                      'PROCEED',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
