
import 'package:firebase_auth/firebase_auth.dart';

import '../exception/CustomException.dart';

class AuthDAO {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String?> getUID() async{
    final User? user = auth.currentUser;
    if(null == user){
      print("User not logged in");
      throwException() {
        throw CustomException('User not logged in');
      }
    }else{
      return user.uid;
    }
    return null;
  }
}