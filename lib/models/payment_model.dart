
class PaymentModel {
  final String token;
  final String description;
  final String userId;
  final String email;
  final String currency;
  final double amount;

  PaymentModel(
      {required this.token,
      required this.description,
      required this.userId,
      required this.email,
      required this.currency,
      required this.amount});

  Map<String, dynamic> toJson() => {
        'token': token,
        'description': description,
        'userId': userId,
        'email': email,
        'currency': currency,
        'amount': amount
      };
}
