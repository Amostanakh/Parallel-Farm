// friends_service.dart

import 'package:parallel_farm/apis/friends_api.dart';

class FriendsService {
  Future<List<Map<String, dynamic>>> getFriends() async {
    try {
      FriendsApi friendsApi = FriendsApi();
      var animalResponse = await friendsApi.getMyFriendsApi();

      if (animalResponse.data != null && animalResponse.data['data'] != null) {
        return List<Map<String, dynamic>>.from(animalResponse.data['data']);
      } else {
  
        return [];
      }
    } catch (error) {
      print("Error fetching friends: $error");
      return [];
    }
  }
}

