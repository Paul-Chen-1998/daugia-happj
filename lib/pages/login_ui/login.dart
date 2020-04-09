import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterhappjapp/api/server.dart';
import 'package:flutterhappjapp/main.dart';
import 'package:flutterhappjapp/pages/page_main/page_main_product.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'bloc/login_bloc.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;

  TextEditingController _controllerUser ;
  TextEditingController _controllerPassword ;
  bool _showPassWord = true;
  LoginBloc _loginBloc = new LoginBloc();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Log in", style: new TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: new IconButton(
            icon: new Icon(
              CommunityMaterialIcons.arrow_left,
              color: Colors.black,
              size: 35.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.white,
      ),
      body: new Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        child: _isLoading
            ? new Center(
                child: CircularProgressIndicator(),
              )
            : new Column(
                children: <Widget>[
//                  StreamBuilder<Object>(
//                      stream: _loginBloc.userStream,
//                      builder: (context, snapshot) {
//                        return
                  new TextField(

                    controller: _controllerUser,
                    autocorrect: false,
                    style: new TextStyle(fontSize: 18.0, color: Colors.black),
                    decoration: InputDecoration(
//                            errorText:
//                                snapshot.hasError ? snapshot.error : null,
                      labelText: 'Username or Email address',
                      labelStyle:
                          TextStyle(color: Color(0xff888888), fontSize: 15),
                    ),
                  ),
//                      }),
                  new Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: <Widget>[
//                      StreamBuilder<Object>(
//                          stream: _loginBloc.passStream,
//                          builder: (context, snapshot) {
//                            return
                      new TextField(
                        controller: _controllerPassword,
                        obscureText: _showPassWord,
                        autocorrect: false,
                        style:
                            new TextStyle(fontSize: 18.0, color: Colors.black),
                        decoration: InputDecoration(
//                                errorText:
//                                    snapshot.hasError ? snapshot.error : null,
                          labelText: 'Password',
                          labelStyle:
                              TextStyle(color: Color(0xff888888), fontSize: 15),
                        ),
                      ),
//                          }),
                      new GestureDetector(
                        onTap: _onToggleShowPassword,
                        child: new Text(
                          _showPassWord ? 'SHOW' : 'HIDE',
                          style: new TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  new SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: new SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: new RaisedButton(
                        color: Colors.green[600],
                        onPressed: _onClickLogIn,
                        child: new Text(
                          "Log in",
                          style: new TextStyle(
                              color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                  new SizedBox(
                    height: 10,
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: new Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          height: 50.0,
                          child: FlatButton(
                            color: Colors.red.shade900,
                            onPressed: () {

                            },
                            child: new Text("Sign in / Sign up with google",
                                style: new TextStyle(
                                    color: Colors.white, fontSize: 20.0)),
                          ),
                        ),
                        new SizedBox(
                          width: double.infinity,
                          height: 50.0,
                          child: Visibility(
                            visible: _isLoading ?? true,
                            child: Container(
                              color: Colors.white.withOpacity(0.7),
                              child: new CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.red),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  new SizedBox(
                    height: 15.0,
                  ),
                  new GestureDetector(
                    onTap: _onToggleForgotPassword,
                    child: new Text(
                      'Forgot Password?',
                      style: new TextStyle(
                          color: Colors.green[600],
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  signIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'email': email,
      'passWord': pass,
    };
    var jsonResponse = null;

    var respone = await http.post(Server.signin, body: data);

    if (respone.statusCode == 200) {
      jsonResponse = json.decode(respone.body);
      print('Response status: ${respone.statusCode}');
      print('Response body: ${respone.body}');

      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("token", jsonResponse['token']);
        sharedPreferences.setString("_id", jsonResponse['id']);
        sharedPreferences.setString("name", jsonResponse['name']);
        sharedPreferences.setString("email", jsonResponse['email']);
        TrangThai.dangNhap = true;
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => Main()),
            (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(respone.body);
    }
  }

  void _onToggleForgotPassword() {}

  void _onClickLogIn() {
//      if (_loginBloc.isValidInfo(
//          _controllerUser.text, _controllerPassword.text)) {
//
//      }
//      else{
//        print('khong hop le');
//      }
    setState(() {
      _isLoading = true;
    });
    signIn(_controllerUser.text, _controllerPassword.text);
  }

  void _onToggleShowPassword() {
    setState(() {
      _showPassWord = !_showPassWord;
    });
  }
}
