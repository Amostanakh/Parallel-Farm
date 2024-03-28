
import 'package:flutter/material.dart';
import 'package:parallel_farm/apis/animal_api.dart';
import 'package:intl/intl.dart';
import 'package:parallel_farm/models/animal_model.dart';

class BarnService {
  Future<List<Animal>>getAnimals() async {
    AnimalApi animalApi = AnimalApi();
    var animalresponse = await animalApi.getMyAnimalsApi();

    final List<dynamic> jsonList = animalresponse.data['data'];

    List<Animal> animals =jsonList.map((json) => Animal.fromJson(json)).toList();
    return animals;
  }

  getAnimalsResponses() async {
    AnimalApi animalApi = AnimalApi();
    var animalresponse = await animalApi.getMyAnimalsApi();
    return animalresponse.data['message'].toString();
  }

  String addTwoMonths(String inputDate, int lengthOfContract) {
    DateTime parsedDate = DateTime.parse(inputDate);
    DateTime newDate = DateTime(
        parsedDate.year, parsedDate.month + lengthOfContract, parsedDate.day);
    return DateFormat('MMM-dd').format(newDate.toUtc());
  }

  bool redeemDateCalculation(String inputDate, int numberOfEggs) {
    DateTime parsedDate = DateTime.parse(inputDate);
    DateTime now = DateTime.now();
    DateTime newDate1 =
        DateTime(parsedDate.year, parsedDate.month, parsedDate.day + 30);
    bool isDateValid = now.isAfter(newDate1);
    bool isSameDate = now.isAtSameMomentAs(newDate1);
    bool hasEnoughEggs = numberOfEggs >= 30;
    return (isDateValid || isSameDate) && hasEnoughEggs;
  }

  Color getColor(double value) {
    if (value >= 0.0 && value <= 0.24) {
      return Colors.red;
    } else if (value >= 0.25 && value <= 0.49) {
      return Colors.orange;
    } else if (value >= 0.50 && value <= 0.74) {
      return Colors.yellow;
    } else if (value >= 0.75 && value <= 1.00) {
      return Colors.green;
    } else {
      return Colors.grey; // default color
    }
  }

  double divideByFour(int number) {
    double result = number / 100;
    return result;
  }

  double calculateAmount(int numberOfEggs) {
    double amount = ((numberOfEggs / 30) * 3);
    return amount;
  }
}
