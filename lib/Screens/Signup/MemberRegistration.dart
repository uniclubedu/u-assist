// ignore: file_names
import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:u_assist/Screens/Register/dao/user_dao.dart';
import 'package:u_assist/Screens/Register/member.dart';
import 'package:u_assist/Screens/Signup/components/background.dart';
import 'package:u_assist/Screens/Signup/components/user_image_picker.dart';
import 'package:u_assist/components/rounded_input_field.dart';
import 'package:u_assist/notification/SMSNotification.dart';
import 'package:u_assist/util/Constant.dart';
import 'package:u_assist/util/SMSNotificationTemplate.dart';

import '../../components/text_field_container.dart';
import '../../constants.dart';
import '../Util/NewsCardSkelton.dart';
import '../Welcome/home.dart';

class MemberRegistration extends StatefulWidget {
  //StreamController <UserBean>streamController;
  //UserRegistration(this.streamController);
  @override
  _MemberRegistrationState createState() => _MemberRegistrationState();
}

class _MemberRegistrationState extends State<MemberRegistration> {
  late String name;
  late String contactNumber;
  late String emailId;
  late String address;
  late String date;
  late File _userImageFile;
  late int shiftValue = 0;
  late int selectedShift = 0;
  late int selectedRadio = 0;
  late int selectedMembership = 0;

  late bool _isLoading;
  late Member user =
      Member(fullName: '', mobileNumber: '', address: '', profileImageURL: '');
  final GlobalKey<FormState> _registerMemberFormKey = GlobalKey<FormState>();
  static final RegExp nameRegExp = RegExp('[a-zA-Z]');

  String? get _errorText {
    final userName = _feesController.value.text;
    if (userName.isEmpty) return 'Can\'t be empty';
    if (userName.length < 3) {
      return 'Too short';
    }
    return null;
  }

  @override
  void initState() {
    _isLoading = false;
    user.shift = "";
    selectedRadio = 0;
    selectedShift = 0;
    // TODO: implement initState
    super.initState();
  }

  TextEditingController _feesController = TextEditingController();

  @override
  void dispose() {
    _feesController.dispose();
    super.dispose();
  }

  final userDao = UserDao();

  final GlobalKey<FormState> userRegistrationFrmKey = GlobalKey<FormState>();

