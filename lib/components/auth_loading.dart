import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AuthLoading extends StatefulWidget {
  final String message;
  const AuthLoading(
      {this.message = 'Just a moment, We are getting you into the farm',
      super.key});

  @override
  State<AuthLoading> createState() => _AuthLoadingState();
}

class _AuthLoadingState extends State<AuthLoading> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SpinKitCircle(
            color: Color.fromARGB(255, 24, 248, 16), // Color of the spinner
            size: 150.0, // Size of the spinner
          ),
          const SizedBox(height: 10),
          Text(
            widget.message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Text color on top of the background image
            ),
          ),
        ],
      ),
    );
  }
}
