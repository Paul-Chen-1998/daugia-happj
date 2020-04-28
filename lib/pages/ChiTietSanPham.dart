import 'package:flutter/material.dart';
import 'package:flutterhappjapp/api/server.dart';


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
                child: Image.network(Server.hinhAnh + widget.hinhanhchitietsanpham),
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
                  child: new Text(("Xác Nhận")),
                ),
              ),
            ],
          ),
          new TextFormField(
            decoration: InputDecoration(labelText: 'Nhập số tiền bạn muốn đấu (VND)'),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
          ),
          new ListTile(
            title: new Text("Mô Tả Sản Phẩm",style: TextStyle(color: Colors.green),),
            subtitle: new Text(
                "Xi cô la nè ăn ngon lắm nha chúng tôi bán bla bla....."),
          ),
          Divider(color: Colors.red),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text(
                  "Tên Sản Phẩm:",
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
                  "Thể Loại:",
                  style: TextStyle(color: Colors.green),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: new Text("Thời Trang"),
              )
            ],
          ),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text(
                  "Người giữ giá cao nhất hiện tại:",
                  style: TextStyle(color: Colors.green),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: new Text("Vinh Vật Vờ"),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(),
          ),
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
