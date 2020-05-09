import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChiTietGioHang extends StatefulWidget {
  @override
  _ChiTietGioHangState createState() => _ChiTietGioHangState();
}

class _ChiTietGioHangState extends State<ChiTietGioHang> {
  var _sanPhamGioHang = [
    {
      "ten": "Tropical Cacao",
      "hinhanh": "images/Sanpham/cacao2.jpg",
      "giamoi": 185000,
    },
    {
      "ten": "Bapula\nChocolate",
      "hinhanh": "images/Sanpham/chocolate1.jpg",
      "giamoi": 185000,
    },
    {
      "ten": "Bapula\nChocolate",
      "hinhanh": "images/Sanpham/chocolate1.jpg",
      "giamoi": 185000,
    },
    {
      "ten": "Bapula\nChocolate",
      "hinhanh": "images/Sanpham/chocolate1.jpg",
      "giamoi": 185000,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(8.0),
      child: new ListView.builder(
          itemCount: _sanPhamGioHang.length,
          itemBuilder: (context, index) {
            return SP_Don_Gio_Hang(
              ten_sp_gio_hang: _sanPhamGioHang[index]["ten"],
              hinh_sp_gio_hang: _sanPhamGioHang[index]["hinhanh"],
              gia_sp_gio_hang: _sanPhamGioHang[index]["giamoi"],
            );
          }),
    );
  }
}

class SP_Don_Gio_Hang extends StatelessWidget {
  final ten_sp_gio_hang;
  final hinh_sp_gio_hang;
  final gia_sp_gio_hang;

  SP_Don_Gio_Hang(
      {this.ten_sp_gio_hang, this.hinh_sp_gio_hang, this.gia_sp_gio_hang});

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
                  hinh_sp_gio_hang,
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
                      "${ten_sp_gio_hang}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    new SizedBox(
                      height: 10,
                    ),
                    new Text(
                      "${gia_sp_gio_hang} VND",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    new SizedBox(
                      height: 5,
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
