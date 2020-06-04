import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterhappjapp/api/server.dart';
import 'package:flutterhappjapp/pages/User/add_address.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';
import 'package:flutterhappjapp/ui/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'add_product.dart';

class DiaChi extends StatefulWidget {
  @override
  _DiaChiState createState() => _DiaChiState();
}

class _DiaChiState extends State<DiaChi> {
  SharedPreferences sharedPreferences;
  IconData icon;
  bool load = false;

  // ignore: missing_return
  Future<dynamic> getAddress() async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      String id = sharedPreferences.getString('_id');
      String url = Server.getAddress + id;
      final response = await http.get(url);
      var a = json.decode(response.body);
      var c = a['message'];
//      if (c) {
//        setState(() {
//          icon = Icons.edit;
//        });
//      } else {
//        setState(() {
//          icon = Icons.add;
//        });
//      }
      print(a);
      return a;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
// TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: GradientAppbar(Colors.green[700], Colors.grey[400]),
          brightness: Brightness.dark,
          backgroundColor: Colors.greenAccent,
          centerTitle: true,
          title: Text(
            "Địa Chỉ Của Tôi",
            overflow: TextOverflow.visible,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
              letterSpacing: 5.0,
            ),
          ),
          actions: <Widget>[iconButton(Icons.edit)],
        ),
        body: FutureBuilder<dynamic>(
          future: getAddress(),
          // ignore: missing_return
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? Column(
                    children: <Widget>[
                      SizedBox(height: 32.0),
                      Container(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Địa chỉ \n",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.0,
                                      color: Colors.black)),
                              TextSpan(
                                  text: snapshot.data['address'],
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.black)),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                : SplashPage();
          },
        ));
  }

  Widget iconButton(IconData icon) {
    return new IconButton(
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => AddAdress()));
      },
    );
  }
}

class TextWidget extends StatefulWidget {
  final address;

  TextWidget({this.address});

  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  SharedPreferences sharedPreferences;

  @override
  void initState() {
// TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: "Địa chỉ \n",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Colors.black)),
            TextSpan(
                text:
                    "Bạn chưa nhập địa chỉ! Vui lòng chọn ở góc trên bên phải!",
                style: TextStyle(fontSize: 20.0, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
