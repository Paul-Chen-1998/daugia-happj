import 'package:flutter/material.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';

class HoTroKhachHang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: GradientAppbar(Colors.green[700], Colors.grey[400]),
        brightness: Brightness.dark,
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        title: Text(
          "Hỗ Trợ Khách Hàng",overflow: TextOverflow.visible,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
            letterSpacing: 5.0,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(0.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: new ListView(
          padding: EdgeInsets.all(0.0),
          children: <Widget>[
            new Container(
                height: 300,
                child: new Image.asset('images/hoso/backgroundhoso.jpg',fit: BoxFit.cover,)
            )
          ],
        ),
      ) ,
    );
  }
}
