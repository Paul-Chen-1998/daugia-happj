import 'dart:convert';
import 'package:flutterhappjapp/model/Product.dart';
import 'package:flutterhappjapp/model/User.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterhappjapp/api/server.dart';
import 'package:flutterhappjapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../HomePage.dart';
import 'DiaChi.dart';
import 'profile_user.dart';
import 'SanPhamCuaToi.dart';
import 'TroGiup.dart';
import 'VeUngDung.dart';
import 'add_product.dart';


// ignore: must_be_immutable
class HoSoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HoSo(),
    );
  }
}

class HoSo extends StatefulWidget {
  @override
  _HoSoState createState() => _HoSoState();
}

class _HoSoState extends State<HoSo> {
  bool _isLoading = false;
  User user;
  SharedPreferences sharedPreferences;
  Future<dynamic> checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("token");
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: checkLoginStatus(),
      // ignore: missing_return
      builder: (context, snapshot) {
        return Container(
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
                    FutureBuilder<dynamic>(
                      future: getInfo(),
                      // ignore: missing_return
                      builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);
                        return snapshot.hasData
                            ? Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(50.0)),
                                  border: new Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                margin: EdgeInsets.only(left: 8, top: 5),
                                width: 80,
                                height: 80,
                                child: CircleAvatar(backgroundColor: Colors.white,
                                  backgroundImage: snapshot.data['imageUser'] != "" ?NetworkImage(
                                      Server.getImgUrlUser +
                                          snapshot.data['imageUser']) : AssetImage('images/hoso/userr.png'),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(50.0)),
                                  border: new Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                margin: EdgeInsets.only(left: 8, top: 5),
                                width: 80,
                                height: 80,
                                child: new CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Colors.red),
                                    backgroundColor: Colors.orangeAccent,
                                  ),
                                ),
                              );
                      },
                    ),
                    Expanded(
                      child: FutureBuilder<dynamic>(
                        future: getInfo(),
                        // ignore: missing_return
                        builder: (context, snapshot) {
                          if (snapshot.hasError) print(snapshot.error);
                          return snapshot.hasData
                              ? new ListTile(
                                  onTap: () {},
                                  title: new Text(
                                    snapshot.data['userName'],
                                    style: new TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  subtitle: new Text(snapshot.data['phoneUser'],
                                      style: new TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700)),
                                )
                              : new Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 120.0),
                                  child: Text(""));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              new Divider(
                indent: 20,
                endIndent: 20,
                color: Colors.black,
                thickness: 1,
              ),
            TrangThai.dangNhap == false ? buttonDangKy() : button(), buttonSignOut()
            ],
          ),
        );
      },
    );
  }

  Widget button() {
    return Container(
      child: new Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  new CustomListTile(
                      'Tài khoản', 'images/hoso/user.png', 35.0, 35.0, () async{
                    if(user!= null){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ProfilePage(user)));
                    }
                  }),
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
                  new CustomListTile('Địa chỉ',
                      'images/hoso/diachi.png', 35.0, 35.0, () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => DiaChi()));
                      }),
                  new Divider(
                    indent: 0,
                    endIndent: 0,
                    color: Colors.black,
                    thickness: 0.5,
                  ),
                ],
              ),
              new CustomListTile(
                  'Thêm sản phẩm', 'images/category/khac.png', 35.0, 35.0, () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddProducts()));
              }),
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
              new CustomListTile('Sản phẩm của tôi',
                  'images/hoso/shop.png', 35.0, 35.0, () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SanPhamCuaToi()));
                  }),
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
              new CustomListTile(
                  'Trợ giúp', 'images/hoso/trogiup.png', 35.0, 35.0, () { Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TroGiup()));}),
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
              new CustomListTile(
                  'Về ứng dụng', 'images/hoso/law.png', 35.0, 35.0, () { Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => VeUngDung()));}),
              new Divider(
                indent: 0,
                endIndent: 0,
                color: Colors.black,
                thickness: 0.5,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buttonSignOut() {
    return Column(
      children: <Widget>[
        new Container(
          padding: EdgeInsets.all(0.0),
          child: new Material(
            child: new InkWell(
              splashColor: Colors.green,
              onTap: () async {
                try {
                  sharedPreferences = await SharedPreferences.getInstance();
                  sharedPreferences.clear();
                  sharedPreferences.commit();
                  TrangThai.dangNhap = false;
                  TrangThai.phone ="";
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context, rootNavigator: true)
                      .pushReplacementNamed('/home');
                  print('sign out');
                } catch (e) {
                  print(e);
                }
              },
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
        SizedBox(
          height: 90,
        )
      ],
    );
  }

  Future<dynamic> getInfo() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final response = await http
          .get(Server.getInfoUser + sharedPreferences.getString('_id'));
      var a = json.decode(response.body);
       user = User.fromJson(a['data']);
       print(user.userName);
      return a['data'];
    } catch (e) {
      print(e);
    }
  }

  Widget buttonDangKy() {
    return Container(
      child: Column(
        children: <Widget>[
          Text('Bạn hay đăng ký để có thể đấu giá',
              style: TextStyle(fontSize: 15)),
          RaisedButton(
            child: Text("Đăng ký"),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pushNamed('/signin');
            },
          )
        ],
      ),
    );
  }
}

