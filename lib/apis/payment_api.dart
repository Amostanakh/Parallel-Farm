import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:parallel_farm/constants/routeConstants.dart';
import 'package:parallel_farm/models/payment_model.dart';
import 'package:parallel_farm/utils/utils.dart';

class PaymentApi {
  final Dio _dio = Dio();
  String _token = "";

  PaymentApi() {
    getToken();
  }

  void getToken() async {
    _token = await getSP(login);
  }

  Future<Map<String, dynamic>> postAmountApi({
    required PaymentModel payment,
  }) async {
    var newToken = await getSP(login);
    try {
      String url =
          "https://sf-auth-service-6a5c6b7a7c0d.herokuapp.com/api/v1/payments/pay-with-stripe";

      // Retrieve JWT and extract user ID

      Response response = await _dio.post(
        url,
        data: payment.toJson(),
        options: Options(
          receiveDataWhenStatusError: true,
          headers: {
            "content-type": "application/json",
            "Authorization": "Bearer $newToken",
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Payment failed');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future paymentIntentApi({
    required amountPaid,
    required pwEquivalent,
    required intentId,
  }) async {
    var newToken = await getSP(login);
    try {
      String url =
          "https://sf-auth-service-6a5c6b7a7c0d.herokuapp.com/api/v1/payments/confirm-stripe-payment-intent";

      // Retrieve JWT and extract user

      var packet = {
        "amount": amountPaid,
        "email": 'test@gmail.com',
        'currency': 'USD',
        "description": "Payment  for wallet",
        "intent": intentId,
        "pwEquivalent": pwEquivalent,
      };

      Response response = await _dio.post(
        url,
        data: jsonEncode(packet),
        options: Options(
          receiveDataWhenStatusError: true,
          headers: {
            "content-type": "application/json",
            "Authorization": "Bearer $newToken",
          },
        ),
      );
      return response;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future getMyWalletBalance() async {
    var newToken = await getSP(login);
    try {
      String url =
          "https://sf-auth-service-6a5c6b7a7c0d.herokuapp.com/api/v1/payments/my-wallet-balance";

      // Retrieve JWT and extract user

      Response response = await _dio.get(
        url,
        options: Options(
          receiveDataWhenStatusError: true,
          headers: {
            "content-type": "application/json",
            "Authorization": "Bearer $newToken",
          },
        ),
      );
      return response;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
