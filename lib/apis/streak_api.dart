import 'package:dio/dio.dart';
import 'package:parallel_farm/constants/constants.dart';
import 'package:parallel_farm/constants/routeConstants.dart';
import 'package:parallel_farm/utils/utils.dart';

class StreakDataApi {
  final Dio dio = Dio();

  // Streak endpoint
  getStreakDataApi() async {
    var newToken = await getSP(login);
    try {
      String url = "$apiBaseUrl/v1/streaks";
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
      return response.data['data'];
    } catch (e) {
      if (e is DioError) {
        return Future.value(e.response);
      } else {
        rethrow;
      }
    }
  }

  //claim Reward

  Future<Response> claimReward() async {
    var newToken = await getSP(login);
    try {
      String url = "$apiBaseUrl/v1/streak-rewards/claim";
      var response = await dio.get(
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

  //Get Active rewards

  claimActiveReward() async {
    var newToken = await getSP(login);
    try {
      String url = "$apiBaseUrl/v1/streak-rewards/active";
      var response = await dio.get(
        url,
        options: Options(
          receiveDataWhenStatusError: true,
          headers: {
            "content-type": "application/json",
            "Authorization": "Bearer $newToken"
          },
        ),
      );
      return response.data['data'];
    } catch (e) {
      if (e is DioError) {
        return Future.value(e.response);
      } else {
        rethrow;
      }
    }
  }
}
