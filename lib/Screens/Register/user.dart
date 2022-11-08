import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

//part 'user.g.dart';
@JsonSerializable()
class Member {
  late final String fullName;
  late final String mobileNumber;
  late final String address;
  late final File? profileImage;
  String profileImageURL;
  var fees;
  var shift;
  String? joiningDate;

  Member(
      {required this.fullName,
      required this.mobileNumber,
      required this.address,
      this.profileImage,
      required this.profileImageURL,
      this.fees,
      this.shift,
      this.joiningDate});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      fullName: json['fullName'] as String,
      mobileNumber: json['mobileNubmer'] as String,
      address: json['address'] as String,
      fees: json['fees'] as String,
      shift: json['shift'] as String,
      joiningDate: json['joiningDate'] as String,
      profileImageURL: json['profileImageURL'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ' fullName':  fullName,
      'mobileNumber': mobileNumber,
      'address': address,
      'shift': shift,
      'fees': fees,
      'joiningDate': joiningDate,
      'profileImageURL': profileImageURL,
    };
  }
}
