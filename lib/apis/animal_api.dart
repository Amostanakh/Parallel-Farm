import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:parallel_farm/constants/constants.dart';
import 'package:parallel_farm/constants/routeConstants.dart';
import 'package:parallel_farm/models/adopt_animal_model.dart';
import 'package:parallel_farm/utils/utils.dart';

class AnimalApi {
  final Dio _dio = Dio();

  AnimalApi() {
    getToken();
  }

  Future<void> getToken() async {
    await getSP(login);
  }

  Future<Response> getAvailableAnimalsApi() async {
    var newToken = await getSP(login);
    try {
      String url = "$apiBaseUrl/v1/batches";
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

  Future<Response> postAdoptAnimalModel(List<dynamic> adoptAnimaldata) async {
    var newToken = await getSP(login);
    try {
      final apiUrl = "$apiBaseUrl/v1/animals";
      List<Map<String, dynamic>> newAnimalList = [];

      for (var animal in adoptAnimaldata) {
        newAnimalList.add({
          'batchId': animal['batchId'],
          'age': animal['age'],
          'price': animal['price'],
          'numberOfAnimals': animal['numberOfAnimals'],
          'contractLength': animal['contractLength'],
        });
      }

      var data = {
        'animals': newAnimalList,
        'totalCost': adoptAnimaldata[0]['allAdoptedTotalCost']
      };

      return await _dio.post(
        apiUrl,
        data: jsonEncode(data),
        options: _getRequestOptions(newToken),
      );
    } catch (e) {
      rethrow;
    }
  }
  Future<Response> getMyAnimalsApi() async {
    var newToken = await getSP(login);
    try {
      String url = "$apiBaseUrl/v1/animals/find/my-animals";
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
      rethrow;
    }
  }

  Options _getRequestOptions(String token) {
    return Options(
      receiveDataWhenStatusError: true,
      headers: {
        "content-type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
  }
}
