
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowEarning extends StatefulWidget {

  double totalEarning;
  ShowEarning(this.totalEarning, {Key? key}) : super(key: key);

  @override
  _ShowEarningState createState() => _ShowEarningState();
}

class _ShowEarningState extends State<ShowEarning> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Row(
          children: [
            Container(
              child: Text("Total Earning of this month : ${widget.totalEarning}"),
            )
          ],
        ),
      ),
    );
  }
}
