import 'package:dio/dio.dart';
import 'package:parallel_farm/constants/constants.dart';
import 'package:parallel_farm/constants/routeConstants.dart';
import 'package:parallel_farm/utils/utils.dart';

class CheckBalanceApi {
  final Dio _dio = Dio();
  String _token = "";

  CheckBalanceApi() {
    getToken();
  }

  void getToken() async {
    _token = await getSP(login);
  }

  Future<Response> getWalletBalance() async {
    var newToken = await getSP(login);
    try {
      String url = "$apiBaseUrl/v1/payments/my-wallet-balance";
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
