import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:u_assist/Screens/PhoneAuth/login.dart';
import 'package:u_assist/Screens/Register/member.dart';
import 'package:u_assist/Screens/Signup/UserRegistration.dart';
import 'package:u_assist/constants.dart' as constant;

import '../../constants.dart';
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
  final userDao = new UserDao();

  late bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();

  StreamController<Member> userDataController =
      StreamController<Member>.broadcast();

  var isFilter = false;
  var isPending = false;
  bool isPaid = false;
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
    for (Member user in usersList) {
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
                                      selected: isFilter,
                                      onSelected: (bool value) {
                                        setState(() {
                                          isFilter = !isFilter;
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
                        title: Text('Stateful Dialog'),
                        actions: <Widget>[
                          InkWell(
                            child: Text('OK   '),
                            onTap: () {
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

  Widget buildFilterWidget() {
    return Row(
      children: [
        Container(
            child: FilterChip(
          label: Text("Chip Unselected"),
          selected: isFilter,
          onSelected: (bool value) {
            setState(() {
              isFilter = !isFilter;
            });
          },
          selectedColor: Colors.red,
          labelStyle: TextStyle(color: Colors.white),
          backgroundColor: Colors.blue,
          checkmarkColor: Colors.white,
          //showCheckmark: true,
        )),
      ],
    );
  }

  final List<String> _filters = <String>[];

  Widget _buildPopupDialog(BuildContext context) {


    var selected = [];
    var paid = "Paid";
    var pending = "pending";
    bool _selected=false;
    return AlertDialog(
      title: const Text('Popup example'),
      content: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: techChips(),
      ),
      actions: <Widget>[
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.purple,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }
  List<Widget> techChips () {
    List<Tech> _chipsList = [
      Tech("India", Colors.brown, false),
      Tech("Canada", Colors.deepPurple, false),
    ];
    List<Widget> chips = [];
    for (int i=0; i< _chipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left:10, right: 5),
        child: FilterChip(
          showCheckmark: _chipsList[i].isSelected,
          label: Text(_chipsList[i].label),
          labelStyle: TextStyle(color: Colors.white),
          backgroundColor: _chipsList[i].color,
          selected: _chipsList[i].isSelected,
          onSelected: (bool value)
          {
            setState(() {
              _chipsList[i].isSelected = value;
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }
}
class Tech
{
  String label;
  Color color;
  bool isSelected;
  Tech(this.label, this.color, this.isSelected);
}