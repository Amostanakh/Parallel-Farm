import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:parallel_farm/components/auth_loading.dart';
import 'package:parallel_farm/services/payment_service.dart';

class PwScreen extends StatefulWidget {
  static const String routeName = "pw-screen";
  const PwScreen({super.key});

  @override
  State<PwScreen> createState() => _PwScreenState();
}

class _PwScreenState extends State<PwScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  final PaymentService _paymentService = PaymentService();
  final TextEditingController controller2 = TextEditingController();

  Map<String, dynamic>? paymentIntent;

  Future<void> stripeMakePayment(BuildContext context) async {
    if (_amountController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter an amount first.");
      return;
    }

    try {
      paymentIntent = await createPaymentIntent(_amountController.text, 'USD');

      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  billingDetails: const BillingDetails(
                    name: 'YOUR NAME',
                    email: 'YOUREMAIL@gmail.com',
                    phone: 'YOUR NUMBER',
                  ),
                  style: ThemeMode.dark,
                  paymentIntentClientSecret: paymentIntent![
                      'client_secret'], //Gotten from payment intent
                  merchantDisplayName: 'Ikay'))
          .then((value) => {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      // 3. display the payment sheet.
      await Stripe.instance.presentPaymentSheet();

      var result = await _paymentService.createPaymentIntent(
          amountPaid: _amountController.text,
          pwEquivalent: controller2.text,
          intentAvaliable: paymentIntent?['id']);
      print(result);
      _getBalanceFromApi();

      Fluttertoast.showToast(msg: result['message']);
      setState(() {
        _amountController.clear();
        controller2.clear();
      });
    } on Exception catch (e) {
      if (e is StripeException) {
        Fluttertoast.showToast(
            msg: 'Error from Stripe: ${e.error.localizedMessage}');
      } else {
        Fluttertoast.showToast(msg: 'Unforeseen error: $e');
      }
    }
  }

//create Payment
  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      var decoded = json.decode(response.body);

      return decoded;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }

  String? codeDialog;
  String? valueText;
  double? _balance = 0.0;
  @override
  void initState() {
    super.initState();
    _getBalanceFromApi();

    _amountController.addListener(() {
      setState(() {
        double amount = double.tryParse(_amountController.text) ?? 0;
        double multipliedAmount = amount;
        _pwController.text = "$multipliedAmount PWs";
      });
    });
  }

  void _getBalanceFromApi() async {
    // Replace with your actual API call and error handling
    try {
      final response = await _paymentService.getMyWalletBalance();
      final amount = response['data']['amount'];
      setState(() {
        _balance = double.parse(amount);
      });
    } catch (error) {
      print(error); // Handle API errors gracefully
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back),
      onPressed:()=>Navigator.of(context).pop(false) ,),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/mainBg.jpg"),
                  fit: BoxFit.cover),
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                // Padding(
                //   padding: const EdgeInsets.only(right: 350),
                //   child: GestureDetector(
                //     onTap: () {
                //       Navigator.of(context).pop(false);
                //     },
                //     child: const Icon(
                //       color: Color.fromARGB(255, 85, 70, 70),
                //       Icons.arrow_back,
                //       size: 40,
                //       weight: 900,
                //     ),
                //   ),
                // ),
                const Text(
                  'Buy Pws',
                  style: TextStyle(
                      color: Color.fromARGB(232, 131, 32, 1),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Text('Current Balance:\$${_balance?.toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 229, 167, 126),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold)),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _amountController,
                        decoration: InputDecoration(
                          labelText: "Amount",
                          labelStyle: const TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value != null && double.tryParse(value) != null) {
                            if (double.parse(value) > 0) {
                              return null; // Valid input
                            } else {
                              return "Please enter a positive number.";
                            }
                          } else {
                            return "Please enter a valid number.";
                          }
                        },
                        onChanged: (value) {
                          // Update USD equivalent on change
                          if (double.tryParse(value) != null) {
                            final double parsedValue = double.parse(value);
                            final double usdEquivalent =
                                parsedValue * 10; // Set your conversion rate here
                            controller2.text = usdEquivalent
                                .toStringAsFixed(2); // Format to 2 decimal places
                          } else {
                            controller2.text =
                                ""; // Clear USD equivalent when input is invalid
                          }
                        },
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "PWA Equivalent",
                          labelStyle: const TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          enabled: false, // Make the field uneditable
                        ),
                        controller: controller2,
                      ),
                      const SizedBox(height: 20.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Choose payment method:',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    // Handle Visa selection (e.g., display selection confirmation)
                                    stripeMakePayment(context);
                                  },
                                  child: Container(
                                    height: 80,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2, color: Colors.greenAccent),
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color.fromARGB(
                                                    255, 209, 234, 207)
                                                .withOpacity(
                                                    0.5), // Adjust shadow color and opacity
                                            offset: const Offset(
                                                0, 2), // Set shadow offset (x, y)
                                            blurRadius: 4.0, // Adjust blur radius
                                          )
                                        ]
                                        //<-- SEE HERE
                                        ),
                                    child: Image.asset(
                                      "assets/images/visa.png", // Replace with your Mastercard icon image
                                      height: 50.0,
                                      width: 100.0,
                                    ),
                                  )),
                              const SizedBox(
                                  width: 90.0), // Add spacing between icons
                              GestureDetector(
                                  onTap: () {
                                    // Handle Mastercard selection (e.g., display selection confirmation)
                                    stripeMakePayment(context);
                                  },
                                  child: Container(
                                    height: 80,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2, color: Colors.greenAccent),
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color.fromARGB(
                                                    255, 209, 234, 207)
                                                .withOpacity(
                                                    0.5), // Adjust shadow color and opacity
                                            offset: const Offset(
                                                0, 2), // Set shadow offset (x, y)
                                            blurRadius: 4.0, // Adjust blur radius
                                          )
                                        ]),
                                    child: Image.asset(
                                      "assets/images/mastercard.png", // Replace with your Mastercard icon image
                                      height: 50.0,
                                      width: 100.0,
                                    ),
                                  )),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
