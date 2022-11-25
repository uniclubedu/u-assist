import 'package:flutter/cupertino.dart';
import 'package:flutter_sms/flutter_sms.dart';

class SMSNotification{

  void sending_SMS(String msg, List<String> receipents) async {
    debugPrint("Sending sms ${msg} to ${receipents} ");
    String send_result = await sendSMS(message: msg, recipients: receipents, sendDirect: true)
        .catchError((err) {
      debugPrint(err);
    });
    debugPrint(send_result);
  }
}