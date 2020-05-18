import 'package:flutter/material.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';

class SanPhamDangThua extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: GradientAppbar(Colors.green[700], Colors.grey[400]),
        brightness: Brightness.dark,
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        title: Text(
          "Sản Phẩm Đang Thua",
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
            letterSpacing: 5.0,
          ),
        ),
      ),
      body: Sanpham(),
    );
  }
}

class Sanpham extends StatefulWidget {
  @override
  _SanphamState createState() => _SanphamState();
}

class _SanphamState extends State<Sanpham> {
  var list_sanpham = [
    {
      "ten": "Binon Cacao",
      "hinhanh": "images/Sanpham/cacao1.jpg",
      "giamoi": 85000,
      "thoigian": "3:00",
      "nguoigiugiacaohientai": "Bảo Bảo"
    },
    {
      "ten": "Tropical Cacao",
      "hinhanh": "images/Sanpham/cacao2.jpg",
      "giamoi": 185000,
      "thoigian": "3:00",
      "nguoigiugiacaohientai": "Vinh Vinh"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: list_sanpham.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Sanpham_don(
              ten_sp: list_sanpham[index]['ten'],
              hinh_sp: list_sanpham[index]["hinhanh"],
              gia_sp_moi: list_sanpham[index]["giamoi"],
              thoi_gian: list_sanpham[index]["thoigian"],
              nguoi_giu_gia_cao_hien_tai: list_sanpham[index]
              ["nguoigiugiacaohientai"],
            ),
          );
        });
  }
}

class Sanpham_don extends StatelessWidget {
  final ten_sp;
  final hinh_sp;
  final gia_sp_moi;
  final thoi_gian;
  final nguoi_giu_gia_cao_hien_tai;

  Sanpham_don(
      {this.ten_sp,
        this.hinh_sp,
        this.gia_sp_moi,
        this.thoi_gian,
        this.nguoi_giu_gia_cao_hien_tai});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Hero(
          tag: ten_sp,
          child: Material(
            child: GridTile(
              footer: Container(
                  color: Colors.white70,
                  child: Column(
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          Expanded(
                            child: new Text(
                              ten_sp,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10.0),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image.asset('images/miniicon/minibid.png'),
                                  new Text(
                                    "   ${gia_sp_moi} \ VND",
                                    style: TextStyle(
                                        color: Colors.red, fontWeight: FontWeight.bold,  fontSize: 8.0),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Image.asset('images/miniicon/miniclock.png'),
                                  new Text(
                                    "   ${thoi_gian}",
                                    style: TextStyle(
                                        color: Colors.red, fontWeight: FontWeight.bold,  fontSize: 8.0),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Image.asset('images/miniicon/miniuser.png'),
                                  new Text(
                                    "   ${nguoi_giu_gia_cao_hien_tai}",
                                    style: TextStyle(
                                        color: Colors.red, fontWeight: FontWeight.bold,  fontSize: 8.0),
                                  ),
                                ],
                              ),
                            ],
                          ),


                        ],
                      ),
                    ],
                  )),
              child: Image.asset(
                hinh_sp,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ));
  }
}
