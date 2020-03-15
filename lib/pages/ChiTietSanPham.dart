import 'package:flutter/material.dart';
import 'package:flutterhappjapp/main.dart';
import 'package:flutterhappjapp/components/Sanpham.dart';

class chitietsanpham extends StatefulWidget {
  final tenchitietsanpham;
  final giachitietsanpham;
  final hinhanhchitietsanpham;

  chitietsanpham({
    this.tenchitietsanpham,
    this.giachitietsanpham,
    this.hinhanhchitietsanpham,
  });

  @override
  _chitietsanphamState createState() => _chitietsanphamState();
}

class _chitietsanphamState extends State<chitietsanpham> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: InkWell(

            child: Text("Happj App")),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: null),
          new IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: null)
        ],
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.asset(widget.hinhanhchitietsanpham),
              ),
              footer: new Container(
                  color: Colors.white70,
                  child: ListTile(
                    leading: new Text(
                      widget.tenchitietsanpham,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    title: new Row(
                      children: <Widget>[
                        Expanded(
                            child: Text(
                          "${widget.giachitietsanpham} \ VND  ",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        )),
                      ],
                    ),
                  )),
            ),
          ),
          // ======= the first buttons =======
//          Row(
//            children: <Widget>[
//              // ====== the size button ======
//              Expanded(
//                child: MaterialButton(
//                  onPressed: () {},
//                  height: 40,
//                  color: Colors.white,
//                  textColor: Colors.grey,
//                  elevation: 0.2,
//                  child: Row(
//                    children: <Widget>[
//                      Expanded(child: new Text("Số Lượng")),
//                      Expanded(child: new Icon(Icons.add)),
//                      new Container(
//                          width: 40.0,
//                          height: 40.0,
//                          child: new TextField(
//                              style: new TextStyle(
//                                  fontSize: 20.0,
//                                  height: 1.5,
//                                  color: Colors.black))),
//                      Expanded(
//                        child: new Icon(Icons.remove),
//                      )
//                    ],
//                  ),
//                ),
//              ),
//            ],
//          ),

          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(context: null);
                  },
                  color: Colors.red,
                  textColor: Colors.white,
                  elevation: 0.2,
                  child: new Text(("Mua ngay")),
                ),
              ),
              new IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  color: Colors.red,
                  onPressed: () {}),
              new IconButton(
                  icon: Icon(Icons.favorite_border),
                  color: Colors.red,
                  onPressed: () {}),
            ],
          ),
          Divider(color: Colors.red),
          new ListTile(
            title: new Text("Chi Tiết Sản Phẩm"),
            subtitle: new Text(
                "Xi cô la nè ăn ngon lắm nha chúng tôi bán bla bla....."),
          ),
          Divider(color: Colors.red),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text(
                  "Tên Sản Phẩm",
                  style: TextStyle(color: Colors.green),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: new Text(widget.tenchitietsanpham),
              )
            ],
          ),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text(
                  "Thương Hiệu",
                  style: TextStyle(color: Colors.green),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: new Text("Happj"),
              )
            ],
          ),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text(
                  "Tình trạng",
                  style: TextStyle(color: Colors.green),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: new Text("Còn hàng"),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(),
          ),
          new Text("Sản phẩm tương tự"),
        ],
      ),
    );
  }
}

class SP_TuongTu extends StatefulWidget {
  @override
  _SP_TuongTuState createState() => _SP_TuongTuState();
}

class _SP_TuongTuState extends State<SP_TuongTu> {
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
    {
      "ten": "Bapula\nChocolate",
      "hinhanh": "images/Sanpham/chocolate1.jpg",
      "giamoi": 185000,
    },
    {
      "ten": "Baria\nChocolate",
      "hinhanh": "images/Sanpham/chocolate2.jpg",
      "giamoi": 18500,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: list_sanpham.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return SanPhamTuongTu(
            ten_sp: list_sanpham[index]['ten'],
            hinh_sp: list_sanpham[index]["hinhanh"],
            gia_sp_moi: list_sanpham[index]["giamoi"],
          );
        });
  }
}

class SanPhamTuongTu extends StatelessWidget {
  final ten_sp;
  final hinh_sp;
  final gia_sp_moi;

  SanPhamTuongTu({this.ten_sp, this.hinh_sp, this.gia_sp_moi});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Hero(
            tag: ten_sp,
            child: Material(
              child: InkWell(
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    //sanpham = > chi tiet san pham
                    builder: (context) => new chitietsanpham(
                          tenchitietsanpham: ten_sp,
                          giachitietsanpham: gia_sp_moi,
                          hinhanhchitietsanpham: hinh_sp,
                        ))),
                child: GridTile(
                  footer: Container(
                      color: Colors.white70,
                      child: new Row(
                        children: <Widget>[
                          Expanded(
                            child: new Text(
                              ten_sp,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0),
                            ),
                          ),
                          new Text(
                            "${gia_sp_moi} \ VND",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                  child: Image.asset(
                    hinh_sp,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )));
  }
}
