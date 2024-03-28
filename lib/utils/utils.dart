import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenWidth(BuildContext context) {
  return screenSize(context).width;
}

double screenHeight(BuildContext context) {
  return screenSize(context).height;
}

Widget addVerticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

Widget addHorizontalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

void showToast(BuildContext context, String text) {
  Fluttertoast.showToast(
      msg: text, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
}

// bool validatePassword(String value) {
//   String pattern =
//       r'/((?=.*\\d)|(?=.*\\W+))(?![.\\n])(?=.*[A-Z])(?=.*[a-z]).*$/';
//   RegExp regExp = RegExp(pattern);
//   if (value.isEmpty) {
//     return false;
//   } else if (!regExp.hasMatch(value)) {
//     return false;
//   }
//   return true;
// }

bool validateEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

bool validatePassword(String password) {
  return RegExp(r"/((?=.*\\d)|(?=.*\\W+))(?![.\\n])(?=.*[A-Z])(?=.*[a-z]).*$/")
      .hasMatch(password);
}

Future<void> saveBool(String key, bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}

Future<int> getSPInt(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getInt(id) != null) {
    return prefs.getInt(id)!;
  } else {
    return 0;
  }
}

Future<void> saveInt(String key, int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);
}

Future<bool> getSPBoolean(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getBool(id) != null) {
    return prefs.getBool(id)!;
  } else {
    return false;
  }
}

Future<void> saveSP(String key, String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, token);
}

Future<String> getSP(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString(id) != null) {
    return prefs.getString(id)!;
  } else {
    return "";
  }
}
