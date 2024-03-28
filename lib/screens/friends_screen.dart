// friends_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parallel_farm/services/friends_service.dart';

class FriendsScreen extends StatefulWidget {
  static const String routeName = "friends";
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  final FriendsService _friendsService = FriendsService();
  var myFriends = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadFriends();
  }

  loadFriends() async {
    try {
      var _friends = await _friendsService.getFriends();

      if (_friends.isNotEmpty) {
        setState(() {
          myFriends = _friends;
          isLoading = false;
        });
      }
    } catch (error) {
      // Handle error if needed
      print("Error loading friends: $error");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.18,
                ),
                Expanded(
                  // Use Expanded to make the green card take the available height
                  child: Card(
                    color: Color.fromARGB(255, 107, 192, 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: Column(
                          children: <Widget>[
                            const Text(
                              'MY FRIENDS',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Expanded(
                              child: Card(
                                color: Colors.white,
                                child: SizedBox(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'Friend List',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        // Use Expanded for the ListView to take the available height
                                        child: ListView.builder(
                                          itemCount: myFriends.length,
                                          itemBuilder:
                                              (BuildContext context, int index) {
                                            return Card(
                                              color: Color.fromARGB(
                                                  255, 228, 226, 226),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  // Add your animation logic here
                                                },
                                                child: Container(
                                                  child: ListTile(
                                                    leading: CircleAvatar(
                                                      backgroundColor: Colors.green,
                                                      child: Text(
                                                        '${index + 1}',
                                                        style: const TextStyle(
                                                            color: Colors.white),
                                                      ),
                                                    ),
                                                    title: Text(
                                                      '${myFriends[index]['registeredUserId']['username']}',
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    subtitle: Text(
                                                      formatDate(myFriends[index]['createdAt']),
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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

String formatDate(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  String formattedDate = DateFormat('d MMMM y').format(dateTime);

  return formattedDate;
}