import 'package:dio/dio.dart';
import 'package:parallel_farm/constants/constants.dart';
import 'package:parallel_farm/constants/routeConstants.dart';
import 'package:parallel_farm/utils/utils.dart';

class UserApi {
  final Dio _dio = Dio();
  UserApi() {
    getToken();
  }

  Future<void> getToken() async {
    await getSP(login);
  }

  Future<Response> getUserDetails() async {
    var newToken = await getSP(login);
    try {
      String url = "$apiBaseUrl/v1/users/user-details";
      final response = await _dio.post(
        url,
        options: Options(
          receiveDataWhenStatusError: true,
          headers: {
            "content-type": "application/json",
            "Authorization": "Bearer $newToken"
          },
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
  
}
