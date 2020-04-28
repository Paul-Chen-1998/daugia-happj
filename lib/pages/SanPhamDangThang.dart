import 'package:flutter/material.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';

class PageDonHang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: GradientAppbar(Colors.green, Colors.greenAccent),
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          "Sản Phẩm Đang Thắng",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
            letterSpacing: 5.0,
          ),
        ),
      ),
      body: new Center(child:new Text('Thông tin sản phẩm đang THẮNG (thời gian vẫn còn) sẽ chuyển sang field này, Thời gian hết thông tin tự động mất')),
    );
  }
}
