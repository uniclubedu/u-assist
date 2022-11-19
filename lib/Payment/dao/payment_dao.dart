import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:u_assist/Screens/Register/member.dart';
import 'package:u_assist/util/Constant.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/src/intl/date_format.dart';


import '../../bean/Payment.dart';




class PaymentDAO {
  final DatabaseReference _userRef =
  FirebaseDatabase.instance.reference().child('payment');


  Payment get paymentObj => paymentObj;



  Future<Payment> savePayment(Payment payment) async {
    print('Saving payment.');
    try {
        FirebaseFirestore.instance
            .collection(Constant.PAYMENTS_COLLECTION_NAME)
            .add(payment.toJson())
            .then((value) =>
            print("Added "
                "payment ${payment.toJson()}"))
            .catchError((error) => print("Failed to add the payment: $error"));
      return payment;
    } catch (stacktrace, e) {
      print(e);
     print(stacktrace);
    }
    throw Exception("Payment is not saved");
  }

  Future<List<Payment>> getPaymentDetails(String memberId) async {
    print("Getting payment details");
    List<Payment> paymentsData = [];
    try {
      // Get docs from collection reference
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection(Constant.PAYMENTS_COLLECTION_NAME).where("memberId",isEqualTo: memberId).get();
      // Get data from docs and convert map to List
      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      //for a specific field
      print("payment data $allData");
      for (var payment in allData) {
        Type type = payment.runtimeType;

        Map<String, dynamic> data = jsonDecode(jsonEncode(payment));
        print(data.toString());
        Payment paymentObj = Payment.fromJson(data);
        paymentsData.add(paymentObj);
      }
      return paymentsData;
    } catch (e, stacktrace) {
      print("Exception while getting user details $e");
      print(stacktrace);
    }

    return paymentsData;
  }

  Future<double> getPaymentAmount(String memberId, String membershipStartDate, String membershipEndDate) async {
    print("Getting total payment of member ${memberId} and membership start ${membershipStartDate} and membership end ${membershipEndDate}");
    double totalPayment=0;
    try {
      final DateFormat formatter = DateFormat('dd-MM-yyyy');

      // Get docs from collection reference
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection(Constant.PAYMENTS_COLLECTION_NAME)
          .where("memberId",isEqualTo: memberId)
          .where("date", isGreaterThan: formatter.parse(membershipStartDate))
          .where("date", isLessThan: formatter.parse(membershipEndDate))
          .get();
      // Get data from docs and convert map to List
      final  allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      //for a specific field
      print("payment data $allData");
      for (var payment in allData) {
       // Map<String, dynamic> data = jsonDecode(jsonEncode(payment));
        print(payment.runtimeType);
        Payment paymentObj = Payment.fromJson(payment as Map<String, dynamic>);
        totalPayment+=paymentObj.amount;
      }
      print("total amoutn ${totalPayment}");
      return totalPayment;
    } catch (e, stacktrace) {
      print("Exception while getting user details $e");
      print(stacktrace);
    }
    return totalPayment;
  }


  }
