import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';


import 'bloc/login_bloc.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controllerUser = new TextEditingController();
  TextEditingController _controllerPassword = new TextEditingController();
  bool _showPassWord = true;
  LoginBloc _loginBloc = new LoginBloc();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Center(
            child:
                new Text("Log in", style: new TextStyle(color: Colors.black))),
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
        child: new Column(
          children: <Widget>[
            StreamBuilder<Object>(
                stream: _loginBloc.userStream,
                builder: (context, snapshot) {
                  return new TextField(
                    controller: _controllerUser,
                    autocorrect: false,
                    style: new TextStyle(fontSize: 18.0, color: Colors.black),
                    decoration: InputDecoration(
                      errorText: snapshot.hasError
                          ? snapshot.error
                          : null,
                      labelText: 'Username or Email address',
                      labelStyle:
                          TextStyle(color: Color(0xff888888), fontSize: 15),
                    ),
                  );
                }),
            new Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: <Widget>[
                StreamBuilder<Object>(
                    stream: _loginBloc.passStream,
                    builder: (context, snapshot) {
                      return new TextField(
                        controller: _controllerPassword,
                        obscureText: _showPassWord,
                        autocorrect: false,
                        style:
                            new TextStyle(fontSize: 18.0, color: Colors.black),
                        decoration: InputDecoration(
                          errorText: snapshot.hasError
                              ? snapshot.error
                              : null,
                          labelText: 'Password',
                          labelStyle:
                              TextStyle(color: Color(0xff888888), fontSize: 15),
                        ),
                      );
                    }),
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
                    style: new TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
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

  void _onToggleForgotPassword() {}

  void _onClickLogIn() {
    setState(() {
      if(_loginBloc.isValidInfo(_controllerUser.text, _controllerPassword.text)){
        print('z');
      }
    });
  }

  void _onToggleShowPassword() {
    setState(() {
      _showPassWord = !_showPassWord;
    });
  }
}
