// ignore: file_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:u_assist/Payment/Payment.dart';
import 'package:u_assist/Payment/dao/payment_dao.dart';
import 'package:u_assist/Screens/MemberProfile.dart';
import 'package:u_assist/Screens/Register/member.dart';

import '../components/rounded_button.dart';
import '../components/rounded_input_field.dart';

final items = [
  'CASH',
  'GOOGLE_PAY',
  'PHONE_PAY',
  'PAYTM',
  'NETBANKING',
  'CREDIT_CARD',
  'DEBIT_CARD',
  'AMAZON_PAY',
];

// ignore: must_be_immutable
class AddPaymentWigdet extends StatefulWidget {
  late String memberId;
  late Payment payment;
  late Member member;

  //StreamController <UserBean>streamController;
  //UserRegistration(this.streamController);
  @override
  _PaymentWidgetState createState() => _PaymentWidgetState();

  AddPaymentWigdet(this.member, {Key? key}) : super(key: key);
}

class _PaymentWidgetState extends State<AddPaymentWigdet> {
  String dropdownValue = items.first;
  late String memberId = widget.member.memberId;
  DateTime selectedDate = DateTime.now();
  String? paymentDate;

  late double amount;
  late String paymentMode = 'CASH';
  late bool _isLoading;
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Colors.grey[300],
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  get membershipEndDate => null;

  get membershipStartDate => null;

  @override
  void initState() {
    _isLoading = false;

    // TODO: implement initState
    super.initState();
  }

  final paymentDao = PaymentDAO();
  final GlobalKey<FormState> userRegistrationFrmKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        paymentDate = formatter.format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Payment"),
          leading: MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.arrow_back_ios, color: Colors.white)),
          backgroundColor: Colors.purple,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              RoundedInputField(
                key: const Key("amount"),
                hintText: "Amount",
                onChanged: (value) {
                  amount = double.parse(value);
                },
                icon: Icons.currency_rupee,
              ),
              Container(
                padding: const EdgeInsets.only(right: 150, bottom: 5),
                child: Text("Payment Date", style: TextStyle(fontSize: 15)),
              ),
              ElevatedButton(
                style: raisedButtonStyle,
                child: Container(
                    padding: const EdgeInsets.only(right: 150),
                    child: Container(
                      padding: const EdgeInsets.only(),
                      child: (paymentDate == null)
                          ? Text('Payment Date')
                          : Text(paymentDate!),
                    )),
                onPressed: () {
                  _selectDate(context);
                },
              ),
              Container(
                padding: const EdgeInsets.only(right: 150, bottom: 5),
                child: Text("Payment Mode", style: TextStyle(fontSize: 15)),
              ),
              //DropdownButtonFormField(items: items, onChanged: onChanged)
              Container(
                padding: EdgeInsets.only(right: 100),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),

                // dropdown below..
                child: DropdownButton<String>(
                  value: paymentMode,
                  onChanged: (newValue) =>
                      setState(() => paymentMode = newValue!),
                  items: items
                      .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ))
                      .toList(),

                  // add extra sugar..
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 42,
                  underline: SizedBox(),
                ),
              ),

              RoundedButton(
                key: const Key("value11"),
                text: "Add Payment",
                press: () async {
                  _isLoading = true;
                  await savePayment();
                  _isLoading = false;
                  Navigator.of(context).pop();
                  // Navigator.pushAndRemoveUntil(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => MemberProfile(widget.member)),
                  //     (route) => false);
                },
              ),

              // add extra sugar..
            ],
          ),
        ));
  }

  savePayment() async {
    Payment payment = Payment(
      memberId: memberId,
      date: selectedDate,
      amount: amount,
      paymentMode: paymentMode,
    );
    print("Saving payment detflutter_testails: ${payment.toJson()}");
    paymentDao
        .savePayment(payment)
        .then((value) => print("Payment saved successfully"));
  }
}
