

import 'package:u_assist/bean/PaymentMode.dart';

class Payment {

  late final String memberId;

  late final String date;
  late final double amount;

  late final PaymentMode paymentMode;


  Payment({
    required this.memberId,
    required this.date,
    required this.amount,
    required this.paymentMode,


  });

  factory Payment.fromJson(Map<String, dynamic> json){
    return Payment(
      memberId: json['memberId'] as String,
      amount: json['amount'] as double,
      date: json['date'] as String,
      paymentMode: json['paymentMOde'] as PaymentMode,
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'memberId': memberId,
      'amount': amount,
      'date': date,
      'paymentMode': paymentMode,
    };

  }

}
