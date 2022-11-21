import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

//part 'user.g.dart';
@JsonSerializable()
class Member {
  String uid;
  String memberId;
  String fullName;
  String mobileNumber;
  String address;
  File? profileImage;
  String profileImageURL;
  var fees;
  var shift;
  String? joiningDate;
  String? membershipStartDate;
  String? membershipEndDate;
  var amountPaid;
  var membership;

  Member(
      {
        this.uid="",
        this.memberId = "",
      required this.fullName,
      required this.mobileNumber,
      required this.address,
      this.profileImage,
      required this.profileImageURL,
      this.fees,
      this.shift,
      this.joiningDate,
      this.membershipStartDate,
      this.membershipEndDate,
      this.membership,
      this.amountPaid});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
        uid: json['uid'] as String,
        memberId: json['userId'] as String,
        fullName: json['fullName'] as String,
        mobileNumber: json['mobileNumber'] as String,
        address: json['address'] as String,
        fees: json['fees'] as String,
        shift: json['shift'] as String,
        membership: json['membership'] as String,
        joiningDate: json['joiningDate'] as String,
        membershipStartDate: json['membershipStartDate'] as String,
        membershipEndDate: json['membershipEndDate'] as String,
        profileImageURL: json['profileImageURL'] as String,
        amountPaid: json['amountPaid'] as double);
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'userId': memberId,
      'fullName': fullName,
      'mobileNumber': mobileNumber,
      'address': address,
      'shift': shift,
      'fees': fees,
      'membership': membership,
      'joiningDate': joiningDate,
      'membershipStartDate': membershipStartDate,
      'membershipEndDate': membershipEndDate,
      'profileImageURL': profileImageURL,
      'amountPaid': amountPaid,
    };
  }
}
