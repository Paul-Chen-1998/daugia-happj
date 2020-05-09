import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterhappjapp/pages/login_ui/OTPpage_signup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  String phoneNo;
  String smsCode;
  String verificationId;
  String countryCode = "+84";
  SharedPreferences prf;

  Future<void> verifyNumber() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verID) {
      this.verificationId = verID;

      ///Dialog here
    };

    final PhoneCodeSent smsCodeSent = (String verID, [int forceCodeResend]) {
      this.verificationId = verID;
      smsCodeDialog(context);
    };

    final PhoneVerificationCompleted verificationSuccess =
        (AuthCredential credential) {
      print("Verified");
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException exception) {
      Fluttertoast.showToast(msg: "Số điện thoại không hợp lệ");
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.countryCode + this.phoneNo,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationSuccess,
        verificationFailed: verificationFailed);
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => OtpPageSignup());
//                    FirebaseAuth.instance.currentUser().then((user) {
//                      if (user != null) {
//                        Navigator.pop(context);
//                        Navigator.of(context).pushReplacementNamed('/home');
//                      } else {
//                        signIn();
//                      }
//                    });
  }

  signIn() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((user) async{
      prf =await SharedPreferences.getInstance();
      prf.setString("phone", phoneNo);
      print(phoneNo);
      TrangThai.phone = phoneNo;
      Navigator.of(context).pushNamedAndRemoveUntil('/signup',(Route<dynamic> route) => false);
      //Navigator.of(context).pushNamed('/signup');
      Fluttertoast.showToast(msg: "Hãy đăng ký");
    }).catchError((e) {
      Fluttertoast.showToast(
        msg: "Code không đúng xin nhập lại",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Authentication"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(

              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 50,
                    width: 50,
                    child: TextField(
                      enabled: false,
                      decoration:
                      InputDecoration(hintText: "+84"),
                    ),

                  ),
                  Expanded(
                    child: TextField(
                      decoration:
                          InputDecoration(hintText: "Enter phone number"),
                      onChanged: (value) {
                        this.phoneNo = value;
                      },
                    ),
                  )
                ],
              ),
            ),
            RaisedButton(
              color: Colors.teal,
              onPressed: verifyNumber,
              child: Text(
                "Lấy Mã OTP",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
