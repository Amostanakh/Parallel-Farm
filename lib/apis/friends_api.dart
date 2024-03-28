import 'package:dio/dio.dart';
import 'package:parallel_farm/constants/constants.dart';
import 'package:parallel_farm/constants/routeConstants.dart';
import 'package:parallel_farm/utils/utils.dart';

class FriendsApi {
  final Dio _dio = Dio();
  String _token = "";

  FriendsApi() {
    getToken();
  }

  void getToken() async {
    _token = await getSP(login);
  }

  Future<Response> getMyFriendsApi() async {
    var newToken = await getSP(login);
    try {
      String url =
          "https://sf-auth-service-6a5c6b7a7c0d.herokuapp.com/api/v1/users/my-referals";
      final response = await _dio.get(
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
      if (e is DioError) {
        return Future.value(e.response);
      } else {
        rethrow;
      }
    }
  }
}
