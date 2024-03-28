import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parallel_farm/apis/auth_api.dart';
import 'package:parallel_farm/models/password_reset_model.dart';
import 'package:parallel_farm/services/user_navigation_service.dart';

class SettingScreen extends StatefulWidget {
  static const String routeName = "settings";

  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  UserNavigationService userNavigationScreen = UserNavigationService();
  final _formKey = GlobalKey<FormState>(); 
  String name = "Patel Tanaka";
  String phoneNumber = "+263";
  String email = "pateltanaka22@live.com";
  String bio = 'I love chickens';
  String imageUrl = "https://placeimg.com/150/150/profile";
  String newPassword = '';
  String confirmPassword = '';
  String currentPassword = '';
  bool _isSubmitting = false;

  void initState() {
    super.initState();
    loadUser();
  }

  loadUser() async {
    var phonenumber = await userNavigationScreen.getDetails();
    setState(() {
      phoneNumber = phonenumber;
    });
  }

  Future _changePassword() async {
    if (newPassword != confirmPassword) {
      return 'Password does not match';
    }
    if (newPassword.length < 4) {
      return 'Password must be at least 4 characters';
    }
    if (currentPassword.isEmpty) {
      return 'Current Password is required';
    }
    if (newPassword.isEmpty) {
      return 'New Password is required';
    }
    if (confirmPassword.isEmpty) {
      return 'Confirm Password is required';
    }
    final passwordreset = PasswordResetModel(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword);
    final response = await AuthApi().resetUserPassword(passwordreset);
    if (response == 'success') {
      return 'Password changed successfully';
    } else {
      return 'Failed to change password';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(right: 350),
              child: GestureDetector(
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    SizedBox(
                        height: 100.0,
                        width: 100.0,
                        child: InkWell(
                          onTap: () => {},
                          child: const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/profile_icon.png'),
                            radius: 50.0,
                          ),
                        )),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20.0),
            ListTile(
              title: const Text('Phone Number'),
              subtitle: Text(phoneNumber),
            ),
            const Divider(),
            const SizedBox(height: 20.0),
            Card(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          'Change Password',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              labelText: 'Current Password',
                              hintText: 'Enter Current password'),
                          onChanged: (value) {
                            currentPassword = value;
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Current Password is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                              labelText: 'New Password',
                              hintText: 'Enter New password'),
                          onChanged: (val) {
                            newPassword = val;
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'New Password is required';
                            }

                            if (val.length < 4) {
                              return 'Password must be at least 4 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                              labelText: 'Confirm Password',
                              hintText: 'Confirm New password'),
                          onChanged: (val) {
                            confirmPassword = val;
                          },
                          validator: (val) {
                            var val;
                            if (val.IsEmpty) {
                              return 'Confirm Password is required';
                            }

                            if (val.length < 4) {
                              return 'Password must be at least 4 characters';
                            }

                            if (val != newPassword) {
                              return 'Password does not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _changePassword();
                          },
                          child: const Text('Change Password'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor:
                                  Colors.white // Set button color to green
                              ),
                        )
                      ],
                    )))
          ]),
        ),
      ),
    );
  }
}
