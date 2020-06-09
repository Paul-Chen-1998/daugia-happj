import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterhappjapp/model/Product.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePage.dart';

class SanPhamDangThua extends StatefulWidget {
  @override
  _SanPhamDangThuaState createState() => _SanPhamDangThuaState();
}

class _SanPhamDangThuaState extends State<SanPhamDangThua> {
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
                stream: itemRef.onValue,
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
                    print('begin san pham dang thua');
                    Map data = snapshot.data.snapshot.value;
                    data.forEach((index, data) {
                      if ((int.parse(data['extraTime']) -
                              DateTime.now().millisecondsSinceEpoch >
                          0)) {
                        List winner = new List();
                        winner.addAll(data['winner']);
                        List played = new List();
                        played.addAll(data['played']);
                        for (var item in played) {
                          if (idUser.trim().toString() == item) {
                            if(winner[1].toString() != idUser.trim().toString() )
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
                      }
                    });

                    return Flexible(child: Sanpham(list: listData,s: "Bạn chưa đấu giá thua sản phẩm nào!",));
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
            "Sản Phẩm Đang Thua",
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
