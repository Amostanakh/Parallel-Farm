import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parallel_farm/components/auth_loading.dart';

import '../services/barn_service.dart';
import '../services/feed_service.dart';


class FeedLoading extends StatefulWidget {
  const FeedLoading({super.key});


  @override
  State<FeedLoading> createState() => _FeedLoadingState();
}

class _FeedLoadingState extends State<FeedLoading> {

  BarnService getMyAnimals = BarnService();
  FeedService feedAllMyAdoptedAnimals = FeedService();
  _feed()async{
    try{
      var animalRequestResponse = await getMyAnimals.getAnimals();
      if (animalRequestResponse.toString() != "[]") {
        var feedResponse =
        await feedAllMyAdoptedAnimals.feedAllAnimals();
        if (feedResponse[0] != 403) {
          Fluttertoast.showToast(
            msg: "Feeding success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 7,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 15.0,
          );
          setState(() {
            loading=false;
          });
          Navigator.pop(context);

        } else {
          Fluttertoast.showToast(
            msg: feedResponse[1],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 7,
            backgroundColor: const Color.fromARGB(255, 32, 32, 32),
            textColor: Colors.white,
            fontSize: 15.0,
          );
          Navigator.pop(context);
          setState(() {
            loading=false;
          });

        }
      }
      else {
        Navigator.pop(context);
        Fluttertoast.showToast(
          msg: "You have no animals to Feed, Adopt 1  ;)",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 7,
          backgroundColor: const Color.fromARGB(255, 32, 32, 32),
          textColor: Colors.white,
          fontSize: 15.0,
        );
        setState(() {
          loading=false;
        });
      }
  }catch(e){
      Navigator.pop(context);
      setState(() {
        loading=false;
      });

    }

  }

  @override
  void initState() {
  _feed();
    super.initState();
  }

  bool loading= true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DecoratedBox(
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/images/mainBg.jpg"),
    fit: BoxFit.cover),
    ),
        child:
        loading?const AuthLoading(message: "We are feeding your chicken, hold on!")
            :Container(),),
    );
  }
}
