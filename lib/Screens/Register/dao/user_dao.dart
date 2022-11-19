import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:u_assist/Payment/dao/payment_dao.dart';
import 'package:u_assist/util/Constant.dart';
import 'package:uuid/uuid.dart';

import '../member.dart';

class UserDao {
  final DatabaseReference _userRef =
      FirebaseDatabase.instance.reference().child('user');
  PaymentDAO paymentDAO = PaymentDAO();

  Future<Member> saveUser(Member user) async {
    print('Saving user image.');
    var uuid = Uuid();
    final String userId = uuid.v4();
    user.memberId = userId;
    var userJson;
    try {
      if(null == user.profileImage){
        saveMemberToDB(user, "", userJson);
      }else{
        await saveUserImage(user).then((value) => saveMemberToDB(user, value, userJson));
      }
      return user;
    } catch (stacktrace, e) {
      print(e);
      print(stacktrace);
    }
    throw Exception("User is not saved");
  }

  Set<void> saveMemberToDB(Member user, String value, userJson) {
    return {
          user.profileImageURL = value,
          //userJson = jsonEncode(user),
          print(user.toJson()),
          FirebaseFirestore.instance
              .collection(Constant.USER_COLLECTION_NAME)
              .add(user.toJson())
              .then((value) => print("Added "
                  "user ${userJson}"))
              .catchError((error) => print("Failed to add the user: $error")),
        };
  }

  Future<Set<void>> deleteUser(Member member) async {
    stdout.writeln("Delete user ${member.fullName}");
    await deleteUserImage(member.profileImageURL);
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
      print("Deleted successfully ")
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
            print(userJson),
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
      print(e);
      print(stacktrace);
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
    print("Getting user details");
    List<Member> usersData = [];
    try {
      // Get docs from collection reference
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('uassist_user').get();
      // Get data from docs and convert map to List
      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      //for a specific field
      print("allData h ${allData}");
      for (var user in allData) {
        Type type = user.runtimeType;

        Map<String, dynamic> data = jsonDecode(jsonEncode(user));
        print(data.toString());
        Member userObj = Member.fromJson(data);
        double paymentAmount=0;
        if(null != userObj.membershipStartDate && null != userObj.membershipEndDate ){
           await paymentDAO.getPaymentAmount(userObj.memberId, userObj.membershipStartDate!, userObj.membershipEndDate!).then(
                   (value) => {
                     print(value),
                     paymentAmount = value
                   }) ;
        }
        userObj.amountPaid = paymentAmount;
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
