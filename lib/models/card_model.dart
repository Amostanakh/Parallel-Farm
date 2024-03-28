
class CardModel {
  final String cardNumber;
  final int expiryYear;
  final int expiryMonth;
  final int cvc;

  CardModel(
      {required this.cardNumber,
      required this.expiryYear,
      required this.expiryMonth,
      required this.cvc,
    });

  Map<String, dynamic> toJson() => {
        'cardNumber': cardNumber,
        'expiryYear': expiryYear,
        'expiryMonth': expiryMonth,
        'cvc': cvc,
      };
}
