import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:parallel_farm/constants/routeConstants.dart';
import 'package:parallel_farm/models/card_model.dart';
import 'package:parallel_farm/models/payment_model.dart';
import 'package:parallel_farm/apis/payment_api.dart';
import 'package:dio/dio.dart';
import 'package:parallel_farm/utils/utils.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:parallel_farm/constants/constants.dart';

class PaymentService {
  var paymentApi = PaymentApi();

  Future<int> makePayment({
    required PaymentModel payment,
  }) async {
    var response = await paymentApi.postAmountApi(payment: payment);
    return response['statusCode'];
  }

  Future<String> get userId async {
    String res = await getSP(login);
    String stringifiedJSON = res.replaceAll(RegExp(r'[{}":\s]|token'), '');
    Map<String, dynamic> decodedToken = JwtDecoder.decode(stringifiedJSON);
    String id = decodedToken['id'];
    return id;
  }

  Future createPaymentIntent({
    required amountPaid,
    required pwEquivalent,
    required intentAvaliable,
  }) async {
    var response = await paymentApi.paymentIntentApi(
        amountPaid: amountPaid,
        pwEquivalent: pwEquivalent,
        intentId: intentAvaliable);
    return response.data;
  }

  Future getMyWalletBalance() async {
    var response = await paymentApi.getMyWalletBalance();
    return response.data;
  }
}
