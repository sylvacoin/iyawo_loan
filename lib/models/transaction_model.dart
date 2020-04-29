import 'package:equatable/equatable.dart';

class Transaction extends Equatable
{
  final num amount;
  final String transType;
  final String customerNo;
  final num handlerId;
  final String cardNo;
  final num noDays;

  const Transaction({this.amount, this.transType, this.customerNo, this.handlerId, this.cardNo, this.noDays = 1});
  
  @override
  List<Object> get props => [];
  
  @override
  String toString() => "Transaction: {Amount: $amount, TransType: $transType, UserId: $customerNo, HandlerId: $handlerId, CardNo: $cardNo, NoDays: $noDays}";

  factory Transaction.fromJson(Map<String, dynamic> json)
  {
    return Transaction(
      amount: json['amount'] as num,
      transType: json['trans_type'] as String,
      customerNo: json['customer_no'] as String,
      handlerId: json['handler_id'] as num,
      cardNo: json['card_no'] as String,
      noDays: json['no_days'] as num
    );
  }

  toJson()
  {
    return {
      'amount': amount,
      'trans_type': transType,
      'user_id': customerNo,
      'handler_id': handlerId,
      'card_no': cardNo,
      'no_days': noDays
    };
  }

}