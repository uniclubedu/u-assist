import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/src/intl/date_format.dart';
import 'package:u_assist/Screens/Register/member.dart';
import 'package:u_assist/util/Constant.dart';
import 'package:uuid/uuid.dart';

import '../../Payment/Payment.dart';
import '../../auth/auth_dao.dart';

class PaymentDAO {
  final DatabaseReference _userRef =
      FirebaseDatabase.instance.reference().child('payment');

  Payment get paymentObj => paymentObj;

  Future<Payment> savePayment(Payment payment) async {
    debugPrint('Saving payment.');
    await AuthDAO().getUID().then(
          (value) => {payment.uid = value!},
        );
    try {
      FirebaseFirestore.instance
          .collection(Constant.PAYMENTS_COLLECTION_NAME)
          .add(payment.toJson())
          .then((value) => debugPrint("Added "
              "payment ${payment.toJson()}"))
          .catchError((error) => debugPrint("Failed to add the payment: $error"));
      return payment;
    } catch (stacktrace, e) {
      debugPrint(e as String?);
      debugPrint("Stacktrace : ${stacktrace}");
    }
    throw Exception("Payment is not saved");
  }

  Future<double> getTotalEarningOfCurrentMonth() async {
    debugPrint("Getting total earning of current month");
    double totalEarning = 0.0;
    String? uid = "";
    await AuthDAO().getUID().then(
          (value) => {uid = value},
        );
    try {
      DateTime now = DateTime.now();
      DateTime startTime = DateTime(now.year, now.month, 1);
      // Get docs from collection reference
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(Constant.PAYMENTS_COLLECTION_NAME)
          .where("uid", isEqualTo: uid)
          .where("date", isGreaterThan: startTime)
          .where("date", isLessThanOrEqualTo: now)
          .get();
      // Get data from docs and convert map to List
      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      for (var payment in allData) {
        // Map<String, dynamic> data = jsonDecode(jsonEncode(payment));
        Payment paymentObj = Payment.fromJson(payment as Map<String, dynamic>);
        totalEarning += paymentObj.amount;
        debugPrint(" total earning ${totalEarning}");
      }

    } catch (e, stacktrace) {
      debugPrint("Exception while getting total earning for uid ${uid} $e");
      debugPrint("Stacktrace : ${stacktrace}");
    }

    return totalEarning;
  }

  Future<List<Payment>> getPaymentDetails(String memberId) async {
    debugPrint("Getting payment details");
    List<Payment> paymentsData = [];
    try {
      // Get docs from collection reference
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(Constant.PAYMENTS_COLLECTION_NAME)
          .where("memberId", isEqualTo: memberId)
          .get();
      // Get data from docs and convert map to List
      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      //for a specific field
      debugPrint("payment data $allData");
      for (var payment in allData) {
        Type type = payment.runtimeType;
        Payment paymentObj = Payment.fromJson(payment as Map<String, dynamic>);
        paymentsData.add(paymentObj);
      }
      return paymentsData;
    } catch (e, stacktrace) {
      debugPrint("Exception while getting user details $e");
      debugPrint("Stacktrace : ${stacktrace}");
    }

    return paymentsData;
  }

  Future<double> getPaymentAmount(String memberId, String membershipStartDate,
      String membershipEndDate) async {
    debugPrint(
        "Getting total payment of member ${memberId} and membership start ${membershipStartDate} and membership end ${membershipEndDate}");
    double totalPayment = 0;
    try {
      final DateFormat formatter = DateFormat('dd-MM-yyyy');

      // Get docs from collection reference
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(Constant.PAYMENTS_COLLECTION_NAME)
          .where("memberId", isEqualTo: memberId)
          .where("date", isGreaterThanOrEqualTo: formatter.parse(membershipStartDate))
          .where("date", isLessThanOrEqualTo: formatter.parse(membershipEndDate))
          .get();
      // Get data from docs and convert map to List
      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      //for a specific field
      debugPrint("payment data $allData");
      for (var payment in allData) {
        Payment paymentObj = Payment.fromJson(payment as Map<String, dynamic>);
        totalPayment += paymentObj.amount;
      }
      debugPrint("total amoutn ${totalPayment}");
      return totalPayment;
    } catch (e, stacktrace) {
      debugPrint("Exception while getting user details $e");
      debugPrint("Stacktrace : ${stacktrace}");
    }
    return totalPayment;
  }
}
