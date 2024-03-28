import 'package:flutter/material.dart';
import 'package:parallel_farm/screens/login_screen.dart';
import 'package:parallel_farm/screens/settings_screen.dart';
import 'package:parallel_farm/services/user_navigation_service.dart';

class UserNavigationScreen extends StatefulWidget {
  static const String routeName = "user-nav";

  const UserNavigationScreen({Key? key}) : super(key: key);

  @override
  State<UserNavigationScreen> createState() => _UserNavigationScreenState();
}

class _UserNavigationScreenState extends State<UserNavigationScreen> {
  UserNavigationService userNavigationScreen = UserNavigationService();
  var username = "User";

  void initState() {
    super.initState();
    loadUser();
  }

  loadUser() async {
    var userName = await userNavigationScreen.getDetails();
    setState(() {
      username = userName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/user_nav_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Icon(
                          color: Color.fromARGB(255, 85, 70, 70),
                          Icons.arrow_back,
                          size: 40,
                          weight: 900,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Image.asset('assets/images/profile_icon.png',
                      width: MediaQuery.of(context).size.height * 0.14,
                      fit: BoxFit.cover),
                  const SizedBox(height: 5),
                  Text(
                    '@ $username',
                    style: const TextStyle(
                      fontSize: 35,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'VIP',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            color: Colors.green,
                            margin: const EdgeInsets.all(5.0),
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.star,
                                    color: Color.fromARGB(255, 212, 175, 6))),
                          ),
                          Container(
                            color: Colors.green,
                            margin: const EdgeInsets.all(5.0),
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.star,
                                    color: Color.fromARGB(255, 212, 175, 6))),
                          ),
                          Container(
                            color: Colors.green,
                            margin: const EdgeInsets.all(5.0),
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.star,
                                    color: Color.fromARGB(255, 212, 175, 6))),
                          ),
                          Container(
                            color: Colors.green,
                            margin: const EdgeInsets.all(5.0),
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.star,
                                    color: Color.fromARGB(255, 212, 175, 6))),
                          ),
                        ]),
                  ),
                  const SizedBox(height: 16),
                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                          child: const Icon(
                            Icons.settings,
                            color: Color.fromARGB(255, 212, 175, 6),
                            size: 18, // Adjust size as needed
                          ),
                        ),
                        title: const Text(
                          'CHANGE PASSWORD',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.pushNamed(context, SettingScreen.routeName,
                              arguments: (route) => false);
                        },
                      ),
                      ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                          child: const Icon(
                            Icons.exit_to_app,
                            color: Color.fromARGB(255, 212, 175, 6),
                            size: 18, // Adjust size as needed
                          ),
                        ),
                        title: const Text(
                          'LOGOUT',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