class DangNhap extends StatefulWidget {
  @override
  _DangNhapState createState() => _DangNhapState();
}

class _DangNhapState extends State<DangNhap> {
  bool _isLoading = false;
  TextEditingController _controllerUser = new TextEditingController();
  TextEditingController _controllerPassword = new TextEditingController();

  bool _showPassWord = true;
  SharedPreferences sharedPreferences;

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
//                    StreamBuilder<Object>(
//                        stream: _loginBloc.userStream,
//                        builder: (context, snapshot) {
//                          return
                    new TextField(
                      autocorrect: false,
                      controller: _controllerUser,
                      decoration: InputDecoration(
//                                errorText:
//                                    snapshot.hasError ? snapshot.error : null,
                          border: OutlineInputBorder(),
                          hintText: 'Username or email address'),
                    ),
//                        }),
                    new SizedBox(
                      height: 10,
                    ),
                    Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: <Widget>[
//                        StreamBuilder<Object>(
//                            stream: _loginBloc.passStream,
//                            builder: (context, snapshot) {
//                              return
                        new TextField(
                          autocorrect: false,
                          obscureText: _showPassWord,
                          controller: _controllerPassword,
                          decoration: InputDecoration(
//                                    errorText: snapshot.hasError
//                                        ? snapshot.error
//                                        : null,
                              border: OutlineInputBorder(),
                              hintText: 'Password'),
                        ),
//                            }),
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: new GestureDetector(
                            onTap: () {},
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
                        onPressed: () {},
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
}

//
//class PageHoSo extends StatefulWidget {
//  @override
//  _PageHoSoState createState() => _PageHoSoState();
//}
//
//class _PageHoSoState extends State<PageHoSo> {
//  bool _isLoading = false;
//  TextEditingController _controllerUser = new TextEditingController();
//  TextEditingController _controllerPassword = new TextEditingController();
//  LoginBloc _loginBloc = new LoginBloc();
//  bool _showPassWord = true;
//  SharedPreferences sharedPreferences;
//
//  @override
//  Widget build(BuildContext context) {
//    Widget _dangNhap = new Container(
//      padding: EdgeInsets.only(left: 20, right: 20),
//      color: Colors.white,
//      height: MediaQuery.of(context).size.height,
//      width: MediaQuery.of(context).size.width,
//      child: ListView(
//        children: <Widget>[
//          new Column(
//            children: <Widget>[
//              Container(
//                margin: EdgeInsets.only(top: 100),
//                child: new Text(
//                  'Login',
//                  style: TextStyle(
//                      color: Colors.black,
//                      fontSize: 30,
//                      fontWeight: FontWeight.bold),
//                ),
//              ),
//              new SizedBox(
//                height: 75,
//              ),
//
//              //text field, login, forgot password
//              new Container(
//                padding: EdgeInsets.only(left: 15, right: 15),
//                child: Column(
//                  children: <Widget>[
////                    StreamBuilder<Object>(
////                        stream: _loginBloc.userStream,
////                        builder: (context, snapshot) {
////                          return
//                    new TextField(
//                      autocorrect: false,
//                      controller: _controllerUser,
//                      decoration: InputDecoration(
////                                errorText:
////                                    snapshot.hasError ? snapshot.error : null,
//                          border: OutlineInputBorder(),
//                          hintText: 'Username or email address'),
//                    ),
////                        }),
//                    new SizedBox(
//                      height: 10,
//                    ),
//                    Stack(
//                      alignment: AlignmentDirectional.centerEnd,
//                      children: <Widget>[
////                        StreamBuilder<Object>(
////                            stream: _loginBloc.passStream,
////                            builder: (context, snapshot) {
////                              return
//                        new TextField(
//                          autocorrect: false,
//                          obscureText: _showPassWord,
//                          controller: _controllerPassword,
//                          decoration: InputDecoration(
////                                    errorText: snapshot.hasError
////                                        ? snapshot.error
////                                        : null,
//                              border: OutlineInputBorder(),
//                              hintText: 'Password'),
//                        ),
////                            }),
//                        Container(
//                          margin: EdgeInsets.only(right: 5),
//                          child: new GestureDetector(
//                            onTap: _onToggleShowPassword,
//                            child: new Text(
//                              _showPassWord ? 'SHOW' : 'HIDE',
//                              style: new TextStyle(
//                                  color: Colors.blue,
//                                  fontWeight: FontWeight.bold),
//                            ),
//                          ),
//                        )
//                      ],
//                    ),
//                    new SizedBox(
//                      height: 20,
//                    ),
//                    new SizedBox(
//                      width: double.infinity,
//                      height: 50.0,
//                      child: new RaisedButton(
//                        color: Colors.green[600],
//                        onPressed: _onClickLogIn,
//                        child: new Text(
//                          "Log in",
//                          style: new TextStyle(
//                              color: Colors.white, fontSize: 20.0),
//                        ),
//                      ),
//                    ),
//                    new SizedBox(
//                      height: 15.0,
//                    ),
//                    new GestureDetector(
//                      onTap: () {},
//                      child: new Text(
//                        'Forgot Password?',
//                        style: new TextStyle(
//                            color: Colors.green[600],
//                            fontSize: 15.0,
//                            fontWeight: FontWeight.bold),
//                      ),
//                    ),
//                  ],
//                ),
//              )
//            ],
//          ),
//        ],
//      ),
//    );
//    Widget _hoSoCaNhan = new Container(
//      padding: EdgeInsets.all(0.0),
//      width: MediaQuery.of(context).size.width,
//      height: MediaQuery.of(context).size.height,
//      color: Colors.white,
//      child: new ListView(
//        padding: EdgeInsets.all(0.0),
//        children: <Widget>[
//          //background
//          new Container(
//            height: 300,
//            child: new Image.asset(
//              'images/hoso/backgroundhoso.jpg',
//              fit: BoxFit.cover,
//            ),
//          ),
//          //avatar, name
//          new Container(
//            height: 80,
//            color: Colors.white,
//            child: new Row(
//              mainAxisAlignment: MainAxisAlignment.start,
//              children: <Widget>[
//                Container(
//                  decoration: BoxDecoration(
//                    color: Colors.white,
//                    borderRadius:
//                        new BorderRadius.all(new Radius.circular(50.0)),
//                    border: new Border.all(
//                      color: Colors.black,
//                      width: 1.0,
//                    ),
//                  ),
//                  margin: EdgeInsets.only(left: 8, top: 5),
//                  width: 80,
//                  height: 80,
//                  child: new CircleAvatar(
//                    radius: 2,
//                    backgroundImage: AssetImage('images/hoso/user.jpg'),
//                  ),
//                ),
//                Expanded(
//                  child: FutureBuilder<dynamic>(
//                    future: getInfo(),
//                    // ignore: missing_return
//                    builder: (context, snapshot) {
//                      if (snapshot.hasError) print(snapshot.error);
//                      return snapshot.hasData
//                          ? new ListTile(
//                              onTap: () {},
//                              title: new Text(
//                                snapshot.data['name'],
//                                style: new TextStyle(
//                                    fontSize: 22, fontWeight: FontWeight.w700),
//                              ),
//                              subtitle: new Text(snapshot.data['email'],
//                                  style: new TextStyle(
//                                      fontSize: 15,
//                                      fontWeight: FontWeight.w700)),
//                            )
//                          : new Container(child:new CircularProgressIndicator());
//                    },
//                  ),
//                ),
//              ],
//            ),
//          ),
//          new Divider(
//            indent: 20,
//            endIndent: 20,
//            color: Colors.black,
//            thickness: 1,
//          ),
//          //choose
//          new Container(
//            child: new Column(
//              children: <Widget>[
//                Column(
//                  children: <Widget>[
//                    new CustomListTile(
//                        'Tài khoản', 'images/hoso/user.png', 35.0, 35.0, () {}),
//                    new Divider(
//                      indent: 0,
//                      endIndent: 0,
//                      color: Colors.black,
//                      thickness: 0.5,
//                    ),
//                  ],
//                ),
//                Column(
//                  children: <Widget>[
//                    new CustomListTile('Địa chỉ giao hàng',
//                        'images/hoso/delivery.png', 35.0, 35.0, () {}),
//                    new Divider(
//                      indent: 0,
//                      endIndent: 0,
//                      color: Colors.black,
//                      thickness: 0.5,
//                    ),
//                  ],
//                ),
//                Column(
//                  children: <Widget>[
//                    new CustomListTile('Hỗ trợ khách hàng',
//                        'images/hoso/question.png', 35.0, 35.0, () {}),
//                    new Divider(
//                      indent: 0,
//                      endIndent: 0,
//                      color: Colors.black,
//                      thickness: 0.5,
//                    ),
//                  ],
//                ),
//                //images/hoso/quyenungdung.png
//                Column(
//                  children: <Widget>[
//                    new CustomListTile('Quyền khách hàng',
//                        'images/hoso/quyenungdung.png', 35.0, 35.0, () {}),
//                    new Divider(
//                      indent: 0,
//                      endIndent: 0,
//                      color: Colors.black,
//                      thickness: 0.5,
//                    ),
//                  ],
//                ),
//                Column(
//                  children: <Widget>[
//                    new CustomListTile('Trợ giúp', 'images/hoso/trogiup.png',
//                        35.0, 35.0, () {}),
//                    new Divider(
//                      indent: 0,
//                      endIndent: 0,
//                      color: Colors.black,
//                      thickness: 0.5,
//                    ),
//                  ],
//                ),
//                //
//                Column(
//                  children: <Widget>[
//                    new CustomListTile('Về ứng dụng', 'images/hoso/law.png',
//                        35.0, 35.0, () {}),
//                    new Divider(
//                      indent: 0,
//                      endIndent: 0,
//                      color: Colors.black,
//                      thickness: 0.5,
//                    ),
//                  ],
//                ),
//                Column(
//                  children: <Widget>[
//                    new Container(
//                      padding: EdgeInsets.all(0.0),
//                      child: new Material(
//                        child: new InkWell(
//                          splashColor: Colors.green,
//                          onTap: () async {
//                            sharedPreferences =
//                                await SharedPreferences.getInstance();
//                            sharedPreferences.clear();
//                            sharedPreferences.commit();
//                            TrangThai.dangNhap = false;
//                            Navigator.of(context, rootNavigator: true)
//                                .pushAndRemoveUntil(
//                                    MaterialPageRoute(
//                                        builder: (BuildContext context) =>
//                                            new LoginPage()),
//                                    (Route<dynamic> route) => false);
//                          },
//                          child: ListTile(
//                            title: Text(
//                              'Đăng xuất',
//                              style: new TextStyle(
//                                  fontSize: 20.0,
//                                  color: Colors.blue,
//                                  fontWeight: FontWeight.w600),
//                            ),
//                            leading: new Image.asset('images/hoso/lock.png',
//                                fit: BoxFit.cover, width: 35, height: 35),
//                          ),
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//                SizedBox(
//                  height: 90,
//                )
//              ],
//            ),
//          ),
//        ],
//      ),
//    );
//    return TrangThai.dangNhap ? _hoSoCaNhan : _dangNhap;
//  }
//
//  signIn(String email, pass) async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    Map data = {
//      'email': email,
//      'passWord': pass,
//    };
//    var jsonResponse = null;
//
//    var respone = await http.post(Server.signin, body: data);
//
//    if (respone.statusCode == 200) {
//      jsonResponse = json.decode(respone.body);
//      print('Response status: ${respone.statusCode}');
//      print('Response body: ${respone.body}');
//
//      if (jsonResponse != null) {
//        setState(() {
//          TrangThai.dangNhap = true;
//        });
//        sharedPreferences.setString("token", jsonResponse['token']);
//        sharedPreferences.setString("_id", jsonResponse['id']);
//        sharedPreferences.setString("name", jsonResponse['name']);
//        sharedPreferences.setString("email", jsonResponse['email']);
//      } else {
//        setState(() {
//          TrangThai.dangNhap = false;
//        });
//      }
//    } else {
//      setState(() {
//        TrangThai.dangNhap = false;
//      });
//      print(respone.body);
//    }
//  }
//
//  void _onClickLogIn() {
//    signIn(_controllerUser.text, _controllerPassword.text);
//  }
//
//  Future<dynamic> getInfo() async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    String resault = sharedPreferences.getString("_id");
//    final response = await http.get(Server.getInfoUser + resault);
//    var a = json.decode(response.body);
//    return a;
//  }
//
//
//  void _onToggleShowPassword() {
//    setState(() {
//      _showPassWord = !_showPassWord;
//    });
//  }
//}
