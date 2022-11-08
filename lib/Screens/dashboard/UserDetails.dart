

import 'package:flutter/material.dart';
import 'package:u_assist/Screens/Login/components/background.dart';
import 'package:u_assist/Screens/Register/dao/user_dao.dart';

class UserInfoRow extends StatefulWidget {

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfoRow> {

  final userDao = new UserDao();

  @override
  void initState() {
    // TODO: implement initState
    print("init state is getting called");
    super.initState();
    //userDao.getUserDetails();
  }

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
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
      child: Container(

      height:200,
        width: 200,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(
          color: Colors.transparent,
          width: 5
        ),
        borderRadius: BorderRadius.horizontal()
      ),
      child :Row(
        children: <Widget>[
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Row(
                children: const [
                  Text(' Jitendra Saini')
                ],

              )),
              Expanded(child: Row(
                children: const [
                  Text('9694879050')
                ],
              )),
              Expanded(child: Row(
                children: const [
                  Text('Full Time')
                ],
              )),
              Expanded(child: Row(
                children:  [
                  Expanded(child: Column(
                    children: const [
                      Text('Joining Date'),
                      Text('01/01/2022')
                    ],
                  ))
                ],
              ))
            ],
          )),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom:30 ),
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0)
                    ),
                    child: const CircleAvatar(
                      //radius: 30.0,
                      backgroundImage: AssetImage('assets/images/profile.png')
                      as ImageProvider,
                      backgroundColor: Colors.white,
                    )
                  )
              )
            ],
          ))
        ],
      ),
    ));

  }
}
