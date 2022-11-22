
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:u_assist/util/Constant.dart';

import '../../../auth/auth_dao.dart';

class ClientDAO{

  Future<bool> isAccountActivated() async {
    print("Calling is account activated for uid }");
    String? uid = "";
    await AuthDAO().getUID().then(
          (value) => {uid = value},
    );
    if(uid == "") {
      return false;
    }
    print("uid : ${uid}");
    bool isActivated = false;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(Constant.ACTIVE_CLIENTS)
        .where("uid", isEqualTo: uid)
        .where("status", isEqualTo: Constant.ACTIVE_STATUS)
        .get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print("allData ${allData}");
    if( null != allData && allData.length>0) {
      isActivated = true;
    }
    return isActivated;
  }
}