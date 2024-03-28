import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_validator/form_validator.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:parallel_farm/models/password_reset_model.dart';
import 'package:parallel_farm/screens/login_screen.dart';
import 'package:parallel_farm/screens/sign_up_screen.dart';

import '../components/auth_already.dart';
import '../components/auth_button.dart';
import '../components/global_textfield_component.dart';
import '../constants/constants.dart';
import '../services/auth_service.dart';
import '../utils/utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = "forgot_password";
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool spinnerLoading = false;
  PhoneVerificationState currentState =
      PhoneVerificationState.SHOW_PHONE_FORM_STATE;
  final _forgotFormKey = GlobalKey<FormState>();
  late TextEditingController otpController;
  late TextEditingController phoneNumberController;
  late TextEditingController newPasswordController;
  String? verificationIDFromFirebase;
  String? deviceId;
  FirebaseAuth auth = FirebaseAuth.instance;

  _verifyPhoneButton() async {
    if (_forgotFormKey.currentState!.validate()) {
      setState(() {
        spinnerLoading = true;
      });
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumberController.text,
          verificationCompleted: (phoneAuthCredential) async {
            setState(() {
              spinnerLoading = false;
            });
            //TODO: Auto Complete Function
            //signInWithPhoneAuthCredential(phoneAuthCredential);
          },
          verificationFailed: (verificationFailed) async {
            setState(() {
              spinnerLoading = false;
            });
            print("Verification Code Failed: ${verificationFailed.message}");
          },
          codeSent: (verificationId, resendingToken) async {
            setState(() {
              spinnerLoading = false;
              currentState = PhoneVerificationState.SHOW_OTP_FORM_STATE;
              verificationIDFromFirebase = verificationId;
            });
          },
          codeAutoRetrievalTimeout: (verificationId) async {});
    }
  }

  late String _number;

  void _verifyOTPButton() async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationIDFromFirebase!,
        smsCode: otpController.text);
    signInWithPhoneAuthCredential(phoneAuthCredential);
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      spinnerLoading = true;
    });
    try {
      final authCredential =
          await auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        AuthService apiService = AuthService();
        final passwordResetModel = PasswordResetModel(
            newPassword: phoneNumberController.text,
            currentPassword: newPasswordController.text,
            confirmPassword: newPasswordController.text);
        bool res = await apiService.resetUserPassword(passwordResetModel);

        if (res) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password has been reset')),
          );
          Navigator.pushNamedAndRemoveUntil(
              context, LoginScreen.routeName, (route) => false);
          setState(() {
            spinnerLoading = false;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password reset Failed')),
          );
          Navigator.pushNamedAndRemoveUntil(
              context, LoginScreen.routeName, (route) => false);
          setState(() {
            spinnerLoading = false;
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e.message.toString());
      String error = e.message!;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Phone number verification failed")),
      );
      Navigator.pushNamedAndRemoveUntil(
          context, SignUpScreen.routeName, (route) => false);
      setState(() {
        spinnerLoading = false;
      });
    } catch (e) {
      Navigator.pushNamedAndRemoveUntil(
          context, SignUpScreen.routeName, (route) => false);
      setState(() {
        spinnerLoading = false;
      });
    }
  }

  @override
  void initState() {
    phoneNumberController = TextEditingController();
    otpController = TextEditingController();
    newPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    otpController.dispose();
    phoneNumberController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  getOTPForm(context) {
    return Form(
      key: _forgotFormKey,
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
                    addVerticalSpace(5),
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
            AuthButton(name: "VERIFY OTP", onChanged: _verifyOTPButton)
          ],
        ),
      ),
    );
  }

  getForm(context) {
    return Form(
      key: _forgotFormKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Column(
          children: [
            addVerticalSpace(screenHeight(context) * 0.05),
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
                    horizontal: 30.0, vertical: 39.0),
                child: Column(
                  children: [
                    addVerticalSpace(5),
                    IntlPhoneField(
                      flagsButtonPadding: const EdgeInsets.all(8),
                      dropdownIconPosition: IconPosition.trailing,
                      decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(width: 3.0, color: primaryColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(width: 3.0, color: primaryColor))),
                      initialCountryCode: 'ZW',
                      onChanged: (phone) {
                        setState(() {
                          _number = phone.completeNumber;
                        });
                      },
                    ),
                    addVerticalSpace(5),
                    GlobalTextField(
                      textEditingController: newPasswordController,
                      labelText: "New Pin",
                      validator: ValidationBuilder()
                          .minLength(4, 'Must be 4 characters')
                          // .regExp(RegExp(r'\d'), "Must 4 digits")
                          .build(),
                    ),
                  ],
                ),
              ),
            ),
            Already(
                onChanged: () {
                  Navigator.pushNamed(context, LoginScreen.routeName,
                      arguments: (route) => false);
                },
                name: "Sign In"),
            addVerticalSpace(10),
            AuthButton(
              name: "SUBMIT",
              onChanged: _verifyPhoneButton,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
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
                                color: Colors
                                    .white, // Text color on top of the background image
                              ),
                            ),
                          ],
                        ),
                      )
                    : currentState ==
                            PhoneVerificationState.SHOW_PHONE_FORM_STATE
                        ? getForm(context)
                        : getOTPForm(context))),
      ),
    );
  }
}
