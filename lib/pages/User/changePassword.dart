import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterhappjapp/api/server.dart';
import 'package:flutterhappjapp/ui/splash.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool showOldPassword = true;
  bool obscure = true;
  TextEditingController controllerOldPassword = new TextEditingController();
  TextEditingController controllerNewPassword = new TextEditingController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPreferences sharedPreferences;
  bool load = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Change password'),
        ),
        body: !load
            ? Container(
                padding: EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: textFieldAndSubmit()),
              )
            : SplashPage());
  }

  List<Widget> textFieldAndSubmit() {
    List<Widget> textFields = [];
    if (showOldPassword) {
      textFields.add(_titleFields(title: "Old password"));
      textFields.add(Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: <Widget>[
          _textFields(
              controller: controllerOldPassword,
              hintText: "Nhập lại mật khẩu cũ",
              status: obscure),
          new GestureDetector(
            onTap: () {
              setState(() {
                obscure = !obscure;
              });
            },
            child: new Text(
              obscure ? 'SHOW' : 'HIDE',
              style: new TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ));
      textFields.add(_buttonSubmitOldPassword(title: "Submit"));
    } else {
      textFields.add(_titleFields(title: "New Password"));
      textFields.add(_showTextFieldNewPassword());
      textFields.add(_buttonSubmitNewPassword(title: "Submit"));
    }
    return textFields;
  }

  checkPassword(String password) async {
    if(!validation(password)) return;
    setState(() {
      load = true;
    });
    sharedPreferences = await SharedPreferences.getInstance();
    String id = sharedPreferences.getString("_id");
    String url = Server.checkPassword + id;
    print(url);
    Map data = {'passWord': password};
    var response = await http.post(url, body: data);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse) {
        setState(() {
          showOldPassword = false;
          load = false;
        });
        showSnackBar(
            "Bạn hãy nhập mật khẩu mới", scaffoldKey, Colors.green[400]);
      } else {
        setState(() {
          load = false;
        });
        showSnackBar("Mật khẩu không đúng!", scaffoldKey, Colors.red[400]);
      }
    } else {
      showSnackBar("Có lỗi khi check password", scaffoldKey, Colors.red[600]);
      setState(() {
        load = false;
      });
    }
  }

  showSnackBar(String message, final scaffoldKey, Color color) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: color,
      content: new Text(
        message,
        style: new TextStyle(color: Colors.white),
      ),
    ));
  }

  Widget _buttonSubmitNewPassword({String title}) {
    return RaisedButton(
      child: Text(title),
      onPressed: () {
        submitNewPassword(controllerNewPassword.text.trim());
      },
    );
  }

  Widget _buttonSubmitOldPassword({String title}) {
    return RaisedButton(
      child: Text(title),
      onPressed: () {
        checkPassword(controllerOldPassword.text.trim());
      },
    );
  }

  Widget _titleFields({String title}) {
    return Padding(
        padding: EdgeInsets.only(left: 0, right: 25.0, top: 25.0),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  title,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ));
  }

  Widget _textFields(
      {String hintText, bool status, TextEditingController controller}) {
    return Padding(
      padding: EdgeInsets.only(left: 0, right: 0, top: 0),
      child: new TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
        ),
        enabled: true,
        autofocus: true,
        obscureText: status,
      ),
    );
  }

  Widget _showTextFieldNewPassword() {
    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: <Widget>[
        _textFields(
            controller: controllerNewPassword,
            hintText: "Nhập mật khẩu mới",
            status: obscure),
        new GestureDetector(
          onTap: () {
            setState(() {
              obscure = !obscure;
            });
          },
          child: new Text(
            obscure ? 'SHOW' : 'HIDE',
            style:
                new TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  validation(String s){
    if( s.isEmpty){
      showSnackBar("Không được để trống", scaffoldKey, Colors.red[600]);
      return false;
    }
    return true;
  }
  submitNewPassword(String newPassword) async{
    try{
      if(!validation(newPassword)) return;
      setState(() {
        load = true;
      });
      sharedPreferences = await SharedPreferences.getInstance();
      String id = sharedPreferences.getString("_id");
      String url = Server.newPassword + id ;
      Map data = {
        'passWord' : newPassword
      };
      var response = await http.put(url,body: data);
      if(response.statusCode == 200){
        var jsonResponse = json.decode(response.body);
        print(jsonResponse['message']);
        Navigator.of(context).pop();
        setState(() {
          load = false;
        });
        Fluttertoast.showToast(msg: "Bạn đã đổi mật khẩu thành công!",);
      }
    }catch(e){
      print(e);
      setState(() {
        load = false;
      });
    }

  }
}
