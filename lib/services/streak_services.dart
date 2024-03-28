import 'package:parallel_farm/apis/streak_api.dart';

class StreakServices {
  getStreakService() async {
    StreakDataApi streakdata = StreakDataApi();
    var streakResponse = await streakdata.getStreakDataApi();
    return streakResponse;
  }

  claimRewardService() async {
    StreakDataApi streakdata = StreakDataApi();
    var claimRewardResponse = await streakdata.claimReward();
    var responseList = [
      claimRewardResponse.statusCode,
      claimRewardResponse.data['message'].toString(),
    ];

    print(responseList);
    return responseList;
  }

  activeRewardService() async {
    StreakDataApi activeRewardata = StreakDataApi();
    var activeRewardResponse = await activeRewardata.claimActiveReward();
    return activeRewardResponse;
  }
}
