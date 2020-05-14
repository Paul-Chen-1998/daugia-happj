import 'package:flutter/material.dart';
import 'package:flutterhappjapp/pages/User/add_address.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_product.dart';

class DiaChi extends StatelessWidget {
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
          actions: <Widget>[
            new IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AddAdress()));
              },
            )
          ],
        ),
        body: Column(
          children: <Widget>[SizedBox(height: 32.0), TextWidget()],
        ));
  }
}

class TextWidget extends StatefulWidget {
  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  SharedPreferences sharedPreferences;

  getAddress() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String address = sharedPreferences.getString('address');
    return address;
  }

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    getAddress();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAddress(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            padding: EdgeInsets.only(left:15.0,right:15.0),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(text: "Địa chỉ \n", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0,color: Colors.black)),
                  TextSpan(text: snapshot.data, style: TextStyle(fontSize: 20.0,color: Colors.black)),
                ],
              ),
            ),
          );
        } else {
          return Container(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
