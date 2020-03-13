import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChiTietGioHang extends StatefulWidget {
  @override
  _ChiTietGioHangState createState() => _ChiTietGioHangState();
}

class _ChiTietGioHangState extends State<ChiTietGioHang> {
  var SanPhamGioHang = [
    {
      "ten": "Tropical Cacao",
      "hinhanh": "images/Sanpham/cacao2.jpg",
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
    return new ListView.builder(
        itemCount: SanPhamGioHang.length,
        itemBuilder: (context, index) {
          return SP_Don_Gio_Hang(
            ten_sp_gio_hang: SanPhamGioHang[index]["ten"],
            hinh_sp_gio_hang: SanPhamGioHang[index]["hinhanh"],
            gia_sp_gio_hang: SanPhamGioHang[index]["giamoi"],
          );
        });
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
      height: 200,
      width: 200,
      child: Card(
          margin: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(8),
              child: Image.asset(
                hinh_sp_gio_hang,
                width: 150.0,
                height: 250.0,
                fit: BoxFit.cover,
              ),),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(ten_sp_gio_hang),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: new Container(
                          alignment: Alignment.topLeft,
                          child: new Text("${gia_sp_gio_hang} \ VND",
                              style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green)),
                        ),
                      )
                    ],
                  ),
                ],
              )),
              Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: null,
                    child: Text('+',style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),
                  ),
                  Text('1',style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                  FlatButton(
                    onPressed: null,
                    child: Text('-',style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),
                  )
                ],
              )
            ],
          )),
    );
  }
}
