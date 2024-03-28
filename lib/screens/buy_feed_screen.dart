import 'package:flutter/material.dart';
import 'package:parallel_farm/components/auth_loading.dart';
import 'package:parallel_farm/screens/barn_screen.dart';
import 'package:parallel_farm/screens/payment_screen.dart';
import 'package:parallel_farm/services/feed_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parallel_farm/utils/utils.dart';

class BuyFeed extends StatefulWidget {
  static const String routeName = "buy_feed";
  const BuyFeed({Key? key}) : super(key: key);

  @override
  State<BuyFeed> createState() => _BuyFeedState();
}

class _BuyFeedState extends State<BuyFeed> {
  final TextEditingController _amountController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/barn_background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(2, 30, 300, 5),
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
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 80, 0, 5),
                child: Text(
                  'Buy Feed',
                  style: TextStyle(
                    fontSize: 35,
                    color: Color.fromARGB(255, 131, 61, 4),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? Container(
                      height: screenHeight*0.42,
                      width: screenWidth,
                      alignment: Alignment.center,
                      child: const AuthLoading(message: "Buying your feed"),
                    )
                  : Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Please insert number of Kgs',
                              style: TextStyle(
                                color: Color.fromARGB(255, 131, 55, 4),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _amountController,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 131, 55, 4)),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                fillColor: Colors.grey[200],
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              _isLoading ? Container() :
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        _sendDataToServer();
                        setState(() {
                          _isLoading = true;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage("assets/images/greenbutton.webp"),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Text('BUY'),
                      ),
                    ),
                    const SizedBox(width: 72),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, PwScreen.routeName,
                            arguments: (route) => false);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage("assets/images/greenbutton.webp"),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Text('GET PWs'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendDataToServer() async {
    String amount = _amountController.text;
    if (amount.isNotEmpty) {
       setState(() {
        _isLoading = false;
      });
      FeedService _feedService = FeedService();
      var postResponse = await _feedService.sendDataToServer(int.parse(amount));
      if (postResponse != "Insufficient funds") {
        Fluttertoast.showToast(
          msg: postResponse,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        await Future.delayed(const Duration(seconds: 2));
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BarnPage()),
        );
      } else {
        Fluttertoast.showToast(
          msg: postResponse,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        await Future.delayed(const Duration(seconds: 2));
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PwScreen()),
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Amount cannot be empty!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 20.0,
      );
    }
  }
}
