

import 'package:flutter/material.dart';
import 'package:u_assist/Screens/Login/components/background.dart';

class UserInfoRow extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfoRow> {

  static const descTextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w800,
    fontFamily: 'Roboto',
    letterSpacing: 0.5,
    fontSize: 18,
    height: 2,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(
          color: Colors.black,
          width: 5
        )
      ),
      child: Row(
        children: [
          Column(
            children: [
              Row(
                children: const [
                  Text('Jitendra Saini')
                ],

              ),
              Row(
                children: const [
                  Text('9694879050')
                ],
              ),
              Row(
                children: const [
                  Text('Full Time')
                ],
              ),
              Row(
                children:  [
                  Column(
                    children: const [
                      Text('Joining Date'),
                      Text('01/01/2022')
                    ],
                  )
                ],
              )
            ],
          ),
          Column(
            children: [
              Expanded(
                  flex: 4,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blueAccent,
                      border: Border.all(
                          color: Colors.blueAccent,
                          width: 30.0,
                          style: BorderStyle.solid),
                      // image:  DecorationImage(
                      //   fit: BoxFit.cover,
                      //   image: AssetImage('assets/images/login_bottom.png') as ImageProvider,
                      //),
                    ),
                    child: const CircleAvatar(
                      //radius: 30.0,
                      backgroundImage: AssetImage('assets/images/login_bottom.png') as ImageProvider,
                      backgroundColor: Colors.transparent,
                    )
                  )
              )
            ],
          )
        ],
      ),
    );
  }
}
