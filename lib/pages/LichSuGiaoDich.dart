import 'package:flutter/material.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';

class LichSuGiaoDich extends StatefulWidget {
  @override
  _LichSuGiaoDichState createState() => _LichSuGiaoDichState();
}

class _LichSuGiaoDichState extends State<LichSuGiaoDich> {
  @override
  Widget build(BuildContext context) {
    Widget _appbar = new AppBar(
      flexibleSpace: GradientAppbar(Colors.green[700], Colors.grey[400]),
      brightness: Brightness.dark,
      backgroundColor: Colors.greenAccent,
      centerTitle: true,
      title: Text(
        "Lịch Sử Giao Dịch",
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
      body: new ChiTietGiaoDich(),);
  }
}
class ChiTietGiaoDich extends StatefulWidget {
  @override
  _ChiTietGiaoDichState createState() => _ChiTietGiaoDichState();
}

class _ChiTietGiaoDichState extends State<ChiTietGiaoDich> {
  var _sanPhamGiaoDich = [
    {
      "ten": "Tropical Cacao",
      "hinhanh": "images/Sanpham/cacao2.jpg",
      "giamoi": 185000,
      "thoigian": "18:25-18/05/2019"
    },
    {
      "ten": "Bapula Chocolate",
      "hinhanh": "images/Sanpham/chocolate1.jpg",
      "giamoi": 185000,
      "thoigian": "18:25-18/05/2019"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(8.0),
      child: new ListView.builder(
          itemCount: _sanPhamGiaoDich.length,
          itemBuilder: (context, index) {
            return SP_Don_Giao_Dich(
              ten_sp_giao_dich: _sanPhamGiaoDich[index]["ten"],
              hinh_sp_giao_dich: _sanPhamGiaoDich[index]["hinhanh"],
              gia_sp_giao_dich: _sanPhamGiaoDich[index]["giamoi"],
              thoi_gian: _sanPhamGiaoDich[index]["thoigian"],
            );
          }),
    );
  }
}

class SP_Don_Giao_Dich extends StatelessWidget {
  final ten_sp_giao_dich;
  final hinh_sp_giao_dich;
  final gia_sp_giao_dich;
  final thoi_gian;

  SP_Don_Giao_Dich(
      {this.ten_sp_giao_dich, this.hinh_sp_giao_dich, this.gia_sp_giao_dich, this.thoi_gian});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 200,
      decoration: new BoxDecoration(boxShadow: [
        new BoxShadow(
          color: Colors.grey[400],
          blurRadius: 50.0,
        ),
      ]),
      child: Card(
        borderOnForeground: true,
        margin: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Image.asset(
                  hinh_sp_giao_dich,
                  width: 160.0,
                  height: 250.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              child: Center(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      "${ten_sp_giao_dich}",
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    new SizedBox(
                      height: 10,
                    ),
                    new Text(
                      "${gia_sp_giao_dich} VND",
                      style: TextStyle(
                          fontSize: 5,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    new SizedBox(
                      height: 5,
                    ),
                    new Text(
                      "Giao dịch lúc: ${thoi_gian}",
                      style: TextStyle(
                          fontSize: 5,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
