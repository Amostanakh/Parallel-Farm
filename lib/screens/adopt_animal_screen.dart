import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:parallel_farm/screens/barn_screen.dart';
import 'package:parallel_farm/screens/payment_screen.dart';
import 'package:parallel_farm/services/animal_service.dart';

class AdoptAnimal extends StatefulWidget {
  static const String routeName = "adopt-animal";

  final List animalsSelected;

  const AdoptAnimal({
    Key? key,
    required this.animalsSelected,
  }) : super(key: key);

  @override
  State<AdoptAnimal> createState() => _AdoptAnimalState();
}

class _AdoptAnimalState extends State<AdoptAnimal> {
  final AnimalService _animalAdoptService = AnimalService();
  final _walletData = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  void _getMyWalletData() async {
    final walletBalance = await _animalAdoptService.getWalletBalance();
    setState(() {
      bool _loading = true;
    });

    setState(() {
      _walletData.add(walletBalance);
    });
    setState(() {
      bool _loading = false;
    });
  }

  double _calculateGrandTotal() {
    double grandTotal = 0.0;
    for (var animal in widget.animalsSelected) {
      grandTotal += animal['totalCost'];
    }
    return grandTotal;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final noAnimalsSnackBar = SnackBar(
      content: const Text('No animals selected yet'),
      action: SnackBarAction(
        label: 'Cancel',
        onPressed: () {},
      ),
    );

    void _showErrorSnackBar(String errorMessage) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }

    void _handleApiError(dynamic error) {
      String errorMessage = 'Something Went wrong!';

      if (error is DioError) {
        if (error.response != null) {
          errorMessage = error.response?.data['message'];
        } else {
          errorMessage = 'Error sending request: $error';
        }
      }

      _showErrorSnackBar(errorMessage);
    }

    Future<void> _adoptAnimalButton() async {
      setState(() {
        _loading = true;
      });

      if (widget.animalsSelected.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(noAnimalsSnackBar);
      } else {
        try {
          var result = await _animalAdoptService
              .adoptAnimalService(widget.animalsSelected);

          if (result.statusCode == 201) {
            _showTransactionSuccessDialog();
          }
        } catch (error) {
          _handleApiError(error);
        } finally {
          setState(() {
            _loading = false;
          });
        }
      }
    }

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 60, 10, 0),
        height: screenHeight,
        width: screenWidth,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/mainBg.jpg"), fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Center(
                child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(
                'CONFIRM ORDER',
                style: TextStyle(
                  fontSize: 25,
                  color: Color.fromRGBO(92, 31, 0, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SizedBox(
                width: 400,
                height: 500,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: widget.animalsSelected.isEmpty
                      ? const Center(child: Text('No animals selected now'))
                      : Column(
                          children: [
                            _buildAnimalListView(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              color: Colors.white,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('GRAND TOTAL:',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                    '\$${_calculateGrandTotal()?.toStringAsFixed(2)}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: _loading
                        ? const SpinKitCircle(
                            color: Color.fromARGB(255, 24, 248, 16),
                            size: 50.0,
                          )
                        : _buildActionButton('ADOPT', _adoptAnimalButton)),
                Expanded(
                    child: _buildActionButton('GET PWs', _navigateToPwScreen)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Expanded _buildAnimalListView() {
    _getMyWalletData();
    return Expanded(
      child: ListView.builder(
        itemCount: widget.animalsSelected.length,
        itemBuilder: (context, index) {
          final adoptedAnimals = widget.animalsSelected[index];

          return Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildAnimalInfoText(
                          'Batch', '${adoptedAnimals['batchName']}'),
                      _buildAnimalInfoText(
                          'Quantity', '${adoptedAnimals['numberOfAnimals']}'),
                      _buildAnimalInfoText(
                          'Unit', '\$${adoptedAnimals['price']}'),
                      _buildAnimalInfoText(
                          'Total', '\$${adoptedAnimals['totalCost']}'),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnimalInfoText(String label, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
              color: Colors.black87,
              fontSize: 15,
              fontWeight: FontWeight.normal),
        ),
        Text(
          value,
          style: const TextStyle(
              color: Colors.black87, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildActionButton(String text, Function() onPressed) {
    final buttonText = Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );

    return Container(
      height: 50,
      width: 200,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage("assets/images/green_button.png"),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: buttonText,
        ),
      ),
    );
  }

  void _showInsufficientBalanceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Transaction Failed'),
        content: const Text('Insufficient balance. Top up your wallet.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Top Up'),
          ),
        ],
      ),
    );
  }

  void _showTransactionSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Transaction Succeeded',
            style: TextStyle(fontSize: 20.0)),
        content: const Text('Adoption was successful'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BarnPage(),
                ),
              );
            },
            child: const Text('My Barn'),
          ),
        ],
      ),
    );
  }

  void _navigateToPwScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PwScreen(),
      ),
    );
  }
}
