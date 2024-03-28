import 'package:flutter/material.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:parallel_farm/constants/routeConstants.dart';
import 'package:parallel_farm/screens/friends_screen.dart';
import 'package:parallel_farm/screens/login_screen.dart';
import 'package:parallel_farm/services/friends_service.dart';
import 'package:parallel_farm/utils/utils.dart';
import 'package:share/share.dart';

class InviteScreen extends StatefulWidget {
  static const String routeName = "invite";
  const InviteScreen({super.key});

  @override
  State<InviteScreen> createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  late String dynamicLink;
  List<Map<String, dynamic>> referralList = [];
  final FriendsService _friendsService = FriendsService();

  @override
  void initState() {
    super.initState();
    initDynamicLinks();
    loadReferrals();
  }

  Future<void> loadReferrals() async {
    try {
      var friends = await _friendsService.getFriends();
      setState(() {
        referralList = friends;
      });
    } catch (error) {
      print("Error loading referrals: $error");
    }
  }

  Future<void> initDynamicLinks() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    handleDynamicLink(data);

    FirebaseDynamicLinks.instance.onLink.listen((dynamicLink) {
      handleDynamicLink(dynamicLink);
    });
  }

  void handleDynamicLink(PendingDynamicLinkData? data) {
    if (data != null) {
      final Uri deepLink = data.link;
      String? link = deepLink.queryParameters['link'];
      if (link != null) {
        Navigator.pushNamed(context, LoginScreen.routeName);
      }
    }
  }

  Future<void> generateDynamicLink() async {
    String res = await getSP(login);
    String stringifiedJSONToken = res.replaceAll(RegExp(r'[{}":\s]|token'), '');
    Map<String, dynamic> decodedToken = JwtDecoder.decode(stringifiedJSONToken);
    String link = decodedToken['myReferalLink'];

    dynamicLink = 'https://parallel-farm.com/signup?id=$link';
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.18,
                ),
                Card(
                  color: const Color.fromARGB(255, 107, 192, 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 385,
                      child: Column(
                        children: <Widget>[
                          const Text(
                            'INVITE A FRIEND',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          const Center(
                            child: Text(
                              'So they can benefit from this opportunity together with you',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await generateDynamicLink();
                              Share.share(
                                  'Click this link to download our app: $dynamicLink');
                                  
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  Color.fromARGB(255, 114, 218, 62),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text('SHARE LINK'),
                          ),
                          Card(
                            color: Colors.white,
                            child: SizedBox(
                              height: 200,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        const Text(
                                          'Referrals',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(context,
                                                    FriendsScreen.routeName,
                                                    arguments: (route) =>
                                                        false);
                                              },
                                              child: const Text(
                                                'See All',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            const Icon(Icons.arrow_forward_ios,
                                                color: Colors.black,
                                                size: 12.0),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children:
                                        referralList.take(4).map((friend) {
                                      return Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 107, 192, 10),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 3.0),
                                            ),
                                            Text(
                                              friend['registeredUserId']['username'] ??
                                                  '',
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
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
        ],
      ),
    );
  }
}
