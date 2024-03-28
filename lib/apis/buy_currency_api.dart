import 'package:dio/dio.dart';
import 'package:parallel_farm/constants/constants.dart';
import 'package:parallel_farm/models/adopt_animal_model.dart';
import 'package:parallel_farm/utils/utils.dart';
import 'package:parallel_farm/constants/routeConstants.dart';

class BuyCurrencyApi {
  final Dio _dio = Dio();
  Future<Response> buyAppCurrency() async {
    var newToken = await getSP(login);
    try {
      String url = "$apiBaseUrl/v1/batches";
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
      if (e is DioError) {
        return Future.value(e.response);
      } else {
        rethrow;
      }
    }
  }

  Future<Response> animalAdopt(AdoptAnimalModel adoptAnimalRequest) async {
    var newToken = await getSP(login);
    try {
      String url = "$apiBaseUrl/v1/batches";
      final response = await _dio.get(
        url,
        data: adoptAnimalRequest,
        options: Options(
          receiveDataWhenStatusError: true,
          headers: {
            "content-type": "application/json",
            "Authorization": "Bearer $newToken"
          },
        ),
      );

      print(response.data);
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
