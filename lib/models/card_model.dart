import 'package:equatable/equatable.dart';

class CardModel extends Equatable {
  final int cardId;
  final String cardNo;
  final num startAmount;
  final num cardStart;
  final num customerId;
  final String updatedAt;
  final num cardBalance;
  final num cardWBalance;
  final String status;
  final num total;

  CardModel(
      {this.cardId,
      this.cardNo,
      this.startAmount,
      this.cardStart,
      this.customerId,
      this.updatedAt,
      this.cardBalance,
      this.cardWBalance,
      this.status,
      this.total});

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      cardId: json['card_id'],
      cardNo: json['card_no'],
      startAmount: json['start_amount'],
      cardStart: json['card_start'],
      customerId: json['customer_id'],
      updatedAt: json['updated_at'],
      cardBalance: json['card_balance'],
      cardWBalance: json['card_wbalance'],
      status: json['status'],
      total: json['total'],
    );
  }

  toJson() {
    return {
      'card_id': '',
      'card_no': '',
      'start_amount': '',
      'card_start': '',
      'customer_id': '',
      'updated_at': '',
      'card_balance': '',
      'card_wbalance': '',
      'status': '',
      'total': '',
    };
  }

  @override
  List<Object> get props => [
        cardId,
        cardNo,
        cardStart,
        startAmount,
        customerId,
        updatedAt,
        cardBalance,
        cardWBalance,
        status,
        total
      ];

  @override 
  String toString() => "Card : {"+
    "cardId: $cardId, cardNo: $cardNo, cardStart: $cardStart, startAmount: $startAmount," +
    "customerId: $customerId, updatedAt: $updatedAt, cardBalance: $cardBalance, " +
    "cardWBalance: $cardWBalance, status: $status, total: $total} ";
}
