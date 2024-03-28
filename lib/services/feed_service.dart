import 'package:parallel_farm/apis/feed_api.dart';

class FeedService {
getFeedAmount() async {
  FeedApi feedApi = FeedApi();
  var feedResponse = await feedApi.getMyFeedBalance();
  var amount = feedResponse.data?['data']?['amount']?.toString() ?? '0';
  
  return amount;
}




  sendDataToServer(int amount) async {
    FeedApi feedApi = FeedApi();
    var response = await feedApi.buyFeed(amount);
    return response.data['message'].toString();
  }

  feedAnimalGroup(String id) async {
    FeedApi feedApi = FeedApi();
    var response = await feedApi.feedMyAnimals(id);
    return response.statusCode;
  }

  feedAllAnimals() async {
    FeedApi feedAllMyAnimals = FeedApi();
    var response = await feedAllMyAnimals.feedAlMyAnimals();
    var responseList = [
      response.statusCode,
      response.data['message'].toString()
    ];
    return responseList;
  }
}
