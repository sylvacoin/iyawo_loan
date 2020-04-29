import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  final num customerId;
  final String fullName;
  final String gender;
  final num handlerId;
  final String customerNo;
  final num balance;
  final num wBalance;
  final String phone;

  Customer(
      {this.customerId,
      this.fullName,
      this.gender,
      this.handlerId,
      this.customerNo,
      this.balance,
      this.wBalance,
      this.phone});

  @override
  // TODO: implement props
  List<Object> get props => [
        customerId,
        fullName,
        gender,
        handlerId,
        customerNo,
        balance,
        wBalance,
        phone
      ];

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
        customerId: json['customer_id'] as num,
        fullName: json['full_name'] as String,
        gender: json['gender'] as String,
        handlerId: json['handler_id'] as num,
        customerNo: json['customer_no'] as String,
        balance: json['balance'] as num,
        wBalance: json['wbalance'] as num,
        phone: (json['phone'] as num).toString());
  }

  toJson() {
    return {
      "customer_id": customerId,
      "full_name": fullName,
      "gender": gender,
      "handler_id": handlerId,
      "customer_no": customerNo,
      "balance": balance,
      "wbalance": wBalance,
      "phone": phone,
    };
  }

  @override
  String toString() =>
      "Customer {customer_id: $customerId, full_name: $fullName,gender: $gender,handler_id: $handlerId,customer_no: $customerNo,balance: $balance,wbalance: $wBalance,phone: $phone}";
}
