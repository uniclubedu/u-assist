
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:u_assist/Screens/PhoneAuth/login.dart';
import 'package:u_assist/Screens/Register/user.dart';
import 'package:u_assist/Screens/Signup/UserRegistration.dart';
import 'package:u_assist/Screens/dashboard/UserDetails.dart';

import '../../constants.dart';
import '../Register/dao/user_dao.dart';
import '../Util/NewsCardSkelton.dart';
import '../Util/UserDetailsWidget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String uid ="";

  var name = "jitendra";
  var phoneNumber = "9694879050";
  var image = "image";
  late List<UserBean> usersList =[];
  final userDao = new UserDao();

  late bool _isLoading = false;

  StreamController<UserBean> userDataController =
  StreamController<UserBean>.broadcast();


  @override
  Future<void>? initState()  {
    // TODO: implement initState
    print("init state is getting called");
    //await loadUserData();
    _isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_){
      loadUserData().then((value) => {print("hello"),_isLoading= false});
    });
    super.initState();
    print("data has been loded");
    return null;

  }

  Future<List<UserBean>>loadUserData()  async {
    usersList =  await userDao.getUserDetails();
    setState(() {});
    return usersList;
  }


  @override
  Widget build(BuildContext context) {

    return _buildPage();

    //
    // return new ListView(
    //   padding: const EdgeInsets.all(8),
    //   children: children,
    //);
    //
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Home'),
    //     actions: [
    //       IconButton(
    //         icon: Icon(Icons.logout),
    //         onPressed: () async {
    //           await FirebaseAuth.instance.signOut();
    //           Navigator.pushAndRemoveUntil(
    //               context,
    //               MaterialPageRoute(builder: (context) => LoginScreen()),
    //               (route) => false);
    //         },
    //       )
    //     ],
    //   ),
    //   body: Row(
    //     children: [
    //       // TextButton(
    //       //     style: ButtonStyle(
    //       //       foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
    //       //       overlayColor: MaterialStateProperty.resolveWith<Color?>(
    //       //             (Set<MaterialState> states) {
    //       //           if (states.contains(MaterialState.hovered)) {
    //       //             return Colors.blue.withOpacity(0.04);
    //       //           }
    //       //           if (states.contains(MaterialState.focused) ||
    //       //               states.contains(MaterialState.pressed)) {
    //       //             return Colors.blue.withOpacity(0.12);
    //       //           }
    //       //           return null; // Defer to the widget's default.
    //       //         },
    //       //       ),
    //       //     ),
    //       //     onPressed: () {
    //       //       Navigator.pushAndRemoveUntil(
    //       //         context,
    //       //         MaterialPageRoute(builder: (context) => UserRegistration()),
    //       //             (route) => false);},
    //       //     child: const Text('Register User')
    //       // ),
    //     // new UserDetailsWidget(),
    //     ],
    //
    //   ),
    // );
  }

  Widget _buildPage(){
  //  loadUserData();
    final children = <Widget>[];
    children.add(buildRegisterButtonWidget());
    for (UserBean user in usersList) {
      children.add(new UserDetailsWidget(user));
    }

    return SafeArea(child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false);
              },
            )
          ],
        ),
      body: StreamBuilder<UserBean>(
        stream: userDataController.stream,
        builder: (context, snapshot){
            if(snapshot.hasData){
              return ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  children: children,
              );
              //return Text(snapshot.data.toString());
            }else{
              return _isLoading?
              ListView.separated(
                itemCount: 5,
                itemBuilder: (context, index) => const NewsCardSkelton(),
                separatorBuilder: (context, index) =>
                const SizedBox(height: defaultPadding),
              )
              :ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                children: children,
              );
            }
        },
      ),
      // body: ListView(
      //   shrinkWrap: true,
      //   padding: const EdgeInsets.all(8),
      //   children: children,
      //
      // ) ,
    ));
  }
  Widget buildRegisterButtonWidget(){
    return TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return Colors.blue.withOpacity(0.04);
              }
              if (states.contains(MaterialState.focused) ||
                  states.contains(MaterialState.pressed)) {
                return Colors.blue.withOpacity(0.12);
              }
              return null; // Defer to the widget's default.
            },
          ),
        ),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => UserRegistration()),
              (route) => false);
        },
        child: const Text('Register User'));
  }

}
