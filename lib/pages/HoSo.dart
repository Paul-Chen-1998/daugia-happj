import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'login_ui/bloc/login_bloc.dart';

class PageHoSo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(body: BodyHoSo()),
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
                margin: EdgeInsets.only(top: 100),
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
    return new Container(
        padding: EdgeInsets.all(0.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: new ListView(
          padding: EdgeInsets.all(0.0),
          children: <Widget>[
            //background
            new Container(
              height: 300,
              child: new Image.asset(
                'images/hoso/backgroundhoso.jpg',
                fit: BoxFit.cover,
              ),
            ),
            //avatar, name
            new Container(
              height: 80,
              color: Colors.white,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(50.0)),
                      border: new Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    margin: EdgeInsets.only(left: 8, top: 5),
                    width: 80,
                    height: 80,
                    child: new CircleAvatar(
                      radius: 2,
                      backgroundImage: AssetImage('images/hoso/user.jpg'),
                    ),
                  ),
                  Expanded(
                    child: new ListTile(
                      onTap: () {},
                      title: new Text(
                        'Thế Vinh',
                        style: new TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w700),
                      ),
                      subtitle: new Text('the.vinh12121',
                          style: new TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700)),
                    ),
                  )
                ],
              ),
            ),
            new Divider(
              indent: 30,
              endIndent: 30,
              color: Colors.black,
              thickness: 1,
            ),
            //choose
            new Container(
              child: new Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      new CustomListTile('Tài khoản', 'images/hoso/user.png',
                          35.0, 35.0, () {}),
                      new Divider(
                        indent: 0,
                        endIndent: 0,
                        color: Colors.black,
                        thickness: 0.5,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      new CustomListTile('Địa chỉ giao hàng',
                          'images/hoso/delivery.png', 35.0, 35.0, () {}),
                      new Divider(
                        indent: 0,
                        endIndent: 0,
                        color: Colors.black,
                        thickness: 0.5,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      new CustomListTile('Hỗ trợ khách hàng',
                          'images/hoso/question.png', 35.0, 35.0, () {}),
                      new Divider(
                        indent: 0,
                        endIndent: 0,
                        color: Colors.black,
                        thickness: 0.5,
                      ),
                    ],
                  ),
                  //images/hoso/quyenungdung.png
                  Column(
                    children: <Widget>[
                      new CustomListTile('Quyền khách hàng',
                          'images/hoso/quyenungdung.png', 35.0, 35.0, () {}),
                      new Divider(
                        indent: 0,
                        endIndent: 0,
                        color: Colors.black,
                        thickness: 0.5,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      new CustomListTile('Trợ giúp', 'images/hoso/trogiup.png',
                          35.0, 35.0, () {}),
                      new Divider(
                        indent: 0,
                        endIndent: 0,
                        color: Colors.black,
                        thickness: 0.5,
                      ),
                    ],
                  ),
                  //
                  Column(
                    children: <Widget>[
                      new CustomListTile('Về ứng dụng', 'images/hoso/law.png',
                          35.0, 35.0, () {}),
                      new Divider(
                        indent: 0,
                        endIndent: 0,
                        color: Colors.black,
                        thickness: 0.5,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      new Container(
                        padding: EdgeInsets.all(0.0),
                        child: new Material(
                          child: new InkWell(
                            splashColor: Colors.green,
                            onTap: () {},
                            child: ListTile(
                              title: Text(
                                'Đăng xuất',
                                style: new TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600),
                              ),
                              leading: new Image.asset('images/hoso/lock.png',
                                  fit: BoxFit.cover, width: 35, height: 35),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 90,
                  )
                ],
              ),
            ),
          ],
        ));
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
