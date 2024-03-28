class CheckWalletModel {
  final int id;
  final int amount;
  final String userId;

  CheckWalletModel(
      {required this.id, required this.amount, required this.userId});

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "userId": userId,
      };
}
