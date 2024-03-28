import 'package:parallel_farm/apis/auth_api.dart';
import 'package:parallel_farm/constants/routeConstants.dart';
import 'package:parallel_farm/models/password_reset_model.dart';
import 'package:parallel_farm/models/user_model.dart';
import 'package:parallel_farm/utils/logs.dart';
import 'package:parallel_farm/utils/utils.dart';

class AuthService {
  var authApi = AuthApi();

  Future<bool> signUpUser(UserModel user) async {
    // initialize ApiService
    String result = await authApi.registerUser(user);
    DevLogs.logInfo(result);
    return true;
  }

  Future<String> loginUser(String email, String password) async {
    String response = await authApi.loginUserByEmail(email, password);

    if (response.startsWith('ey')) {
      // save the token here
      var input = response.toString();
      String newToken = input.replaceAll(RegExp(r'[{}":\s]|token'), '');
      saveSP(login, newToken);
      return newToken;
    } else {
      return response;
    }
  }

  Future<bool> resetUserPassword(PasswordResetModel passwordreset) async {
    try {
      String response = await authApi.resetUserPassword(passwordreset);

      if (response != "") {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      DevLogs.logError('error caught: $e');
      // handle the exception
      return false;
    }
  }

  Future<bool> verifyPhone(String phone) async {
    bool response = await authApi.verifyPhone(phone);
    if (response) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> verifyEmail(dynamic user) async {
    bool response = await authApi.verifyEmail(user);
    if (response) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> verifyOtp(String phone, String otp) async {
    bool response = await authApi.verifyOtp(phone, otp);
    if (response) {
      return true;
    } else {
      return false;
    }
  }
}
