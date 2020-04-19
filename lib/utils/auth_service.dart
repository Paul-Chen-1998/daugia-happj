import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterhappjapp/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  SharedPreferences sharedPreferences;

  Stream<String> get onAuthStateChanged =>
      _firebaseAuth.onAuthStateChanged.map(
            (FirebaseUser user) => user?.uid,
      );

  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  // GET CURRENT USER
  Future getCurrentUser() async {
    return await _firebaseAuth.currentUser();
  }

  //email password signup
  Future<String> createUserWithEmailAndPassword(String email, String password,
      String name) async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    await updateUserName(name, currentUser);
    return currentUser.uid;
  }

  Future updateUserName(String name, FirebaseUser currentUser) async {
       var userUpdate = UserUpdateInfo();
    userUpdate.displayName = name;
    await currentUser.updateProfile(userUpdate);
    await currentUser.reload();
  }

  //email password signin
  Future<String> signInWithEmailandPassword(String email,
      String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password))
        .uid;
  }

  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future signInAnonumously() async{
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("anonymous", "signInAnonymously");
    return _firebaseAuth.signInAnonymously();
  }

  Future<String> signInWithGoogle() async {
    try {
      final GoogleSignInAccount account = await _googleSignIn.signIn();
      final GoogleSignInAuthentication _googleAuth = await account
          .authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);
      var a = (await _firebaseAuth.signInWithCredential(credential)).uid;
      print(a);
      return a;
    } catch (e) {
      print("loi dang nhap = gg");
      print(e);
    }
    return null;
  }

  Future convertWithGoogle()async{
    try {
      final currentUser = await _firebaseAuth.currentUser();
      final GoogleSignInAccount account = await _googleSignIn.signIn();
      final GoogleSignInAuthentication _googleAuth = await account
          .authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);

      await currentUser.linkWithCredential(credential);
      await updateUserName(_googleSignIn.currentUser.displayName, currentUser);
    } catch (e) {
      print("loi covert dang nhap = gg");
      print(e);
    }
    return null;
  }


  Future converUserWithEmail(String email, String password, String name) async {
    final currentUser =  await _firebaseAuth.currentUser();
    final credential = EmailAuthProvider.getCredential(email: email,password: password);
    await currentUser.linkWithCredential(credential);
    await updateUserName(name, currentUser);


    return currentUser.uid;
  }

  //sign out
  signOut() {
    return _firebaseAuth.signOut();
  }
}

class NameValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Name can't be empty";
    }
    if (value.length < 2) {
      return "Name must be at least 2 characters long";
    }
    if (value.length > 50) {
      return "Name must be less than 50 characters long";
    }
    return null;
  }
}

class EmailValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Email can't be empty";
    }

    if (!isEmail(value)) {
      return "Email not match";
    }

    return null;
  }
}

bool isEmail(String em) {
  String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(p);

  return regExp.hasMatch(em);
}

class PasswordValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Password can't be empty";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters long";
    }

    return null;
  }
}

class PasswordConfirmValidator {
  String text;

  PasswordConfirmValidator({this.text});

  String validate(String value) {
    if (value.trim().toString().compareTo(text.trim().toString()) != 0) {
      return "Password must be the same";
    }
    if (value.isEmpty) {
      return "Password confirm can't be empty";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters long";
    }

    return null;
  }
}