import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../user.dart';
import 'dart:convert';

class UserDao {
  final DatabaseReference _userRef =
  FirebaseDatabase.instance.reference().child('user');

  Future<void> saveUser(User user) async {

    print('Saving user image.');
    final ref = FirebaseStorage.instance.ref().child('profile_image').child(user
        .fullName+user.mobileNumber+'.jpg');
    ref.putFile(user.profileImage!);
    final profileImageURL = await ref.getDownloadURL();
    user.profileImageURL = profileImageURL;
    var userJson = jsonEncode(user);
    FirebaseFirestore.instance
         .collection('uassist_user').add({"user":userJson});
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

  Future<void> getUserDetails()async {
    print("Getting user details");
    
    final ref = FirebaseStorage.instance.ref();
    final data = await ref.child('uassist_user').getData();
    if(null != data){
      print("Printing data");
      print(data);
    }else{
      print("Data is not found");
    }


  }

}
