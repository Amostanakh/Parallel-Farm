import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:parallel_farm/components/auth_already.dart';
import 'package:parallel_farm/components/global_textfield_component.dart';
import 'package:parallel_farm/components/outline_text.dart';
import 'package:parallel_farm/constants/constants.dart';
import 'package:parallel_farm/screens/home_screen.dart';
import 'package:parallel_farm/screens/sign_up_screen.dart';
import 'package:parallel_farm/services/auth_service.dart';
import 'package:parallel_farm/utils/utils.dart';

import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();

  late TextEditingController emailController;
  late TextEditingController passwordController;
  final messaging = FirebaseMessaging.instance;

  var _loading = false;

  void _login() async {
    if (_loginFormKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });
      final AuthService authService = AuthService();
      String? token = await messaging.getToken();
      String response = await authService.loginUser(
          emailController.text, passwordController.text);

      if (response.startsWith('ey')) {
        Navigator.pushNamed(context, HomeScreen.routeName,
            arguments: (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response)),
        );
      }
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/splashbackground.jpg'), // Replace with your image asset
                  fit: BoxFit.cover,
                ),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitCircle(
                      color: Color.fromARGB(
                          255, 24, 248, 16), // Color of the spinner
                      size: 150.0, // Size of the spinner
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Just a moment, We are getting you into the farm',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors
                            .white, // Text color on top of the background image
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage('assets/images/background.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.darken),
                    ),
                  ),
                  child: SizedBox(
                    height: screenHeight(context),
                    child: SingleChildScrollView(
                      child: Form(
                          key: _loginFormKey,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: Column(
                              children: [
                                addVerticalSpace(screenHeight(context) * 0.1),
                                SizedBox(
                                  height: screenHeight(context) * 0.3,
                                  child: const Center(
                                      child: Image(
                                          width: 300,
                                          image: AssetImage(
                                              'assets/images/logo_new.png'))),
                                ),
                                addVerticalSpace(5),
                                Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/signup.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0, vertical: 28.0),
                                    child: Column(
                                      children: [
                                        addVerticalSpace(5),
                                        GlobalTextField(
                                            height: 69,
                                            textEditingController:
                                                emailController,
                                            textInputType:
                                                TextInputType.emailAddress,
                                            labelText: "Email"),
                                        GlobalTextField(
                                            height: 69,
                                            textEditingController:
                                                passwordController,
                                            obscureText: true,
                                            textInputType: TextInputType.text,
                                            labelText: "Password"),
                                      ],
                                    ),
                                  ),
                                ),
                                addVerticalSpace(10),
                                Container(
                                  height: 50,
                                  width: 200,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/greenbutton.webp'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: TextButton(
                                    onPressed: _login,
                                    child: const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Text(
                                        'Login',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                addVerticalSpace(10),
                                Already(
                                    onChanged: () {
                                      Navigator.pushNamed(
                                          context, SignUpScreen.routeName,
                                          arguments: (route) => false);
                                    },
                                    name: "Sign Up"),
                                addVerticalSpace(10),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          ForgotPasswordScreen.routeName);
                                    },
                                    child: const OutlineText(
                                      text: 'Forgot password',
                                      color: false,
                                    )),
                              ],
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
