
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
//part 'user.g.dart';
@JsonSerializable()
class UserBean{
  final String fullName;
  final String mobileNumber;
  final String address;
  final File ?profileImage;
  String profileImageURL;

  UserBean({required this.fullName,required this.mobileNumber,required this
      .address, this.profileImage, required this.profileImageURL});

  factory UserBean.fromJson(Map<String, dynamic> json) {
    return UserBean(fullName: json['fullName'] as String,
      mobileNumber: json['mobileNubmer'] as String,
      address: json['address'] as String,
      profileImageURL: json['profileImageURL'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'mobileNumber': mobileNumber,
      'address':address,
      'profileImageURL':profileImageURL,
    };
  }
}