import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../user.dart';
import 'dart:convert';

class UserDao {
  final DatabaseReference _userRef =
  FirebaseDatabase.instance.reference().child('user');

  Future<UserBean> saveUser(UserBean user)  async {

    print('Saving user image.');
    var userJson;
    try {
      await saveUserImage(user).then((value) => {
      print("sleeping for 2 second ${value}"),
          sleep(const Duration(seconds: 2)),
      user.profileImageURL = value,
      userJson= jsonEncode(user),
        print(userJson),
      FirebaseFirestore.instance
        .collection('uassist_user').add({"user": userJson}).then((value) => print("Added user ${userJson}"))
        .catchError((error) => print("Failed to add the user: $error")),
      });
      return user;
    }
    catch(stacktrace, e){
      print(e);
      print(stacktrace);
    }
    throw Exception("User is not saved");
    // FirebaseFirestore.instance
    //     .collection('uassist_user').snapshots()
    //     .listen((event) {
    //       print("event has occurred...........");
    //       print(event);
    //       print(event.docs[0]['address']);
    //     });

    // user_account.add(user).then((value) => print('User  account has been created $value'))
    // .catchError((error)=> print("Exception while adding user account $error "));
  }

  Future<String> saveUserImage(UserBean user) async {
    final fileName = user.fullName + user.mobileNumber + '.jpg';
    final ref =   FirebaseStorage.instance.ref().child('profile_image')
        .child(fileName);
      await ref.putFile(user.profileImage!);
      String imageURL = await ref.getDownloadURL();
    return imageURL;
  }

  Future<List<UserBean>> getUserDetails()async {
    print("Getting user details");
    List<UserBean>usersData = [];
    try{

      // Get docs from collection reference
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('uassist_user').get();
      // Get data from docs and convert map to List
      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      //for a specific field
      print("allData ${allData}");
      for(var user in allData){
        Type type = user.runtimeType;
        print(type.toString());
        Map<String, dynamic> data = jsonDecode(jsonEncode(user));
        print("json decode");
        print(data);
        UserBean userObj = UserBean.fromJson(json.decode(data["user"]));
        usersData.add(userObj);
      }
      return usersData;

    } catch( e, stacktrace){
      print("Exception while getting user details $e");
      print(stacktrace);
    }

    return usersData;

  }

}
