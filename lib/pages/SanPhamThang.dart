import 'package:flutter/material.dart';

// import
import 'package:flutterhappjapp/components/ChiTietGioHang.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';

class SanPhamThang extends StatefulWidget {
  @override
  _SanPhamThangState createState() => _SanPhamThangState();
}

class _SanPhamThangState extends State<SanPhamThang> {
  @override
  Widget build(BuildContext context) {
    Widget _appbar = new AppBar(
      flexibleSpace: GradientAppbar(Colors.green[700], Colors.grey[400]),
      brightness: Brightness.dark,
      backgroundColor: Colors.greenAccent,
      centerTitle: true,
      title: Text(
        "Sản Phẩm Thắng",
        overflow: TextOverflow.visible,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.black,
          letterSpacing: 5.0,
        ),
      ),
    );
    return Scaffold(
        appBar: _appbar,
        body: new ChiTietGioHang(),);
  }
}
