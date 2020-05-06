import 'package:flutter/material.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';

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
          "Hỗ Trợ Khách Hàng",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
            letterSpacing: 5.0,
          ),
        ),
      ),

//    body: ,
//      body: new Center(child:new Text('Thông tin sản phẩm đang THẮNG (thời gian vẫn còn) sẽ chuyển sang field này, Thời gian hết thông tin tự động mất')),

    );
  }
}
