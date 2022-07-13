import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserDetailsWidget extends StatefulWidget{

  var name;
  var mobileNumber;
  var image;

  @override
  State<UserDetailsWidget> createState() => _UserDetailsWidgetState();

  UserDetailsWidget(this.name, this.mobileNumber, this.image);
}



class _UserDetailsWidgetState extends State<UserDetailsWidget> {

  static const descTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w800,
    fontFamily: 'Roboto',
    letterSpacing: 0.5,
    fontSize: 18,
    height: 2,
  );

  Image image = Image.asset("assets/images/profile.png");
  @override
  Widget build(BuildContext context){
    return Container(
      height: 200.0,
      width: 200.0,
      decoration: BoxDecoration(
          color: Colors.grey,
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
          gradient: const LinearGradient(
              colors: [
                Colors.black,
                Colors.grey
              ]
          ),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey ,
                blurRadius: 2.0,
                offset: Offset(2.0,2.0)
            )
          ]
      ),

        padding: const EdgeInsets.all(32),
        child:
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(

                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        widget.name,
                        style: descTextStyle,
                        ),
                    ),
                    Text(
                      'Contact Number : ${widget.mobileNumber}',
                      style: descTextStyle
                    )
                  ],
                )
            ),
            CircleAvatar(
              radius: 40,
              backgroundImage: image.image,
            ),
          ],
        ),
    );
  }
}