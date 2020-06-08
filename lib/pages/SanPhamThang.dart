import 'dart:convert';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutterhappjapp/api/server.dart';
import 'package:flutterhappjapp/model/Product.dart';
import 'package:flutterhappjapp/model/User.dart';
import 'package:flutterhappjapp/pages/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'Chat.dart';

class SanPhamThang extends StatefulWidget {
  @override
  _SanPhamThangState createState() => _SanPhamThangState();
}

class _SanPhamThangState extends State<SanPhamThang> {
  DatabaseReference itemRef;
  String idUser;
  List<Product> listData = new List();
  List<User> listUser = new List();

  Future<dynamic> getInfo(String id) async {
    final response = await http.get(Server.getInfoUser + id);
    var a = json.decode(response.body);
    return a['data'];
  }

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
              //grid view
              new StreamBuilder(
                stream: itemRef.orderByChild("hide").equalTo(false).onValue,
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
                    print('begin san pham thang');
                    Map data = snapshot.data.snapshot.value;
                    data.forEach((index, data) {
                      if ((DateTime.now().millisecondsSinceEpoch -
                              int.parse(data['extraTime']) >
                          0)) {
                        List winner = new List();
                        winner.addAll(data['winner']);
                        if (winner[1].toString() == idUser) {
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

                    return Flexible(
                        child: Sanpham(
                      product: listData,
                      s: "Bạn chưa đấu giá thắng sản phẩm nào!",
                    ));
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
            "Sản Phẩm Thắng",
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

class Sanpham extends StatelessWidget {
  final List<Product> product;

  final String s;

  Sanpham({this.product, this.s});

  @override
  Widget build(BuildContext context) {
    return product.length != 0
        ? Container(
            height: 600.0,
            width: double.infinity,
            child: new ListView.builder(
                itemCount: product.length,
                itemBuilder: (BuildContext context, int index) {
                  return new buildCard(
                    name: product[index].name,
                    sdtNguoiBan: "Đang tải",
                    money: product[index].startPrice,
                    tenNguoBan: "Đang tải",
                    url: product[index].img[0],
                    ngay: product[index].registerDate,
                    idNguoiBan: product[index].userId,
                    keyy: product[index].key,
                  );
                }),
          )
        : Container(
            padding: EdgeInsets.all(20.0),
            width: MediaQuery.of(context).size.width,
            height: 550,
            child: Text(s,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0)),
          );
  }
}

class buildCard extends StatefulWidget {
  String url;
  String name;
  String money;
  String tenNguoBan;
  String sdtNguoiBan;
  int ngay;
  String idNguoiBan;
  String keyy;

  buildCard(
      {this.url,
      this.name,
      this.money,
      this.tenNguoBan,
      this.sdtNguoiBan,
      this.ngay,
      this.idNguoiBan,
      this.keyy});

  @override
  _buildCardState createState() => _buildCardState();
}

class _buildCardState extends State<buildCard> {
  String name, phone;

  Future<dynamic> getInfo() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final response = await http
          .get(Server.getInfoUser + sharedPreferences.getString('_id'));
      var a = json.decode(response.body);
      name = a['name'];
      phone = a['phone'];
      return a;
    } catch (e) {
      print(e);
    }
  }

  outputMoney(var money) {
    return "${FlutterMoneyFormatter(settings: MoneyFormatterSettings(
          symbol: 'VND',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: 0,
        ), amount: double.parse(money)).output.symbolOnRight}";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = "";
    phone = "";
    getInfo().then((value) {
      setState(() {
        name = value['name'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "${DateTime.fromMicrosecondsSinceEpoch(widget.ngay * 1000).day.toString()}/"
          "${DateTime.fromMicrosecondsSinceEpoch(widget.ngay * 1000).month.toString()}/"
          "${DateTime.fromMicrosecondsSinceEpoch(widget.ngay * 1000).year.toString()}  ",
          style: TextStyle(fontSize: 25.0, color: Colors.black),
        ),
        ExpansionCard(
          borderRadius: 10,
          background: Image.network(
            Server.hinhAnh + widget.url,
            fit: BoxFit.cover,
          ),
          title: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Giá Thắng: ${outputMoney(widget.money)}",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
          ),
          children: <Widget>[
            InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name == ""
                          ? "Tên Người Bán: ${widget.tenNguoBan}"
                          : "Tên Người Bán: $name",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    Text(
                      phone == ""
                          ? "Số Điện Thoại: ${widget.sdtNguoiBan}"
                          : "Số Điện Thoại: $phone",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    Text(
                      "Địa chỉ giao dịch: ***",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Controll(
                            keyy: widget.keyy,
                          )));},
                      child: Text(
                        "Chat với người giao dịch",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    ButtonTheme(
                      minWidth: 100,
                      height: 50.0,
                      child: RaisedButton.icon(
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Controll(
                                    keyy: widget.keyy,
                                  )));
                        },
                        icon: Icon(CommunityMaterialIcons.alarm),
                        label: Text('1'),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 20.0,
        )
      ],
    );
  }
}
