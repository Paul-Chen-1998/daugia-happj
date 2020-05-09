import 'package:flutter/material.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';

import 'add_product.dart';

class SanPhamCuaToi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: GradientAppbar(Colors.green[700], Colors.grey[400]),
        brightness: Brightness.dark,
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        title: Text(
          "Sản Phẩm Của Tôi",
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
            letterSpacing: 5.0,
          ),
        ),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new AddProducts()));
              })
        ],
      ),
      body: Sanpham() ,
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
    },
    {
      "ten": "Tropical Cacao",
      "hinhanh": "images/Sanpham/cacao2.jpg",
      "giamoi": 185000,
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
            ),
          );
        });
  }
}

class Sanpham_don extends StatelessWidget {
  final ten_sp;
  final hinh_sp;
  final gia_sp_moi;

  Sanpham_don({this.ten_sp, this.hinh_sp, this.gia_sp_moi});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Hero(
          tag: ten_sp,
          child: Material(
//              child: InkWell(
//                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
//                  //sanpham = > chi tiet san pham
//                    builder: (context) => new chitietsanpham(
//                      tenchitietsanpham: ten_sp,
//                      giachitietsanpham: gia_sp_moi,
//                      hinhanhchitietsanpham: hinh_sp,
//                    ))),
            child: GridTile(
              footer: Container(
                  color: Colors.white70,
                  child: new Row(children: <Widget>[
                    Expanded(
                      child: new Text(ten_sp, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                    ),

                    new Text("${gia_sp_moi} \ VND", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                  ],)
              ),
              child: Image.asset(
                hinh_sp,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ));
  }
}
