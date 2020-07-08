import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

import '../../main.dart';


class OtpPageReset extends StatefulWidget {
  final verificationId;
  final phoneNo;

  OtpPageReset({this.verificationId, this.phoneNo});

  @override
  _OtpPageResetState createState() => _OtpPageResetState();
}

class _OtpPageResetState extends State<OtpPageReset> {

  String smsCode = '';

  signIn() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: widget.verificationId,
      smsCode: smsCode,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((user) async{
      TrangThai.phone = widget.phoneNo;

      Navigator.of(context).pushNamedAndRemoveUntil('/reset',(Route<dynamic> route) => false);
      Fluttertoast.showToast(msg: "Hãy nhập lại mật khẩu");
      await FirebaseAuth.instance.signOut();
    }).catchError((e) {
      Fluttertoast.showToast(
        msg: "Code không đúng xin nhập lại",backgroundColor: Colors.black,textColor: Colors.white
      );
    });
  }

  void _onKeyboardTap(String value) {
    setState(() {
      smsCode = smsCode + value;
    });
  }

  Widget otpNumberWidget(int position) {
    try {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
        child: Center(child: Text(smsCode[position], style: TextStyle(color: Colors.black),)),
      );
    } catch (e) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: MyColors.primaryColorLight.withAlpha(20),
            ),
            child: Icon(Icons.arrow_back_ios, color: MyColors.primaryColor, size: 16,),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text('Enter 6 digits verification code sent to your number', style: TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.w500))
                        ),
                        Container(
                          constraints: const BoxConstraints(
                              maxWidth: 500
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              otpNumberWidget(0),
                              otpNumberWidget(1),
                              otpNumberWidget(2),
                              otpNumberWidget(3),
                              otpNumberWidget(4),
                              otpNumberWidget(5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    constraints: const BoxConstraints(
                        maxWidth: 500
                    ),
                    child: RaisedButton(
                      onPressed: () => signIn(),
                      color: MyColors.primaryColor,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14))
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Confirm', style: TextStyle(color: Colors.white),),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                color: MyColors.primaryColorLight,
                              ),
                              child: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16,),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  NumericKeyboard(
                    onKeyboardTap: _onKeyboardTap,
                    textColor: MyColors.primaryColorLight,
                    rightIcon: Icon(
                      Icons.backspace,
                      color: MyColors.primaryColorLight,
                    ),
                    rightButtonFn: () {
                      setState(() {
                        smsCode = smsCode.substring(0, smsCode.length - 1);
                      });
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyColors {
  static const Color primaryColor = Color(0xFF503E9D);
  static const Color primaryColorLight = Color(0xFF6252A7);
}