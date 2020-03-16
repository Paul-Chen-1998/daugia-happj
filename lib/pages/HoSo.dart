import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_ui/bloc/login_bloc.dart';

class PageHoSo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: BodyHoSo()),
    );
  }
}

class BodyHoSo extends StatefulWidget {
  @override
  _BodyHoSoState createState() => _BodyHoSoState();
}

class _BodyHoSoState extends State<BodyHoSo> {
  TextEditingController _controllerUser = new TextEditingController();
  TextEditingController _controllerPassword = new TextEditingController();
  LoginBloc _loginBloc = new LoginBloc();
  bool _showPassWord = true;

  @override
  Widget build(BuildContext context) {
    Widget _dangNhap = new Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: <Widget>[
          new Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20),
                child: new Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              new SizedBox(
                height: 75,
              ),

              //text field, login, forgot password
              new Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: <Widget>[
                    StreamBuilder<Object>(
                        stream: _loginBloc.userStream,
                        builder: (context, snapshot) {
                          return new TextField(
                            autocorrect: false,
                            controller: _controllerUser,
                            decoration: InputDecoration(
                                errorText:
                                    snapshot.hasError ? snapshot.error : null,
                                border: OutlineInputBorder(),
                                hintText: 'Username or email address'),
                          );
                        }),
                    new SizedBox(
                      height: 10,
                    ),
                    Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: <Widget>[
                        StreamBuilder<Object>(
                            stream: _loginBloc.passStream,
                            builder: (context, snapshot) {
                              return new TextField(
                                autocorrect: false,
                                obscureText: _showPassWord,
                                controller: _controllerPassword,
                                decoration: InputDecoration(
                                    errorText: snapshot.hasError
                                        ? snapshot.error
                                        : null,
                                    border: OutlineInputBorder(),
                                    hintText: 'Password'),
                              );
                            }),
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: new GestureDetector(
                            onTap: _onToggleShowPassword,
                            child: new Text(
                              _showPassWord ? 'SHOW' : 'HIDE',
                              style: new TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                    new SizedBox(
                      height: 20,
                    ),
                    new SizedBox(
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
                    new SizedBox(
                      height: 15.0,
                    ),
                    new GestureDetector(
                      onTap: () {},
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
              )
            ],
          ),
        ],
      ),
    );
    return _dangNhap;
  }

  void _onClickLogIn() {
    setState(() {
      if (_loginBloc.isValidInfo(
          _controllerUser.text, _controllerPassword.text)) {
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