  void _pickedImageTest(File file) {
    this.user.profileImage = file;
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    minimumSize: Size(88, 36),
    primary: Colors.purple,
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  setSelectedRadioTile(var val) {
    setState(() {
      selectedShift = val;
      user.shift = val.toString();
    });
  }

  DateTime selectedDate = DateTime.now();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  Future<void> _selectDate(
      BuildContext context, bool isStartDate, bool isEndDate) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        if (isStartDate) {
          user.membershipStartDate = formatter.format(picked);
          if(user.membership == "100"){
            user.membershipEndDate = formatter.format(DateTime(picked.year, picked.month+1, picked.day));
          }else if(user.membership == "101"){
            user.membershipEndDate = formatter.format(DateTime(picked.year, picked.month+3, picked.day));
          }
        } else if (isEndDate) {
          user.membershipEndDate = formatter.format(picked);
        }
      });
    }
  }

  registerUser(Member user) async {
    print("Saving object to the data base");
    Member userObj = Member(
        fullName: user.fullName,
        mobileNumber: user.mobileNumber,
        address: user.address,
        profileImage: user.profileImage,
        profileImageURL: '',
        fees: user.fees,
        shift: user.shift,
        membershipStartDate: user.membershipStartDate,
        membershipEndDate: user.membershipEndDate,
        joiningDate: this.user.joiningDate,
        memberId: '');
    await userDao.saveUser(userObj);
    if (user.mobileNumber != null && !user.mobileNumber.isEmpty) {
      var smsNotification = SMSNotification();
      SMSNotificationTemplate smsTemplate = SMSNotificationTemplate();
      smsTemplate.message = Constant.REGISTRATION_MESSAGE1;
      smsTemplate.recipents.add(user.mobileNumber);
      smsNotification.sending_SMS(smsTemplate.message, smsTemplate.recipents);
    }
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
                child: Form(
                  key: _registerMemberFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //     TextFieldContainer(
                      //         key: Key("name"),
                      // child: TextFormField(
                      //   controller: _userNameController,
                      //       validator: (name){
                      //     print("validation name ${name}");
                      //       if(user.fullName == null ||user.fullName.length <3){
                      //         return "Enter a valid user name";
                      //       }else{
                      //         return null;
                      //       }
                      //       },
                      //       decoration: const InputDecoration(
                      //         prefixIcon: Icon(Icons.person),
                      //           labelText: 'Name',
                      //         errorText: "Enter you name",
                      //       ),
                      //       keyboardType: TextInputType.text,
                      //
                      //       //validator: validateName,
                      //     onChanged: (value) {
                      //       user.fullName = value;
                      //     },
                      //     )
                      //     ),

                      TextFieldContainer(
                        key: Key("Full Name"),
                        child: TextFormField(
                          validator: (name) => name!.isEmpty
                              ? 'Enter Your Name'
                              : (nameRegExp.hasMatch(name)
                                  ? null
                                  : 'Enter a Valid Name'),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: kPrimaryColor,
                            ),
                            labelText: 'Full Name',
                            //errorText: "Enter valid fees",
                            border: InputBorder.none,
                          ),

                          keyboardType: TextInputType.text,
                          //validator: validateName,
                          onChanged: (value) {
                            user.fullName = value;
                            setState(() {});
                          },
                        ),
                      ),

                      TextFieldContainer(
                          key: Key("Mobile Number"),
                          child: TextFormField(
                            validator: (value) {
                              print(
                                  "user mobile number =============${user.mobileNumber}");
                              String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                              RegExp regExp = new RegExp(patttern);
                              if (value!.length == 0) {
                                return 'Please enter mobile number';
                              } else if (!regExp.hasMatch(value)) {
                                return 'Please enter valid mobile number';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.currency_rupee,
                                color: kPrimaryColor,
                              ),
                              labelText: 'Mobile Number',
                              //errorText: "Enter valid fees",
                              border: InputBorder.none,
                            ),

                            keyboardType: TextInputType.text,
                            //validator: validateName,
                            onChanged: (value) {
                              user.mobileNumber = value;
                              setState(() {});
                            },
                          )),

                      TextFieldContainer(
                          key: Key("Fees"),
                          child: TextFormField(
                            controller: _feesController,
                            validator: (name) {
                              print("user feesss =============${user.fees}");
                              if (user.fees == null ||
                                  user.fees.length <= 0 ||
                                  int.parse(user.fees, onError: (val) => 0) <=
                                      0) {
                                return "Fees should be numeric and greater then 0.";
                              } else if (user.fees.length > 10) {
                                return "Fees value should be less then 99999999.";
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.currency_rupee,
                                color: kPrimaryColor,
                              ),
                              labelText: 'Fees',
                              //errorText: "Enter valid fees",
                              border: InputBorder.none,
                            ),

                            keyboardType: TextInputType.text,
                            //validator: validateName,
                            onChanged: (value) {
                              user.fees = value;
                              setState(() {});
                            },
                          )),
                      RoundedInputField(
                        key: const Key("address"),
                        hintText: "Full Address",
                        icon: Icons.account_box_sharp,
                        onChanged: (value) {
                          user.address = value;
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 250, 0),
                        child: Text('SHIFT',
                            style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Roboto',
                              letterSpacing: 0.5,
                              fontSize: 20,
                            )),
                      ),
                      RadioListTile(
                          value: 1,
                          groupValue: selectedShift,
                          title: Text("Full Time"),
                          onChanged: (val) {
                            print("Radio Tile pressed $val");
                            setSelectedRadioTile(val);
                          },
                          activeColor: Colors.red,
                          selected: true),
                      RadioListTile(
                        value: 2,
                        groupValue: selectedShift,
                        title: Text("Morning"),
                        onChanged: (val) {
                          print("Radio Tile pressed $val");
                          setSelectedRadioTile(val);
                        },
                        activeColor: Colors.red,
                      ),
                      RadioListTile(
                        value: 3,
                        groupValue: selectedShift,
                        title: Text("Evening"),
                        onChanged: (val) {
                          print("Radio Tile pressed $val");
                          setSelectedRadioTile(val);
                        },
                        activeColor: Colors.red,
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 200, 0),
                        child: Text('MEMBERSHIP',
                            style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Roboto',
                              letterSpacing: 0.5,
                              fontSize: 20,
                            )),
                      ),
                      RadioListTile(
                          value: 100,
                          groupValue: selectedMembership,
                          title: Text("Monthly"),
                          onChanged: (membership) {
                            user.membershipStartDate = formatter.format(DateTime.now());
                            user.membershipEndDate = formatter.format(DateTime(DateTime.now().year, DateTime.now().month+1, DateTime.now().day));
                            print("membership selected ${membership}");
                            setMembership(membership);
                          }),
                      RadioListTile(
                          value: 101,
                          groupValue: selectedMembership,
                          title: Text("Quarterly"),
                          onChanged: (membership) {
                            print("membership selected ${membership}");
                            user.membershipStartDate = formatter.format(DateTime.now());
                            user.membershipEndDate = formatter.format(DateTime(DateTime.now().year, DateTime.now().month+3, DateTime.now().day));
                            setMembership(membership);
                          }),
                      ElevatedButton(
                        style: raisedButtonStyle,
                        child: Container(
                          child: this.user.membershipStartDate == null
                              ? Text('Membership Start Date')
                              : Text(this.user.membershipStartDate!),
                        ),
                        onPressed: () {
                          _selectDate(context, true, false);
                        },
                      ),
                      ElevatedButton(
                        style: raisedButtonStyle,
                        child: Container(
                          child: this.user.membershipEndDate == null
                              ? Text('Membership End Date')
                              : Text(this.user.membershipEndDate!),
                        ),
                        onPressed: () {
                          _selectDate(context, false, true);
                        },
                      ),
                      UserImagePicker(_pickedImageTest),
                      if ((null != user.fullName && !user.fullName.isEmpty) &&
                          (null != user.mobileNumber &&
                              !user.mobileNumber.isEmpty) &&
                          (null != user.fees &&
                              !user.fees.toString().isEmpty &&
                              int.parse(user.fees, onError: (val) => 0) > 0))
                        ElevatedButton(
                            key: const Key("value88"),
                            child: Text("Add Member"),
                            onPressed: () async {
                              final FormState? form =
                                  _registerMemberFormKey.currentState;
                              if (form!.validate()) {
                                print("Form is valid");
                                _isLoading = true;
                                print(this.user.toJson());
                                await registerUser(this.user);
                                _isLoading = false;
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()),
                                    (route) => false);
                              } else {
                                print("Invalid registration form");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 20),
                                textStyle: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)))
                      else
                        ElevatedButton(
                            key: const Key("value11"),
                            child: Text("Add Member "),
                            onPressed: null,
                            style: ElevatedButton.styleFrom(
                                primary: Colors.purple,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 20),
                                textStyle: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold))),
                      SizedBox(height: size.height * 0.03),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void setMembership(var membership) {
    setState(() {
      selectedMembership = membership;
      selectedMembership = membership;
      user.membership = membership.toString();
    });
  }
}
