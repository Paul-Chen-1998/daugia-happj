import 'package:flutter/material.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';

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
                print("diachi");
              },)
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 16.0),
          Divider(),
          SizedBox(height: 16.0),

          TextFormField(
            decoration: InputDecoration(labelText: 'Địa Chỉ 1'),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value.isEmpty) {
                return 'Xin Đừng Để Trống!';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Địa chỉ 2'),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value.isEmpty) {
                return 'Xin Đừng Để Trống!';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Địa chỉ 3'),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value.isEmpty) {
                return 'Xin Đừng Để Trống!';
              }
              return null;
            },
          ),
        ],
      )
    );
  }
}

