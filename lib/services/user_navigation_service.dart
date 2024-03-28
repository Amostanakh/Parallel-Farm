import 'package:parallel_farm/apis/user_api.dart';

class UserNavigationService {
  getDetails() async {
    UserApi userApi = UserApi();
    var userResponse = await userApi.getUserDetails();
    var test = userResponse.data['data']['username'].toString();
    print('==========> $test');
    return userResponse.data['data']['username'].toString();
  }
}
