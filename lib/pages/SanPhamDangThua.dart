import 'package:flutter/material.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';

class SanPhamDangThua extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: GradientAppbar(Colors.green[700], Colors.grey[400]),
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          "Sản Phẩm Đang Thua",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
            letterSpacing: 5.0,
          ),
        ),
      ),
//      body: new Center(child:new Text('Thông tin sản phẩm đang THUA (thời gian vẫn còn) sẽ chuyển sang field này, Thời gian hết thông tin tự động mất')),

    );
  }
}
