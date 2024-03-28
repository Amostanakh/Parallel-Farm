// api_service.dart
import 'package:dio/dio.dart';
import 'package:parallel_farm/constants/constants.dart';
import 'package:parallel_farm/models/password_reset_model.dart';
import 'package:parallel_farm/models/user_model.dart';
import 'package:parallel_farm/utils/logs.dart';

class AuthApi {
  final String baseUrl = apiBaseUrl;
  final Dio _dio = Dio();

  Future<String> registerUser(UserModel user) async {
    try {
      Response response = await _dio.post(
        '$baseUrl/v1/auth/register-using-email',
        data: user.toJson(),
      );
      DevLogs.logInfo('$response');
      return '$response';
    } on DioException catch (e) {
      DevLogs.logError('$e');
      if (e.response?.statusCode == 400) {
        return 'password too long';
      } else {
        return 'Phone number invalid';
      }
    } catch (e) {
      return 'Network error try again';
    }
  }

  Future<String> loginUser(String username, String password) async {
    final String url = '$baseUrl/v1/auth/login';
    try {
      Response response = await _dio.post(
        url,
        data: {
          "phoneNumber": username,
          "password": password,
        },
      );

      if (response.statusCode == 201) {
        return response.data['token'].toString();
      } else {
        return 'cred';
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return "credentials not valid";
      } else {
        return 'credentials not valid';
      }
    } catch (e) {
      return 'Network error try again';
    }
  }

  Future<String> loginUserByEmail(String email, String password) async {
    final String url = '$baseUrl/v1/auth/login-with-email';
    try {
      Response response = await _dio.post(
        url,
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 201) {
        return response.data['token'].toString();
      } else {
        return 'cred';
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return "credentials not valid";
      } else {
        return 'credentials not valid';
      }
    } catch (e) {
      return 'Network error try again';
    }
  }

  Future<void> logoutUser() async {
    try {
      Response response = await _dio.post(
        '$baseUrl/v1/auth/logout',
      );

      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to logout user.');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> resetUserPassword(PasswordResetModel passwordreset) async {
    try {
      Response response = await _dio.post(
        '$baseUrl/v1/users/change-password',
        data: passwordreset.toJson(),
      );

      if (response.statusCode == 201) {
        return response.data['message'];
      } else {
        throw Exception('Failed to register user.');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> verifyPhone(String phone) async {
    try {
      Response response = await _dio.post(
        '$baseUrl/v1/send-otp',
        data: {"phoneNumber": phone},
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      false;
    }
    return true;
  }

  Future<bool> verifyEmail(dynamic user) async {
    try {
      Response response = await _dio.post(
        '$baseUrl/v1/verify-email-otp',
        data: user,
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      false;
    }
    return true;
  }

  Future<bool> verifyOtp(String phone, String otp) async {
    try {
      Response response = await _dio.post(
        '$baseUrl/v1/verify-otp',
        data: {"phoneNumber": phone, "otp": otp},
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      false;
    }
    return true;
  }
}
