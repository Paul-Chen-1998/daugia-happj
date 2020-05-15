import 'package:flutter/material.dart';

// import
import 'package:flutterhappjapp/components/ChiTietGioHang.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';

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
      body: new TheLoaiSanPhamDon(),);
  }
}

class TheLoaiSanPhamDon extends StatefulWidget {
  @override
  _TheLoaiSanPhamDonState createState() => _TheLoaiSanPhamDonState();
}

class _TheLoaiSanPhamDonState extends State<TheLoaiSanPhamDon> {
  var _theLoaiSanPham = [
    {
      "ten": "Hàng Nhập Khẩu",
      "hinhanh": "images/category/hangnhapkhau.png",
      "soluong": 200,
    },
    {
      "ten": "Thời Trang",
      "hinhanh": "images/category/thoitrang.png",
      "soluong": 100,
    },
    {
      "ten": "Điện máy",
      "hinhanh": "images/category/congnghe.png",
      "soluong": 80,
    },
    {
      "ten": "Bất Động Sản",
      "hinhanh": "images/category/batdongsan.png",
      "soluong": 50,
    },
    {
      "ten": "Xe Cộ",
      "hinhanh": "images/category/xeco.png",
      "soluong": 60,
    }
    ,
    {
      "ten": "Khác",
      "hinhanh": "images/category/khac.png",
      "soluong": 70,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(8.0),
      child: new GridView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _theLoaiSanPham.length,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 1, mainAxisSpacing: 1),
          itemBuilder: (BuildContext context, int index) {
            return TheLoai_Don(
              ten_sp_gio_hang: _theLoaiSanPham[index]["ten"],
              hinh_the_loai_sp: _theLoaiSanPham[index]["hinhanh"],
              so_luong_san_pham: _theLoaiSanPham[index]["soluong"],
            );
          }),
    );
  }
}

class TheLoai_Don extends StatelessWidget {
  final ten_sp_gio_hang;
  final hinh_the_loai_sp;
  final so_luong_san_pham;

  TheLoai_Don(
      {this.ten_sp_gio_hang, this.hinh_the_loai_sp, this.so_luong_san_pham});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
        decoration: new BoxDecoration(boxShadow: [
          new BoxShadow(
            color: Colors.grey[400],
            blurRadius: 50.0,
          ),
        ]),
        child: Card(
          borderOnForeground: true,
          margin: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Image.asset(
                    hinh_the_loai_sp,
//                  width: 160.0,
//                  height: 250.0,
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
                        "Có hơn ${so_luong_san_pham} sản phẩm",
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
      ),
      ]
    );
  }
}
