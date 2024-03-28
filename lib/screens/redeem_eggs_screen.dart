import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parallel_farm/constants/constants.dart';
import 'package:parallel_farm/models/eggs_data.dart';
import 'package:parallel_farm/models/eggs_data_provider.dart';
import 'package:parallel_farm/services/redeem_service.dart';
import 'package:provider/provider.dart';

class RedemedEggsPage extends StatefulWidget {
  static const String routeName = "redeem-screen";
  final RedeemedEggsData? data;

  const RedemedEggsPage({super.key, required this.data});

  @override
  State<RedemedEggsPage> createState() => _RedemedEggsPageState();
}

class _RedemedEggsPageState extends State<RedemedEggsPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String _paymentService = '';
  String _selectedService = '';
  final RedeemService _redeemService = RedeemService();
  bool isExpanded = false;
  bool isMapVisible = false;
  late AnimationController _controller;
  final Set<Marker> _markers = {};
  late GoogleMapController _mapController;
  LatLng? selectedLocation;

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
    final data = Provider.of<RedeemedEggsProvider>(context).data;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/barn_background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
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
            Container(
              padding: const EdgeInsets.fromLTRB(50, 0, 10, 0),
              child: const Column(
                children: [
                  Text(
                    'REDEEM',
                    style: TextStyle(
                      color: Color.fromARGB(255, 131, 61, 4),
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
                height: screenHeight * 0.7,
                width: screenWidth,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            if (!isMapVisible)
                              Container(
                                decoration: BoxDecoration(
                                  color: greenColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                margin:
                                    const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          'SEND TO YOUR ACCOUNT',
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          '\$ ${data?.amount}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 28,
                                            color: Colors.white,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isExpanded = !isExpanded;
                                            });
                                          },
                                          child: Icon(
                                            isExpanded
                                                ? Icons
                                                    .keyboard_arrow_up_outlined
                                                : Icons
                                                    .keyboard_arrow_down_outlined,
                                            color: Colors.white,
                                            size: 50,
                                          ),
                                        ),
                                        AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 45),
                                          height: isExpanded ? 150 : 0,
                                          child: isExpanded
                                              ? Column(
                                                  children: [
                                                    Expanded(
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: TextField(
                                                                controller:
                                                                    _phoneNumberController,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .phone,
                                                                decoration:
                                                                    const InputDecoration(
                                                                  hintText:
                                                                      'Enter Phone with +263',
                                                                  filled: true,
                                                                  fillColor: Colors
                                                                      .white, // Set the background color to white
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height:
                                                                    2), // Add some space between the TextField and the next widget
                                                            const Text(
                                                              'Select a service',
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height:
                                                                    2), // Add some space between the text and the images
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      _selectedService =
                                                                          'Ecocash';
                                                                      _paymentService =
                                                                          _selectedService;
                                                                    });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: _selectedService ==
                                                                                'Ecocash'
                                                                            ? Colors.red
                                                                            : Colors.transparent,
                                                                        width:
                                                                            2.0,
                                                                      ),
                                                                    ),
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images/ecocash.png',
                                                                      width: 50,
                                                                      height:
                                                                          50,
                                                                    ),
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      _selectedService =
                                                                          'Innbucks';
                                                                      _paymentService =
                                                                          _selectedService;
                                                                    });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: _selectedService ==
                                                                                'Innbucks'
                                                                            ? Colors.red
                                                                            : Colors.transparent,
                                                                        width:
                                                                            2.0,
                                                                      ),
                                                                    ),
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images/innbucks.png',
                                                                      width: 50,
                                                                      height:
                                                                          50,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : const SizedBox.shrink(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(
                                height:
                                    20), // Add spacing between the two Containers
                            if (isExpanded)
                              Container(
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage(
                                        'assets/images/greenbutton.webp'),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                margin:
                                    const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                padding: const EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: () {
                                    sendToServer(
                                        data!.animalId,
                                        data.amount,
                                        "Money",
                                        _paymentService,
                                        _phoneNumberController.text.toString());
                                  },
                                  child: const Text(
                                    'REDEEM',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            if (!isExpanded)
                              Column(
                                children: [
                                  Container(
                                    width: 400,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    margin: const EdgeInsets.fromLTRB(
                                        40, 10, 40, 10),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 1,
                                          ),
                                          const Text(
                                            '     REDEEM AS EGGS     ',
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isMapVisible = !isMapVisible;
                                              });
                                            },
                                            child: Icon(
                                              isMapVisible
                                                  ? Icons
                                                      .keyboard_arrow_up_outlined
                                                  : Icons
                                                      .keyboard_arrow_down_outlined,
                                              color: Colors.black,
                                              size: 50,
                                            ),
                                          ),
                                          AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 45),
                                            height: isMapVisible ? 310 : 0,
                                            child: isMapVisible
                                                ? SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: TextField(
                                                            controller:
                                                                _addressController,
                                                            decoration:
                                                                const InputDecoration(
                                                              hintText:
                                                                  'Enter Shipping Address',
                                                              filled: true,
                                                              fillColor: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      226,
                                                                      218,
                                                                      218),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            height: 200,
                                                            color: Colors.white,
                                                            child: Stack(
                                                              children: [
                                                                GoogleMap(
                                                                  scrollGesturesEnabled:
                                                                      true,
                                                                  onMapCreated:
                                                                      (controller) {
                                                                    setState(
                                                                        () {
                                                                      _mapController =
                                                                          controller;
                                                                    });
                                                                  },
                                                                  onTap: (LatLng
                                                                      location) {
                                                                    setState(
                                                                        () {
                                                                      selectedLocation =
                                                                          location;
                                                                      _markers
                                                                          .clear();
                                                                      _markers
                                                                          .add(
                                                                        Marker(
                                                                          markerId:
                                                                              MarkerId(location.toString()),
                                                                          position:
                                                                              location,
                                                                        ),
                                                                      );
                                                                    });
                                                                  },
                                                                  markers:
                                                                      _markers,
                                                                  initialCameraPosition:
                                                                      const CameraPosition(
                                                                    target: LatLng(
                                                                        -17.7901017567347,
                                                                        31.02520492364587),
                                                                    zoom: 12,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(
                                height:
                                    20), // Add spacing between the two Containers
                            if (isMapVisible)
                              Container(
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage(
                                        'assets/images/greenbutton.webp'),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                margin:
                                    const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                padding: const EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: () {
                                    sendEggDataToServer(
                                        data!.animalId,
                                        _addressController.text.toString(),
                                        data.amount,
                                        "Eggs",
                                        selectedLocation!.latitude,
                                        selectedLocation!.longitude);
                                  },
                                  child: const Text(
                                    'SHIP',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
            Column(
              children: [
                const Text(
                  'POWERED BY ',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Image.asset(
                  'assets/images/white logog.png',
                  width: 100,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void sendToServer(String animalId, double amount, String redemptionType,
      String paymentService, String phoneNumber) async {
    if (phoneNumber.isNotEmpty &&
        _paymentService.isNotEmpty &&
        _redeemService.isValidPhoneNumber(phoneNumber)) {
      var postResponse = await _redeemService.sendDataToServer(
          animalId, amount, redemptionType, paymentService, phoneNumber);
      if (postResponse[0] == 201) {
        Fluttertoast.showToast(
          msg: postResponse[1],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 20.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: postResponse[1],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 20.0,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Phone Number is not valid!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 20.0,
      );
    }
  }

  void sendEggDataToServer(String animalId, String address, double amount,
      String redemptionType, double latitude, double longitude) async {
    if (selectedLocation != '' && address.isNotEmpty) {
      var postResponse = await _redeemService.sendEggDataToServer(
          animalId, address, amount, redemptionType, latitude, longitude);
      if (postResponse[0] == 201) {
        Fluttertoast.showToast(
          msg: postResponse[1],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 20.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: postResponse[1],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 20.0,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Address Can not be empty and select a location on our map",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 20.0,
      );
    }
  }
}
