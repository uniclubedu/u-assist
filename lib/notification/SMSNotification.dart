import 'package:flutter_sms/flutter_sms.dart';

class SMSNotification{

  void sending_SMS(String msg, List<String> receipents) async {
    print("Sending sms ${msg} to ${receipents} ");
    String send_result = await sendSMS(message: msg, recipients: receipents, sendDirect: true)
        .catchError((err) {
      print(err);
    });
    print(send_result);
  }
}