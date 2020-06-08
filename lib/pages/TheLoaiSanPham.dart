import 'package:flutter/material.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';

import 'Option.dart';

class TheLoaiSanPham extends StatefulWidget {
  @override
  _TheLoaiSanPhamState createState() => _TheLoaiSanPhamState();
}

class _TheLoaiSanPhamState extends State<TheLoaiSanPham> {
  @override
  Widget build(BuildContext context) {
    Widget _appbar = new AppBar(
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
    );
    return Scaffold(
      appBar: _appbar,
      body: ListView(children: <Widget>[
        ChiTietTheLoai(),
        new SizedBox(height: 500)
      ],));
  }
}

class ChiTietTheLoai extends StatefulWidget {
  @override
  _ChiTietTheLoaiState createState() => _ChiTietTheLoaiState();
}

class _ChiTietTheLoaiState extends State<ChiTietTheLoai> {
  var _theLoai = [
    {
      "ten": "Thực phẩm sạch",
      "hinhanh": "images/category/food.png",
      "soluong": 20,
    },
    {
      "ten": "Hàng nhập khẩu",
      "hinhanh": "images/category/imported.png",
      "soluong": 20,
    },
    {
      "ten": "Thời Trang",
      "hinhanh": "images/category/fashion.png",
      "soluong": 20,
    },
    {
      "ten": "Đồ Gia Dụng",
      "hinhanh": "images/category/dienmay.png",
      "soluong": 20,
    },
    {
      "ten": "Đồ Công Nghệ",
      "hinhanh": "images/category/congnghe.png",
      "soluong": 20,
    },
    {
      "ten": "Bất Động Sản",
      "hinhanh": "images/category/batdongsan.png",
      "soluong": 20,
    },
    {
      "ten": "Xe Cộ",
      "hinhanh": "images/category/car.png",
      "soluong": 20,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(8.0),
      child: new GridView.builder(
          itemCount: _theLoai.length,
          gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return The_Loai_Don(
              ten_the_loai: _theLoai[index]["ten"],
              hinh_the_loai: _theLoai[index]["hinhanh"],
              so_luong: _theLoai[index]["soluong"],
            );
          }),
    );
  }
}

class The_Loai_Don extends StatelessWidget {
  final ten_the_loai;
  final hinh_the_loai;
  final so_luong;

  The_Loai_Don(
      {this.ten_the_loai, this.hinh_the_loai, this.so_luong});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> Navigator.of(context).push(MaterialPageRoute  (
          builder: (context) => Option(
            theLoai: ten_the_loai,
          ))),
      child: Container(
        height: 150,
        width: 100,
        decoration: new BoxDecoration(boxShadow: [
          new BoxShadow(
            color: Colors.grey[400],
            blurRadius: 50.0,
          ),
        ]),
        child: Card(
          borderOnForeground: true,
          margin: EdgeInsets.all(8.0),
          child: ListView(
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Image.asset(
                    hinh_the_loai,
                    width: 100.0,
                    height: 110.0,
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
                        "${ten_the_loai}",
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      new SizedBox(
                        height: 5,
                      ),
                      new Text(
                        "Còn khoảng ${so_luong} mặt hàng",
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue),
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
      ),
    );
  }
}
