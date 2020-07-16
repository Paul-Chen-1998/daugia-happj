import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessageDemo extends StatefulWidget {
  FirebaseMessageDemo() : super();

  final String title = "Firebase message demo";

  @override
  _FirebaseMessageDemoState createState() => _FirebaseMessageDemoState();
}

class _FirebaseMessageDemoState extends State<FirebaseMessageDemo> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  DatabaseReference itemRef;
  String text;
  _getToken() {
    _firebaseMessaging.getToken().then((deviceToken) {
      print("Device Token: $deviceToken");
      updateToken(deviceToken);
    });
  }

  updateToken(String token) {
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef = database.reference().child('fcm-token/${token}');
    itemRef.set({"token": token});
    setState(() {});
  }

  _configureFirebase() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print('onMessage: $message');
      _setMessage(message);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('onLaunch: $message');
      _setMessage(message);
    }, onResume: (Map<String, dynamic> message) async {
      print('onResume: $message');
      _setMessage(message);
    });
  }
  _setMessage(Map<String, dynamic> message) {
    final notification = message['notification'];
    final String body = notification['body'];
    print("body: " + body);
    setState(() {
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getToken();
    _configureFirebase();
    text = "Message: ";
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: new Text(text),
      ),
    );
  }
}
