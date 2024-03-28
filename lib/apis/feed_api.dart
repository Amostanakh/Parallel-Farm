// for api calls
import 'dart:async';

import 'package:parallel_farm/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:parallel_farm/constants/routeConstants.dart';
import 'package:parallel_farm/models/feed_model.dart';
import 'package:parallel_farm/utils/utils.dart';

class FeedApi {
  Dio dio = Dio();
  String _token = "";

  FeedApi() {
    getToken();
  }

  void getToken() async {
    _token = await getSP(login);
  }

  Future<void> postFeed(String id, Feed feed) async {
    try {
      var response = await dio.post(
        '/api/v1/feeds/$id',
        data: feed.toJson(),
      );
      if (response.statusCode == 200) {
        print('Feed posted successfully');
      } else {
        print('Failed to post feed');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<Response> getMyFeedBalance() async {
    var newToken = await getSP(login);
    try {
      String url = "$apiBaseUrl/v1/payments/my-feed-wallet-balance";
      final response = await dio.get(
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

  Future<Response> buyFeed(int amount) async {
    var newToken = await getSP(login);
    try {
      String url = "$apiBaseUrl/v1/payments/fund-feed-wallet";
      var response = await dio.post(
        url,
        data: {"amount": amount},
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

  Future<Response> feedMyAnimals(String id) async {
    var newToken = await getSP(login);
    try {
      String url = "$apiBaseUrl/v1/feeds/feed/my-animal/$id";
      var response = await dio.post(
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

  Future<Response> feedAlMyAnimals() async {
    var newToken = await getSP(login);
    try {
      String url = "$apiBaseUrl/v1/feeds/feed/my-animals";

      var response = await dio.post(
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
