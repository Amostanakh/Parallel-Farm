class AdoptAnimalModel {
  final String ownerId;
  final int totalCost;
  final String bacthId;
  final int batchNumber;
  final int numberOfAnimals;
  final String walletId;
  final int allAdoptedTotalCost;

  AdoptAnimalModel(
      {required this.walletId,
      required this.numberOfAnimals,
      required this.ownerId,
      required this.totalCost,
      required this.bacthId,
      required this.batchNumber,
      required  this.allAdoptedTotalCost});

  Map<String, dynamic> toJson() => {
        'ownerId': ownerId,
        'numberOfAnimals': numberOfAnimals,
        'totalCost': totalCost,
        'walletId': walletId,
        'bacthId': bacthId,
        'batchNumber': batchNumber,
        "allAdoptedTotalCost": allAdoptedTotalCost
      };
}
