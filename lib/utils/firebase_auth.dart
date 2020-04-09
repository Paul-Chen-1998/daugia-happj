import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signInWithEmail(String email, String passWord) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: passWord);
      FirebaseUser user = result.user;
      if (user != null) return true;
      return false;
    } catch (e) {
      return false;
    }
  }
}
