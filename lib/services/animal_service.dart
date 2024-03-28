import 'package:parallel_farm/apis/animal_api.dart';
import 'package:parallel_farm/apis/check_balance_api.dart';

class AnimalService {
  Future<List<Map<String, dynamic>>> getBatches() async {
    AnimalApi animalApi = AnimalApi();
    var animalResponse = await animalApi.getAvailableAnimalsApi();

    // Assuming the data in the response is a List<Map<String, dynamic>>
    List<Map<String, dynamic>> animalData =
        List.castFrom(animalResponse.data['data']);

    return animalData;
  }

  double getreturnOnInvestment(
      int numberOfSelectedAnimals, int contractLength, int costOfOneUnit) {
    return (12 * numberOfSelectedAnimals) -
        ((contractLength * 0.8) + (costOfOneUnit * numberOfSelectedAnimals));
  }

  getWalletBalance() async {
    CheckBalanceApi walletApi = CheckBalanceApi();
    var walletresponse = await walletApi.getWalletBalance();
    return walletresponse.data;
  }

  adoptAnimalService(adoptAnimaldata) async {
    AnimalApi animalAdoptApi = AnimalApi();

    var res = await animalAdoptApi.postAdoptAnimalModel(adoptAnimaldata);

    return res;
  }
}
