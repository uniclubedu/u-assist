

import 'package:cloud_firestore/cloud_firestore.dart';
import 'PaymentMode.dart';
import 'package:intl/src/intl/date_format.dart';

class Payment {

  String uid;
  String memberId;

  late DateTime date;
  late  double amount;
  late String paymentMode;


  Payment({
    this.uid='',
    required this.memberId,
    required this.date,
    required this.amount,
    required this.paymentMode,
  });

  factory Payment.fromJson(Map<String, dynamic> json){
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return Payment(
      uid: json['uid'] as String,
      memberId: json['memberId'] as String,
      amount: json['amount'] as double,
      date: (json['date'] as Timestamp).toDate(),
      paymentMode: json['paymentMode'] as String,
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'uid': uid,
      'memberId': memberId,
      'amount': amount,
      'date': date,
      'paymentMode': paymentMode,
    };

  }

}
