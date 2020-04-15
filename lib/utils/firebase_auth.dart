//import 'package:firebase_auth/firebase_auth.dart';
//
//abstract class AuthFunc {
//  Future<String> signIn(String email, String passWord);
//
//  Future<String> signUp(String email, String passWord);
//
//  Future<FirebaseUser> getCurrentUser();
//
//  Future<void> sendEmailVerification();
//
//  Future<void> signOut();
//
//  Future<bool> isEmailVerified();
//}
//
//class MyAuth implements AuthFunc{
//  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//
//
//  @override
//  Future<FirebaseUser> getCurrentUser() async{
//    return await _firebaseAuth.currentUser();
//  }
//
//  @override
//  Future<void> sendEmailVerification()  async{
//    var user = await _firebaseAuth.currentUser();
//    user.sendEmailVerification();
//  }
//
//  @override
//  Future<String> signIn(String email, String passWord)async {
//    var user = (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: passWord)).user;
//    return user.uid;
//  }
//
//  @override
//  Future<void> signOut() {
//    return _firebaseAuth.signOut();
//  }
//
//  @override
//  Future<String> signUp(String email, String passWord) async{
//    var user = (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: passWord)).user;
//    return user.uid;
//  }
//
//  @override
//  Future<bool> isEmailVerified() async{
//    var user = await _firebaseAuth.currentUser();
//    return user.isEmailVerified;
//  }
//}
