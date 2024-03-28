import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_validator/form_validator.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:parallel_farm/components/auth_already.dart';
import 'package:parallel_farm/components/auth_button.dart';
import 'package:parallel_farm/components/global_textfield_component.dart';
import 'package:parallel_farm/models/user_model.dart';
import 'package:parallel_farm/screens/home_screen.dart';
import 'package:parallel_farm/screens/login_screen.dart';
import 'package:parallel_farm/services/auth_service.dart';
import 'package:parallel_farm/utils/utils.dart';

enum PhoneVerificationState {
  SHOW_PHONE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class SignUpScreen extends StatefulWidget {
  static const String routeName = "sign_up";

  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signUpFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKeyForSnackBar = GlobalKey();
  PhoneVerificationState currentState =
      PhoneVerificationState.SHOW_PHONE_FORM_STATE;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  final otpController = TextEditingController();
  bool visible = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  final messaging = FirebaseMessaging.instance;
  bool spinnerLoading = false;
  String? verificationIDFromFirebase;
  late String _number;

  TextEditingController phoneNumberController = TextEditingController();
  _verifyPhoneButton() async {
    setState(() {
      spinnerLoading = true;
    });

    final AuthService authService = AuthService();
    final user = {"email": emailController.text, "otp": otpController.text};
    bool response = await authService.verifyEmail(user);

    if (response) {
      Navigator.pushNamedAndRemoveUntil(
          context, HomeScreen.routeName, (route) => false);
      setState(() {
        spinnerLoading = false;
      });
    } else {
      setState(() {
        spinnerLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Operation Failed')),
        );
      });
    }
  }

  void _verifyOTPButton() async {
    setState(() {
      spinnerLoading = true;
    });
    // String? token = await messaging.getToken();
    AuthService apiService = AuthService();
    final user = UserModel(
        password: passwordController.text,
        role: "customer",
        email: emailController.text,
        username: nameController.text);

    bool res = await apiService.signUpUser(user);

    if (res) {
      setState(() {
        spinnerLoading = false;
        currentState = PhoneVerificationState.SHOW_OTP_FORM_STATE;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('There was an error registering,Please try again'),
        ),
      );
      setState(() {
        spinnerLoading = false;
      });
    }
  }

  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'ZW');

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  getOTPForm(context) {
    return Form(
      key: _signUpFormKey,
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
                  image: AssetImage('assets/images/logo_new.png'),
                ),
              ),
            ),
            addVerticalSpace(5),
            // Wrapping the relevant part with the background image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/signup.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 64.0, vertical: 39.0),
                child: Column(
                  children: [
                    GlobalTextField(
                      textEditingController: otpController,
                      obscureText: true,
                      labelText: "OTP code",
                    ),
                  ],
                ),
              ),
            ),
            addVerticalSpace(10),
            AuthButton(name: "VERIFY OTP", onChanged: _verifyOTPButton),
          ],
        ),
      ),
    );
  }

  getForm(context) {
    return Form(
      key: _signUpFormKey,
      child: Column(
        children: [
          addVerticalSpace(10),
          SizedBox(
            height: screenHeight(context) * 0.15,
            child: const Center(
              child: Image(
                width: 200,
                image: AssetImage('assets/images/logo_new.png'),
              ),
            ),
          ),
          addVerticalSpace(screenHeight(context) * 0.02),
          // Wrapping the relevant part with the background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/signup.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 60.0, vertical: 40.0),
              child: Column(
                children: [
                  GlobalTextField(
                      height: 69,
                      textEditingController: nameController,
                      textInputType: TextInputType.text,
                      labelText: "Username",
                      //maxLength: 200,
                      validator: ValidationBuilder()
                          .minLength(4, 'Must be more than 4 letters')
                          .build()),
                  GlobalTextField(
                      height: 69,
                      textEditingController: emailController,
                      textInputType: TextInputType.text,
                      labelText: "Email",
                      //maxLength: 200,
                      validator: ValidationBuilder()
                          .minLength(8, 'Must be more than 8 letters')
                          .build()),
                  GlobalTextField(
                      height: 69,
                      textEditingController: passwordController,
                      obscureText: true,
                      textInputType: TextInputType.text,
                      labelText: "Password",
                      // maxLength: 200,
                      validator: ValidationBuilder()
                          .minLength(8, 'Must be more than 8 letters')
                          .build()),
                  GlobalTextField(
                    height: 69,
                    textEditingController: confirmPasswordController,
                    obscureText: true,
                    //maxLength: 200,
                    labelText: "Confirm Password",
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value != passwordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          addVerticalSpace(10),
          Already(
            onChanged: () {
              Navigator.pushNamed(context, LoginScreen.routeName,
                  arguments: (route) => false);
            },
            name: "Sign in",
          ),
          addVerticalSpace(10),

          AuthButton(name: "SIGN UP", onChanged: _verifyOTPButton),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
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
            child: spinnerLoading
                ? Container(
                    padding: const EdgeInsets.symmetric(vertical: 200),
                    child: const Column(
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
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                : currentState == PhoneVerificationState.SHOW_PHONE_FORM_STATE
                    ? getForm(context)
                    : getOTPForm(context),
          ),
        ),
      ),
    );
  }
}
