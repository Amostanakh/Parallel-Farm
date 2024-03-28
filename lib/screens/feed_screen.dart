import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedsScreen extends StatefulWidget {
  static const String routeName = "feed-screen";
  @override
  _FeedsScreenState createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final _animalIdController = TextEditingController();
  final _amountController = TextEditingController();
  final _priceController = TextEditingController();
  final _walletIdController = TextEditingController();
  final _userIdController = TextEditingController();
  final _transactionIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 150, 10, 0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            TextField(
              autofocus: false,
              style: const TextStyle(fontSize: 15.0, color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Kgs',
                hintStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                filled: true,
                fillColor: Colors.grey,
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
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
            SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/button_background.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: TextButton(
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Text(
                    'BUY FEED',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPostFeedPressed() {
    // if (_formKey.currentState!.validate()) {
    //   String id = 'your-feed-id';
    //   context.read<FeedBloc>().add(
    //         PostFeed(
    //           id, // replace 'my-feed-id' with your actual feed id
    //           Feed(
    //             animalId: _animalIdController.text,
    //             amount: int.parse(_amountController.text),
    //             price: int.parse(_priceController.text),
    //             walletId: _walletIdController.text,
    //             userId: _userIdController.text,
    //             transactionId: _transactionIdController.text,
    //           ),
    //         ),
    //       );
    // }
  }

  @override
  void dispose() {
    _animalIdController.dispose();
    _amountController.dispose();
    _priceController.dispose();
    _walletIdController.dispose();
    _userIdController.dispose();
    _transactionIdController.dispose();
    super.dispose();
  }
}
