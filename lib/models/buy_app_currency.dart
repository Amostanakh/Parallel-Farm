class BuyAppCurrencyModel {
  final String stripeToken;
  final String description;
  final String userId;
  final String email;

  BuyAppCurrencyModel(
      {required this.stripeToken,
      required this.description,
      required this.userId,
      required this.email});

  Map<String, dynamic> toJson() => {
        'stripeToken': stripeToken,
        'description': description,
        'userId': userId,
        'email': email,
      };
}
