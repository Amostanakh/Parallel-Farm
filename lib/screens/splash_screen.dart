import 'package:flutter/material.dart';
import 'package:parallel_farm/constants/routeConstants.dart';
import 'package:parallel_farm/constants/sharedPrefConstants.dart';
import 'package:parallel_farm/utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkForWelcome(context);
  }

  Future<void> _checkForWelcome(BuildContext context) async {
    // await Future.delayed(const Duration(seconds: 3));

    bool hasSeenWelcome = await getSPBoolean(opened);
    if (hasSeenWelcome) {
      Navigator.of(context).pushReplacementNamed(login);
    } else {
      saveBool(opened, true);
      Navigator.of(context).pushReplacementNamed(welcomeScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image covering the whole screen
          Image.asset(
            'assets/images/splashbackground.jpg',
            fit: BoxFit.cover,
          ),

          // Centered logos
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // First logo
                Image.asset(
                  'assets/images/logo.png',
                  width: 200, // Set width as needed
                  height: 200, // Set height as needed
                ),

                // Spacer for separation
                const SizedBox(height: 20),

                // Second logo
                Image.asset(
                  'assets/images/second_logo.png',
                  width: 150,
                  height: 150,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
