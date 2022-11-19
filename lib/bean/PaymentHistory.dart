import 'dart:async';

import 'package:expandable_datatable/expandable_datatable.dart';
import 'package:flutter/material.dart';
import 'package:u_assist/bean/Payment.dart';

import '../Payment/dao/payment_dao.dart';
import '../Screens/Register/member.dart';
import 'package:intl/src/intl/date_format.dart';
import '../constants.dart';

// ignore: must_be_immutable
class PaymentHistory extends StatefulWidget {
  Member member;

  @override
  State<PaymentHistory> createState() => _PaymentHistory();

  PaymentHistory(this.member, {Key? key}) : super(key: key);
}

class _PaymentHistory extends State<PaymentHistory> {
  late List<Payment> paymentsList;
  final paymentDao = PaymentDAO();
  StreamController<Payment> paymentDataController = StreamController<
      Payment>.broadcast();
  late bool _isLoading = false;

  @override
  Future<void>? initState() {
    // TODO: implement initState
    print("init state is getting called");

    _isLoading = true;
    //var constant;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await loadPaymentData().then((value) =>
      {
        print("value from loaddata init ${value}"),
      });
      setState(() {

      });
    });
    print("data has been loded");
    return null;
  }

  Future<List<Payment>> loadPaymentData()  async {
    paymentsList = await paymentDao.getPaymentDetails(widget.member.memberId);
    setState(() {


    });
    return paymentsList;
  }


  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          appBar: AppBar(
            title: const Text("Payment History"),
            leading: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(

                  );
                },
                child: const Icon(Icons.arrow_back_ios, color: Colors.white)),
            backgroundColor: Colors.purple,
          ),
          body: ExpandableTheme(
            data: ExpandableThemeData(
              context,
              rowBorder: const BorderSide(color: Colors.amber),
                expandedBorderColor: Colors.black,
              paginationSize: 48

            ),
            child: ExpandableDataTable(
              rows: buildGrid(),
              headers: headers,
              visibleColumnCount: 3,
              onRowChanged:(newRow) => updateRow(newRow),
              // renderEditDialog: (row, onSuccess) =>
              //     _buildEditDialog(row, onSuccess),
            ),
          )


      );
  }
  List<ExpandableColumn<dynamic>> headers = [
    ExpandableColumn<int>(columnTitle: "Date", columnFlex: 4),
    ExpandableColumn<String>(columnTitle: "Amount", columnFlex: 3),
    ExpandableColumn<String>(columnTitle: "Payment Mode", columnFlex: 4),
  ];
  List<ExpandableRow> buildGrid() {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    List<ExpandableRow> rows = paymentsList.map<ExpandableRow>((e) {
      print( e.paymentMode);
      return ExpandableRow(cells: [
        ExpandableCell<String>(columnTitle: "Date", value:formatter.format(e.date) ),
        ExpandableCell<double>(columnTitle: "Amount", value: e.amount),
        ExpandableCell<String>(
            columnTitle: "Payment Mode", value: e.paymentMode),
      ]);
    }).toList();

    print( headers.length == rows.first.cells.length);
    return rows;
  }
  Widget _buildEditDialog(
      ExpandableRow row, Function(ExpandableRow) onSuccess) {
    return AlertDialog(
      title: SizedBox(
        height: 300,
        child: TextButton(
          child: const Text("Change name"),
          onPressed: () {

          },
        ),
      ),
    );
  }

  updateRow(ExpandableRow newRow) {
    print("update row has been called");
    print(newRow.cells.first.value);
  }
// Future<List<Payment>> loadPaymentData() async {
//   paymentsList = await paymentDao.getPaymentDetails();
//   setState(() {
//
//   });
//   return paymentsList;
// }
}

