import 'package:parallel_farm/apis/redeem_api.dart';

class RedeemService {
  sendDataToServer(String animalId, double amount,
      String redemptionType, String paymentService, String phoneNumber) async {
    RedeemApi redeemApi = RedeemApi();
    var response = await redeemApi.sendRedeemRequestMoney(
        animalId, amount, redemptionType, paymentService, phoneNumber);
    var responseList = [
      response.statusCode,
      response.data['message'].toString()
    ];
    return responseList;
  }

  sendEggDataToServer(String animalId, String address, double amount,
   String redemptionType, double latitude, double longitude) async {
    RedeemApi redeemApi = RedeemApi();
    var response = await redeemApi.sendRedeemRequestEggs(
        animalId, address, amount, redemptionType, latitude, longitude);
    var responseList = [
      response.statusCode,
      response.data['message'].toString()
    ];
    return responseList;
  }

   bool isValidPhoneNumber(String phoneNumber) {
  
    if (phoneNumber.isEmpty) {
      return false;
    }

    phoneNumber = phoneNumber.replaceAll(RegExp(r'\s'), '');

    if (!phoneNumber.startsWith('+263')) {
      return false;
    }

    String remainingDigits = phoneNumber.substring(4);

    if (remainingDigits.length != 9) {
      return false;
    }

    if (!isNumeric(remainingDigits)) {
      return false;
    }

    return true;
  }

  bool isNumeric(String str) {
    return double.tryParse(str) != null;
  }

  
}
