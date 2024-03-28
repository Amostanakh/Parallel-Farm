import 'package:dio/dio.dart';
import 'package:parallel_farm/constants/constants.dart';
import 'package:parallel_farm/constants/routeConstants.dart';
import 'package:parallel_farm/utils/utils.dart';

class RedeemApi {
  Dio dio = Dio();
  String _token = "";

  RedeemApi() {
    getToken();
  }

  void getToken() async {
    _token = await getSP(login);
  }

  Future<Response> sendRedeemRequestMoney(String animalId, double amount,
      String redemptionType, String paymentService, String phoneNumber) async {
        var newToken = await getSP(login);
    try {
      String url = "$apiBaseUrl/v1/redemptions";
      var response = await dio.post(
        url,
        data: {
          "animalId": animalId,
          "amount": amount,
          "redemptionType": redemptionType,
          "paymentService": paymentService,
          "phoneNumber": phoneNumber
        },
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

  Future<Response> sendRedeemRequestEggs(
      String animalId,
      String address,
      double amount,
      String redemptionType,
      double latitude,
      double longitude) async {
        var newToken = await getSP(login);
    try {
      String url = "$apiBaseUrl/v1/redemptions";
      var response = await dio.post(
        url,
        data: {
          "animalId": animalId,
          "address": address,
          "amount": amount,
          "redemptionType": redemptionType,
          "latitude": latitude,
          "longitude": longitude
        },
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
