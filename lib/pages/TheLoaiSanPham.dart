import 'package:flutter/material.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';

class TheLoaiSanPham extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: GradientAppbar(Colors.green[700], Colors.grey[400]),
        brightness: Brightness.dark,
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        title: Text(
          "Danh Mục Sản Phẩm",
            overflow: TextOverflow.visible,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
            letterSpacing: 5.0,
          ),
        ),
      ),
    );
  }
}
