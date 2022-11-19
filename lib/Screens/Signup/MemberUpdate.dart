// ignore: file_names
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:u_assist/Screens/Register/dao/user_dao.dart';
import 'package:u_assist/Screens/Register/member.dart';
import 'package:u_assist/Screens/Signup/components/background.dart';
import 'package:u_assist/Screens/Signup/components/user_image_picker.dart';
import 'package:u_assist/components/rounded_button.dart';
import 'package:u_assist/components/rounded_input_field.dart';

import '../../constants.dart';
import '../Util/NewsCardSkelton.dart';
import '../Welcome/home.dart';

// ignore: must_be_immutable
class MemberUpdate extends StatefulWidget {
  //StreamController <UserBean>streamController;
  //UserRegistration(this.streamController);
    late Member member;

  @override
  _UserRegistrationState createState() => _UserRegistrationState();

  MemberUpdate(Member member){
    this.member = member;
  }
}

class _UserRegistrationState extends State<MemberUpdate> {
  late String name;
  late String contactNumber;
  late String emailId;
  late String address;
  late String date;
  late File _userImageFile;
  late int shiftValue = 0;
  late int selectedRadioTile = 0;
  late int selectedRadio = 0;

  late bool _isLoading;
  late Member user = widget.member;

  @override
  void initState() {
    _isLoading = false;
    user.shift = "";
    selectedRadio = 0;
    selectedRadioTile = 0;
    // TODO: implement initState

    super.initState();
  }

  final userDao = UserDao();

  final GlobalKey<FormState> userRegistrationFrmKey = GlobalKey<FormState>();

  void _pickedImageTest(File file) {
    this.user.profileImage = file;
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Colors.grey[300],
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  setSelectedRadioTile(var val) {
    setState(() {
      selectedRadioTile = val;
      user.shift = val.toString();
    });
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        user.joiningDate = formatter.format(picked);
      });
    }
  }

  updateUser(Member user) async {
    print("Updating object to the data base");
    await userDao.updateUser(user);
    stdout.writeln("User updated successfully ");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Member "),
        leading: MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back_ios, color: Colors.white)),
        backgroundColor: Colors.purple,
      ),
      body: Background(
        key: userRegistrationFrmKey,
        child: _isLoading
            ? ListView.separated(
                itemCount: 5,
                itemBuilder: (context, index) => const NewsCardSkelton(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: defaultPadding),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RoundedInputField(
                      key: const Key("username"),
                      hintText: widget.member.fullName,
                      onChanged: (value) {
                        user.fullName = value;
                      },
                    ),
                    RoundedInputField(
                      key: const Key("mobile"),
                      hintText: widget.member.mobileNumber,
                      icon: Icons.phone,
                      onChanged: (value) {
                        this.user.mobileNumber = value;
                      },
                    ),
                    RoundedInputField(
                      key: const Key("fees"),
                      hintText: widget.member.fees,
                      icon: Icons.account_balance_wallet,
                      onChanged: (value) {
                        this.user.fees = value;
                      },
                    ),
                    RoundedInputField(
                      key: const Key("address"),
                      hintText: widget.member.address,
                      icon: Icons.account_box_sharp,
                      onChanged: (value) {
                        user.address = value;
                      },
                    ),
                    Text(
                      'Shift',
                      style: TextStyle(),
                    ),
                    RadioListTile(
                        value: 1,
                        groupValue: selectedRadioTile,
                        title: Text("Full Time"),
                        subtitle: Text("7 AM to 10 PM"),
                        onChanged: (val) {
                          print("Radio Tile pressed $val");
                          setSelectedRadioTile(val);
                        },
                        activeColor: Colors.red,
                        selected: true),
                    RadioListTile(
                      value: 2,
                      groupValue: selectedRadioTile,
                      title: Text("Morning"),
                      subtitle: Text("7 AM to 2 PM"),
                      onChanged: (val) {
                        print("Radio Tile pressed $val");
                        setSelectedRadioTile(val);
                      },
                      activeColor: Colors.red,
                    ),
                    RadioListTile(
                      value: 3,
                      groupValue: selectedRadioTile,
                      title: Text("Evening"),
                      subtitle: Text("2 PM to 10 PM"),
                      onChanged: (val) {
                        print("Radio Tile pressed $val");
                        setSelectedRadioTile(val);
                      },
                      activeColor: Colors.red,
                    ),
                    ElevatedButton(
                      style: raisedButtonStyle,
                      child: Container(
                        child: this.user.joiningDate == null
                            ? Text('Joining Date')
                            : Text(this.user.joiningDate!),
                      ),
                      onPressed: () {
                        _selectDate(context);
                      },
                    ),
                    UserImagePicker(_pickedImageTest),
                    RoundedButton(
                      key: const Key("value11"),
                      text: "Add Member",
                      press: () async {
                        _isLoading = true;
                        print(this.user.toJson());
                        await updateUser(this.user);
                        _isLoading = false;
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                            (route) => false);
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                  ],
                ),
              ),
      ),
    );
  }
}
