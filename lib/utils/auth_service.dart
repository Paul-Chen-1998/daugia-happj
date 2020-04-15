import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
        (FirebaseUser user) => user?.uid,
      );

  //email password signup
  Future<String> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    var userUpdate = UserUpdateInfo();
    userUpdate.displayName = name;
    await currentUser.updateProfile(userUpdate);
    await currentUser.reload();
    return currentUser.uid;
  }

  //email password signin
  Future<String> signInWithEmailandPassword(
      String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .uid;
  }

  //sign out
  signOut() {
    return _firebaseAuth.signOut();
  }
}
