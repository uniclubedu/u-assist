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
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "Total Earning of this month :",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "${widget.totalEarning.toInt()}",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Open Sans',
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
