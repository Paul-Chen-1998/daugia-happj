import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterhappjapp/model/Product.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePage.dart';

class SanPhamDangThang extends StatefulWidget {
  @override
  _SanPhamDangThangState createState() => _SanPhamDangThangState();
}

class _SanPhamDangThangState extends State<SanPhamDangThang> {
  DatabaseReference itemRef;
  String idUser;
  List<Product> listData = new List();

  getNameAndID() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //name = sharedPreferences.getString('name');
    setState(() {
      idUser = sharedPreferences.getString('_id');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idUser = "";
    getNameAndID();
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef = database.reference().child('products');
  }

  @override
  Widget build(BuildContext context) {
    Widget _body = new ListView(
      children: <Widget>[
        new Container(
          width: MediaQuery.of(context).size.width,
          height: 800,
          child: new Column(
            children: <Widget>[
              //padding widget
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: new Text(
                      '',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 20.0),
                    )),
              ),
              //grid view
              new StreamBuilder(
                stream: itemRef
                    .orderByChild("winner/1")
                    .equalTo(idUser.trim().toString())
                    .onValue,
                // ignore: missing_return
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    print("has error");
                    print(snapshot.error);
                  }
                  if (snapshot.hasData &&
                      !snapshot.hasError &&
                      snapshot.data.snapshot.value != null) {
                    listData.clear();
                    print('begin san pham dang thang');
                    Map data = snapshot.data.snapshot.value;
                    data.forEach((index, data) {
                      if ((int.parse(data['extraTime']) -
                              DateTime.now().millisecondsSinceEpoch >
                          0))
                        {
                          List winnerr = new List();
                          winnerr.addAll(data['winner']);
                          if(winnerr[1] == idUser.trim().toString()){
                            listData.add(Product(
                                currentPrice: data['currentPrice'],
                                hide: data['hide'],
                                winner: data['winner'],
                                name: data['nameProduct'],
                                userId: data['userId'],
                                played: data['played'],
                                startPrice: data['startPriceProduct'],
                                registerDate: data['registerDate'],
                                nameType: data['nameProductType'],
                                img: data['imageProduct'],
                                description: data['description'],
                                extraTime: data['extraTime'],
                                status: data['status'],
                                key: index));
                          }
                        }
                    });
                    print(data);
                    return Flexible(child: Sanpham(list: listData,s: "Bạn chưa đấu giá thắng sản phẩm nào!",));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return new Container(
                      width: MediaQuery.of(context).size.width,
                      height: 550,
                      child: new Center(
                        child: new CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (!snapshot.hasError &&
                      snapshot.data.snapshot.value == null) {
                    return Text('Bạn chưa đấu giá sản phẩm nào!',
                        style: TextStyle(color: Colors.black, fontSize: 25.0));
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: GradientAppbar(Colors.green[700], Colors.grey[400]),
          brightness: Brightness.dark,
          backgroundColor: Colors.greenAccent,
          centerTitle: true,
          title: Text(
            "Sản Phẩm Đang Thắng",
            overflow: TextOverflow.visible,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
              letterSpacing: 5.0,
            ),
          ),
        ),
        body: _body);
  }
}

//class Sanpham extends StatefulWidget {
//  List<Product> list;
//
//  Sanpham({this.list});
//
//  @override
//  _SanphamState createState() => _SanphamState();
//}
//
//class _SanphamState extends State<Sanpham> {
//
//
//  var list_sanpham = [
//    {
//      "ten": "Binon Cacao",
//      "hinhanh": "images/Sanpham/cacao1.jpg",
//      "giamoi": 85000,
//      "thoigian": "3:00",
//      "nguoigiugiacaohientai": "Bảo Bảo"
//    },
//    {
//      "ten": "Tropical Cacao",
//      "hinhanh": "images/Sanpham/cacao2.jpg",
//      "giamoi": 185000,
//      "thoigian": "3:00",
//      "nguoigiugiacaohientai": "Vinh Vinh"
//    },
//  ];
//
//  @override
//  Widget build(BuildContext context) {
//    return GridView.builder(
//        itemCount: list_sanpham.length,
//        gridDelegate:
//            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//        itemBuilder: (BuildContext context, int index) {
//          return Padding(
//            padding: const EdgeInsets.all(4.0),
//            child: Sanpham_don(
//              ten_sp: list_sanpham[index]['ten'],
//              hinh_sp: list_sanpham[index]["hinhanh"],
//              gia_sp_moi: list_sanpham[index]["giamoi"],
//              thoi_gian: list_sanpham[index]["thoigian"],
//              nguoi_giu_gia_cao_hien_tai: list_sanpham[index]
//                  ["nguoigiugiacaohientai"],
//            ),
//          );
//        });
//  }
//}
//
//class Sanpham_don extends StatelessWidget {
//  final ten_sp;
//  final hinh_sp;
//  final gia_sp_moi;
//  final thoi_gian;
//  final nguoi_giu_gia_cao_hien_tai;
//
//  Sanpham_don(
//      {this.ten_sp,
//      this.hinh_sp,
//      this.gia_sp_moi,
//      this.thoi_gian,
//      this.nguoi_giu_gia_cao_hien_tai});
//
//  @override
//  Widget build(BuildContext context) {
//    return Card(
//        child: Hero(
//      tag: ten_sp,
//      child: Material(
//        child: GridTile(
//          footer: Container(
//              color: Colors.white70,
//              child: Column(
//                children: <Widget>[
//                  new Row(
//                    children: <Widget>[
//                      Expanded(
//                        child: new Text(
//                          ten_sp,
//                          style: TextStyle(
//                              fontWeight: FontWeight.bold, fontSize: 13.0),
//                        ),
//                      ),
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Row(
//                            children: <Widget>[
//                              Image.asset('images/miniicon/minibid.png'),
//                              new Text(
//                                "   ${gia_sp_moi} \ VND",
//                                style: TextStyle(
//                                    color: Colors.red, fontWeight: FontWeight.bold,  fontSize: 10.0),
//                              ),
//                            ],
//                          ),
//                          Row(
//                            children: <Widget>[
//                              Image.asset('images/miniicon/miniclock.png'),
//                              new Text(
//                                "   ${thoi_gian}",
//                                style: TextStyle(
//                                    color: Colors.red, fontWeight: FontWeight.bold,  fontSize: 10.0),
//                              ),
//                            ],
//                          ),
//                          Row(
//                            children: <Widget>[
//                              Image.asset('images/miniicon/miniuser.png'),
//                              new Text(
//                                "   ${nguoi_giu_gia_cao_hien_tai}",
//                                style: TextStyle(
//                                    color: Colors.red, fontWeight: FontWeight.bold,  fontSize: 10.0),
//                              ),
//                            ],
//                          ),
//                        ],
//                      ),
//
//                    ],
//                  ),
//                ],
//              )),
//          child: Image.asset(
//            hinh_sp,
//            fit: BoxFit.cover,
//          ),
//        ),
//      ),
//    ));
//  }
//}
