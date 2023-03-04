import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:u_assist/Payment/dao/payment_dao.dart';
import 'package:u_assist/auth/auth_dao.dart';
import 'package:u_assist/util/Constant.dart';
import 'package:uuid/uuid.dart';
import '../member.dart';

class UserDao {
  PaymentDAO paymentDAO = PaymentDAO();

  Future<Member> saveUser(Member user) async {
    debugPrint('Saving user image.');
    var uuid = Uuid();
    final String userId = uuid.v4();
    user.memberId = userId;
    await AuthDAO().getUID().then((value) => {user.uid =
    value==null?"":value},);
    var userJson = user.toJson();
    try {
      if(null == user.profileImage){
        saveMemberToDB(user, "", userJson);
      }else{
        await saveUserImage(user).then((value) => saveMemberToDB(user, value, userJson));
      }
      return user;
    } catch (stacktrace, e) {
      debugPrint(e as String?);
      debugPrint("Stacktrace : ${stacktrace}");
    }
    throw Exception("User is not saved");
  }

  Set<void> saveMemberToDB(Member user, String value, userJson) {
    return {
          user.profileImageURL = value,
          FirebaseFirestore.instance
              .collection(Constant.USER_COLLECTION_NAME)
              .add(user.toJson())
              .then((value) => debugPrint("Added "
                  "user ${userJson}"))
              .catchError((error) => debugPrint("Failed to add the user: $error")),
        };
  }

  Future<Set<void>> deleteUser(Member member) async {
    stdout.writeln("Delete user ${member.fullName}");
    if(null != member.profileImageURL && !member.profileImageURL.isEmpty){
      await deleteUserImage(member.profileImageURL);
    }
    var userSnap = await FirebaseFirestore.instance
        .collection(Constant.USER_COLLECTION_NAME)
        .where('userId', isEqualTo: member.memberId)
        .get();
    for (var doc in userSnap.docs) {
      return await doc.reference.delete().then((value) =>
      {
        stdout.write("user deleted successfully")
      }).catchError((error) =>{
        stderr.write("Error while deleting user "),
      });
    }
    throw Future(() => null);
  }

   Future<String> deleteUserImage(String url) async {
    stdout.write("Deleting file");
    await FirebaseStorage.instance.refFromURL(url).delete().then((value) =>
    {
      debugPrint("Deleted successfully ")
    }).catchError((error) =>{
      stderr.write("Failed to delete image file ${error}"),
    });
    return "Deleted";
  }

  Future<void>  updateUser(Member member) async {
    stdout.writeln("Update user ${member.fullName}");
    try {
      String userJson;
      QuerySnapshot<Map<String, dynamic>> userSnap;
      await saveUserImage(member).then((value) async => {
            member.profileImageURL = value,
            userJson = jsonEncode(member),
            debugPrint(userJson),
            userSnap = await FirebaseFirestore.instance
                .collection(Constant.USER_COLLECTION_NAME)
                .where('userId', isEqualTo: member.memberId)
                .get(),
            for (var doc in userSnap.docs)
              {
                await doc.reference.update(member.toJson())
              }
          });
    } catch (stacktrace, e) {
      debugPrint(e as String?);
      debugPrint("Stacktrace : ${stacktrace}");
    }
    stdout.writeln("User updated successfully");
    return Future<void>.value();
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
    debugPrint("Getting user details");
    List<Member> usersData = [];
    var uid;
    await AuthDAO().getUID().then(
          (value) => {uid = value!},
    );
    try {
      // Get docs from collection reference
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(Constant.USER_COLLECTION_NAME)
              .where("uid", isEqualTo: uid)
              .get();
      // Get data from docs and convert map to List
      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      //for a specific field
      debugPrint("allData h ${allData}");
      for (var user in allData) {
        Type type = user.runtimeType;

        Map<String, dynamic> data = jsonDecode(jsonEncode(user));
        debugPrint(data.toString());
        Member userObj = Member.fromJson(data);
        double paymentAmount=0;
        if(null != userObj.membershipStartDate && null != userObj.membershipEndDate ){
           await paymentDAO.getPaymentAmount(userObj.memberId, userObj.membershipStartDate!, userObj.membershipEndDate!).then(
                   (value) => {
                     paymentAmount = value
                   }) ;
        }
        userObj.amountPaid = paymentAmount;
        usersData.add(userObj);
      }
      return usersData;
    } catch (e, stacktrace) {
      debugPrint("Exception while getting user details $e");
      debugPrint("Stacktrace : ${stacktrace}");
    }

    return usersData;
  }
}
