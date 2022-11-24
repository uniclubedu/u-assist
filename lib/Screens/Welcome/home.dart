import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:u_assist/Payment/dao/payment_dao.dart';
import 'package:u_assist/Screens/PhoneAuth/login.dart';
import 'package:u_assist/Screens/Register/member.dart';
import 'package:u_assist/Screens/Signup/MemberRegistration.dart';
import 'package:u_assist/Screens/dashboard/ShowEarning.dart';
import 'package:u_assist/constants.dart' as constant;

import '../../constants.dart';
import '../../notification/SMSNotification.dart';
import '../../util/SMSNotificationTemplate.dart';
import '../Register/dao/user_dao.dart';
import '../Util/NewsCardSkelton.dart';
import '../Util/UserDetailsWidget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String uid = "";

  var name = "jitendra";
  var phoneNumber = "9694879050";
  var image = "image";
  late List<Member> usersList = [];
  late List<Member> tempList = [];
  final userDao = new UserDao();
  final paymentDao = PaymentDAO();
  late bool _isLoading = false;
  var totalEarning;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  StreamController<Member> userDataController =
      StreamController<Member>.broadcast();

  var isPaid = false;
  var isPending = false;
  bool isFree = false;
  bool isLatest = false;
  bool isOld = false;

  bool selected = false;
  static const IconData filter_alt_outlined =
      IconData(0xf068, fontFamily: 'MaterialIcons');

  @override
  Future<void>? initState() {
    // TODO: implement initState
    print("init state is getting called");
    //await loadUserData();
    log("constant.isTesting ${constant.isTesting}");
    if (!constant.isTesting) {
      _isLoading = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        loadUserData().then((value) => {print("hello"), _isLoading = false});
      });
      super.initState();
      print("data has been loded");
      return null;
    } else {
      userList = constant.userList;
      log("In else condition ${userList}");
    }
  }

  Future<List<Member>> loadUserData() async {
    usersList = await userDao.getUserDetails();
    tempList = List.from(usersList);
    totalEarning = await paymentDao.getTotalEarningOfCurrentMonth();
    setState(() {});
    return usersList;
  }

  @override
  Widget build(BuildContext context) {
    return _buildPage();
  }

  Widget _buildPage() {
    //loadUserData();
    final children = <Widget>[];
    children.add(ShowEarning(totalEarning));
    children.add(buildSearchWidget());
    for (Member user in tempList) {
      children.add(UserDetailsWidget(user));
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
           // child: const Icon(Icons.arrow_back_ios, color: Colors.grey)
        ),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_active),
            onPressed: () async {
              sendPaymentNotification();
            },
          ),
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


      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'nee',
            onPressed: () => setState(() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MemberRegistration()));
            }),
            tooltip: 'Add Member',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            heroTag: 'add button',
            onPressed: () => {
              showDialog(
                  context: context,
                  builder: (context) {
                    bool? isChecked = false;
                    return StatefulBuilder(builder: (context, setState) {
                      return AlertDialog(
                        content: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Fees"),
                                    FilterChip(
                                      label: Text("Paid"),
                                      showCheckmark: false,
                                      selected: isPaid,
                                      onSelected: (bool value) {
                                        setState(() {
                                          isPaid = !isPaid;
                                        });
                                      },
                                      selectedColor: Colors.orange,
                                      labelStyle: TextStyle(color: Colors.white),
                                      backgroundColor: Colors.grey,
                                      checkmarkColor: Colors.white,
                                      //showCheckmark: true,
                                    ),
                                    FilterChip(
                                      label: Text("Pending"),
                                      showCheckmark: false,
                                      selected: isPending,
                                      onSelected: (bool value) {
                                        setState(() {
                                          isPending = !isPending;
                                        });
                                      },
                                      selectedColor: Colors.orange,
                                      labelStyle: TextStyle(color: Colors.white),
                                      backgroundColor: Colors.grey,
                                      checkmarkColor: Colors.white,
                                      //showCheckmark: true,
                                    )
                                  ],
                                )
                              ],
                            )),
                        title: Text('Filters'),
                        actions: <Widget>[
                          InkWell(
                            child: Text('Apply'),
                            onTap: () {
                              showPaidMembers(isPaid, isPending);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
                  })
            },
            tooltip: 'Filter Member',
            child: Icon(filter_alt_outlined),
          )
        ],
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: StreamBuilder<Member>(
        stream: userDataController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              children: children,
            );
            //return Text(snapshot.data.toString());
          } else {
            return _isLoading
                ? ListView.separated(
                    itemCount: 5,
                    itemBuilder: (context, index) => const NewsCardSkelton(),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: defaultPadding,width: 50,),
                  )
                : ListView(
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
    );

  }

  Widget buildSearchWidget(){
    return new Container(
      color: Theme.of(context).primaryColor,
      margin: const EdgeInsets.all(5.0),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Card(
          child: ListTile(
            leading: Icon(Icons.search),
            title: TextField(
              controller: searchController,
              decoration: new InputDecoration(
                hintText: 'Search Member',
                border: InputBorder.none
              ),
              onChanged: onSearchTextChanged,
            ),
            trailing: new IconButton(
                onPressed: (){
                  searchController.clear();
                  onSearchTextChanged('');
                },
                icon: Icon(Icons.cancel),
            ),
          ),
        ),
      ),
    );
  }

  void showPaidMembers(bool showPaid, bool showPending) {
    print("calling show paid members");
    print("show paid ${showPaid} and show pending ${showPending}");
    if(showPaid && showPending){
      tempList = usersList;
      setState(() {

      });
      return;
    }
    if(showPaid){
      print("Only paid");
      tempList = usersList.where((member) => member.amountPaid>= double.parse(member.fees))
          .toList();
      print(usersList);
    }
    if(showPending){
      print("only pending");
      tempList = usersList.where((member) => member.amountPaid < double.parse(member.fees))
          .toList();
      print(usersList);
    }
    setState(() {

    });
  }

  onSearchTextChanged(String text) async {
    print("search text ${text}");
    if(text.isEmpty){
      tempList = List.of(usersList);
      setState(() {});
      return;
    }
    tempList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    print(usersList);
    usersList.forEach((userDetail) {
      if (userDetail.fullName.contains(text) )
        tempList.add(userDetail);
    });
    setState(() {});
  }

  void sendPaymentNotification() {
    print("Sending notification to pending fees members.");
    var smsNotification = SMSNotification();
    for(Member member in usersList){
      if(member.amountPaid < double.parse(member.fees)){
        if(member.mobileNumber != null && !member.mobileNumber.isEmpty){
          SMSNotificationTemplate smsTemplate = SMSNotificationTemplate();
          smsTemplate.message = "Hi, Sir/Mam an amount of Rs${(int.parse(member.fees) - member.amountPaid).toInt()} is pending. Please make the payment today.";
          smsTemplate.recipents.add(member.mobileNumber);
          smsNotification.sending_SMS(smsTemplate.message, smsTemplate.recipents);
        }
      }
    }
    showPaymentNotificationDialog();
  }

  void showPaymentNotificationDialog(){
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child:   Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text("Pending papyment notification has been sent successfully",
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize:20,
                            color: Colors.indigo,
                            fontWeight: FontWeight.normal
                        ),
                      )
                  ),),
              title: Text('Payment Notification'),
              actions: <Widget>[
                InkWell(
                  child: Container(
                    margin: const EdgeInsets.only(right:20, bottom: 5),
                    child: Text('Ok', style: TextStyle(
                        fontSize:20,
                        color: Colors.black,
                        fontWeight: FontWeight.normal
                    )),
                  ),
                  onTap: () {
                    showPaidMembers(isPaid, isPending);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
        });
  }
}

class Tech
{
  String label;
  Color color;
  bool isSelected;
  Tech(this.label, this.color, this.isSelected);
}