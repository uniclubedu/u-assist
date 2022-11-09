import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:u_assist/util/Constant.dart';
import 'package:uuid/uuid.dart';

import '../user.dart';

class UserDao {
  final DatabaseReference _userRef =
      FirebaseDatabase.instance.reference().child('user');

  Future<Member> saveUser(Member user) async {
    print('Saving user image.');
    var uuid = Uuid();
    final String userId = uuid.v4();
    user.userId = userId;
    var userJson;
    try {
      await saveUserImage(user).then((value) => {
            user.profileImageURL = value,
            userJson = jsonEncode(user),
            print(userJson),
            FirebaseFirestore.instance
                .collection(Constant.USER_COLLECTION_NAME)
                .add(userJson)
                .then((value) => print("Added "
                    "user ${userJson}"))
                .catchError((error) => print("Failed to add the user: $error")),
          });
      return user;
    } catch (stacktrace, e) {
      print(e);
      print(stacktrace);
    }
    throw Exception("User is not saved");
  }

  deleteUser(Member member) async {
    stdout.writeln("Delete user ${member.fullName}");
    var userSnap = await FirebaseFirestore.instance
        .collection(Constant.USER_COLLECTION_NAME)
        .where('userId', isEqualTo: member.userId)
        .get();
    for (var doc in userSnap.docs) {
      await doc.reference.delete();
    }
  }

  void updateUser(Member member) async {
    stdout.writeln("Update user ${member.fullName}");
    try {
      String userJson;
      QuerySnapshot<Map<String, dynamic>> userSnap;
      await saveUserImage(member).then((value) async => {
            member.profileImageURL = value,
            userJson = jsonEncode(member),
            print(userJson),
            userSnap = await FirebaseFirestore.instance
                .collection(Constant.USER_COLLECTION_NAME)
                .where('userId', isEqualTo: member.userId)
                .get(),
            for (var doc in userSnap.docs)
              {await doc.reference.update(member.toJson())}
          });
    } catch (stacktrace, e) {
      print(e);
      print(stacktrace);
    }
    stdout.writeln("User updated successfully");
  }

  Future<String> saveUserImage(Member user) async {
    final fileName = user.fullName + user.mobileNumber + '.jpg';
    final ref =
        FirebaseStorage.instance.ref().child('profile_image').child(fileName);
    await ref.putFile(user.profileImage!);
    String imageURL = await ref.getDownloadURL();
    return imageURL;
  }

  Future<List<Member>> getUserDetails() async {
    print("Getting user details");
    List<Member> usersData = [];
    try {
      // Get docs from collection reference
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('uassist_user').get();
      // Get data from docs and convert map to List
      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      //for a specific field
      print("allData ${allData}");
      for (var user in allData) {
        Type type = user.runtimeType;
        print(type.toString());
        Map<String, dynamic> data = jsonDecode(jsonEncode(user));
        Member userObj = Member.fromJson(json.decode(data["user"]));
        usersData.add(userObj);
      }
      return usersData;
    } catch (e, stacktrace) {
      print("Exception while getting user details $e");
      print(stacktrace);
    }

    return usersData;
  }
}
