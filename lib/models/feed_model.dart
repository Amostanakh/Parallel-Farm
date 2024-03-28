class Feed {
  final String animalId;
  final int amount;
  final int price;
  final String walletId;
  final String userId;
  final String transactionId;

  Feed({
    required this.animalId,
    required this.amount,
    required this.price,
    required this.walletId,
    required this.userId,
    required this.transactionId,
  });

  Map<String, dynamic> toJson() => {
        'animalId': animalId,
        'amount': amount,
        'price': price,
        'walletId': walletId,
        'userId': userId,
        'transactionId': transactionId,
      };
}
